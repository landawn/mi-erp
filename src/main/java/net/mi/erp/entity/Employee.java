package net.mi.erp.entity;
import java.util.List;

import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.JoinedBy;
import com.landawn.abacus.annotation.ReadOnly;
import com.landawn.abacus.annotation.Table;
import com.landawn.abacus.annotation.Type;
import com.landawn.abacus.annotation.Type.EnumBy;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import net.mi.erp.model.RecordStatus;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name = "employee")
public class Employee {

    @Id
    @ReadOnly
    @Column(name = "id")
    private long id;

    @ReadOnly
    @Column(name = "uuid")
    private String uuid;

    @Column(name = "employee_no")
    private long employeeNo;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "middle_name")
    private String middleName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "record_status")
    @Type(enumerated = EnumBy.ORDINAL)
    private RecordStatus recordStatus;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

    @JoinedBy({ "id=EmployeeAddressMap.employeeId", "EmployeeAddressMap.addressId=Address.id" })
    private List<Address> addresses;

}
