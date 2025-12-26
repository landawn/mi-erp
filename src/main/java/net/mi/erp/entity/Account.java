package net.mi.erp.entity;

import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.ReadOnly;
import com.landawn.abacus.annotation.Table;
import com.landawn.abacus.annotation.Type;
import com.landawn.abacus.util.EnumType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "account")
public class Account {

    @Id
    @ReadOnly
    @Column(name = "id")
    private int id;

    @ReadOnly
    @Column(name = "uuid")
    private String uuid;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "middle_name")
    private String middleName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "birth_date")
    private java.sql.Date birthDate;

    @Column(name = "email_address")
    private String emailAddress;

    @Column(name = "status")
    @Type(enumerated = EnumType.CODE)
    private net.mi.erp.model.UnifiedStatus status;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

}
