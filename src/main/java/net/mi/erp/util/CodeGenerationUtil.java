/*
 * Copyright (C) 2024 HaiYang Li
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package net.mi.erp.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.landawn.abacus.annotation.Type.EnumBy;
import com.landawn.abacus.jdbc.JdbcCodeGenerationUtil;
import com.landawn.abacus.jdbc.JdbcCodeGenerationUtil.EntityCodeConfig;
import com.landawn.abacus.jdbc.JdbcUtil;
import com.landawn.abacus.util.ClassUtil;
import com.landawn.abacus.util.N;
import com.landawn.abacus.util.Tuple;

import net.mi.erp.model.RecordStatus;

class CodeGenerationUtil {

    static final String url = "jdbc:mysql://localhost:3306/mi_erp";
    static final DataSource dataSource = JdbcUtil.createHikariDataSource(url, "root", "admin");

    public static void main(String[] args) {
        generateEntityClass();
    }

    static void generateEntityClass() {

        List<String> tableNames = List.of("employee", "address", "employee_address_map", "project");

        Map<String, String> additionLinesMap = new HashMap<>();

        additionLinesMap.put("employee", """
                    @JoinedBy({ "id=EmployeeAddressMap.employeeId", "EmployeeAddressMap.addressId=Address.id" })
                    private List<Address> addresses;
                """);

        EntityCodeConfig ecc = EntityCodeConfig.builder()
                .packageName("net.mi.erp.entity")
                .srcDir("./src/main/java")
                .idField("id")
                .readOnlyFields(N.asSet("id", "uuid", "createdTime", "lastUpdatedTime"))
                .fieldTypeConverter((_, _, columnName, columnClassName) -> columnName.equalsIgnoreCase("record_status") ? "RecordStatus" : columnClassName)
                .customizedFieldDbTypes(N.asList(Tuple.of("recordStatus", "enumerated = EnumBy.ORDINAL")))
                .classNamesToImport(N.asList(ClassUtil.getCanonicalClassName(EnumBy.class), ClassUtil.getCanonicalClassName(RecordStatus.class)))
                .generateBuilder(true)
                // .generateFieldNameTable(true)
                .build();

        for (String tableName : tableNames) {
            String additionLines = additionLinesMap.get(tableName);
            ecc.setAdditionalFieldsOrLines(additionLines);
            JdbcCodeGenerationUtil.generateEntityClass(dataSource, tableName, ecc);
        }
    }

}
