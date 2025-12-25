package net.mi.erp.entity;

import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.ReadOnly;
import com.landawn.abacus.annotation.Table;
import com.landawn.abacus.annotation.Type;

import com.landawn.abacus.annotation.Type.EnumBy;
import net.mi.erp.model.RecordStatus;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name = "employee_address_map")
public class EmployeeAddressMap {

    @Id
    @ReadOnly
    @Column(name = "id")
    private long id;

    @Column(name = "employee_id")
    private long employeeId;

    @Column(name = "address_id")
    private long addressId;

    @Column(name = "record_status")
    @Type(enumerated = EnumBy.ORDINAL)
    private RecordStatus recordStatus;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

}
