package net.mi.erp.entity;
import java.util.List;


import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.ReadOnly;
import com.landawn.abacus.annotation.Table;

import com.landawn.abacus.annotation.JoinedBy;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "employee")
public class Employee {

    @Id
    @ReadOnly
    @Column(name = "id")
    private int id;

    @ReadOnly
    @Column(name = "uuid")
    private String uuid;

    @Column(name = "employee_no")
    private int employeeNo;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "middle_name")
    private String middleName;

    @Column(name = "last_name")
    private String lastName;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

    @JoinedBy({ "id=EmployeeAddress.employeeId", "EmployeeAddress.addressId=Address.id" })
    private List<Address> addresses;

}
