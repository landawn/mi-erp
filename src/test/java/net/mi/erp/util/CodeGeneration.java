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

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.landawn.abacus.annotation.JoinedBy;
import com.landawn.abacus.jdbc.JdbcCodeGenerationUtil;
import com.landawn.abacus.jdbc.JdbcCodeGenerationUtil.EntityCodeConfig;
import com.landawn.abacus.jdbc.JdbcUtil;
import com.landawn.abacus.util.ClassUtil;
import com.landawn.abacus.util.CodeGenerationUtil;
import com.landawn.abacus.util.IOUtil;
import com.landawn.abacus.util.N;

class CodeGeneration {
    static final String LINE_SEPARATOR = IOUtil.LINE_SEPARATOR_UNIX;

    static final String url = "jdbc:mysql://localhost:3306/mi_erp";
    static final DataSource dataSource = JdbcUtil.createHikariDataSource(url, "root", "admin");

    public static void main(String[] args) throws Exception {
        generateEntityClass();

        generateFieldNameClass();
    }

    static void generateEntityClass() throws SQLException {

        // List<String> tableNames = List.of("employee", "address", "employee_address", "project");

        List<String> tableNames = JdbcUtil
                .prepareQuery(dataSource, "SELECT table_name FROM information_schema.tables  where table_schema = 'mi_erp' ORDER BY table_name")
                .list(String.class);

        final Map<String, String> additionLinesMap = new HashMap<>();
        additionLinesMap.put("employee", """
                    @JoinedBy({ "id=EmployeeAddress.employeeId", "EmployeeAddress.addressId=Address.id" })
                    private List<Address> addresses;
                """);

        final Map<String, List<String>> classNamesToImportMap = new HashMap<>();
        classNamesToImportMap.put("employee", List.of(ClassUtil.getCanonicalClassName(JoinedBy.class)));

        EntityCodeConfig ecc = EntityCodeConfig.builder()
                .packageName("net.mi.erp.entity")
                .srcDir("./src/main/java")
                .idField("id")
                .readOnlyFields(N.asSet("id", "uuid", "createdTime", "lastUpdatedTime"))
                .fieldTypeConverter((_, _, columnName, columnClassName) -> columnName.equalsIgnoreCase("record_status") ? "RecordStatus" : columnClassName)
                // .customizedFieldDbTypes(N.asList(Tuple.of("recordStatus", "enumerated = EnumBy.ORDINAL")))
                // .classNamesToImport(N.asList(ClassUtil.getCanonicalClassName(EnumBy.class), ClassUtil.getCanonicalClassName(RecordStatus.class)))
                .generateBuilder(true)
                .chainAccessor(false)
                // .generateFieldNameTable(true)
                .build();

        for (String tableName : tableNames) {
            ecc.setAdditionalFieldsOrLines(additionLinesMap.get(tableName));
            ecc.setClassNamesToImport(classNamesToImportMap.get(tableName));

            JdbcCodeGenerationUtil.generateEntityClass(dataSource, tableName, ecc);
        }
    }

    static void generateFieldNameClass() {
        List<Class<?>> entityClasses = ClassUtil.getClassesByPackage("net.mi.erp.entity", false, false);

        CodeGenerationUtil.generatePropNameTableClasses(entityClasses, "x", "net.mi.erp.entity", "./src/main/java/");

        //    String header = """
        //            package net.mi.erp.util;
        //
        //            /**
        //             * String constant class for entity field name
        //             */
        //            public abstract class x {
        //                private x() {
        //                    // utility class.
        //                }
        //
        //            """;
        //
        //    String tail = """
        //
        //                public static final class fn extends x {
        //                    private fn() {
        //                        // utility class.
        //                    }
        //                }
        //            }
        //            """;
        //
        //    String content = Stream.of(entityClasses)
        //            .flatmap(it -> Beans.getPropNameList(it).stream().map(e -> Pair.of(e, it.getSimpleName())).toList())
        //            .groupBy(it -> it.left(), it -> it.right())
        //            .sortedBy(it -> it.getKey())
        //            .map(it -> {
        //                String field = "    /** field name in entities: " + it.getValue().stream().sorted().toList() + " */" + LINE_SEPARATOR
        //                        + "    public static final String " + it.getKey() + " = \"" + it.getKey() + "\";" + LINE_SEPARATOR;
        //                return field;
        //            })
        //            .join(LINE_SEPARATOR, header, tail);
        //
        //    File file = new File("./src/main/java/net/mi/erp/util/x.java");
        //
        //    IOUtil.write(content, file);
    }

}
