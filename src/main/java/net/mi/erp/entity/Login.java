package net.mi.erp.entity;

import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.JoinedBy;
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
@Table(name = "login")
public class Login {

    @Id
    @ReadOnly
    @Column(name = "id")
    private int id;

    @Column(name = "account_id")
    private int accountId;

    @Column(name = "login_id")
    private String loginId;

    @Column(name = "login_password")
    private String loginPassword;

    @Column(name = "last_login_time")
    private java.sql.Timestamp lastLoginTime;

    @Column(name = "status")
    @Type(enumerated = EnumType.CODE)
    private net.mi.erp.model.UnifiedStatus status;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

    @JoinedBy("accountId=Account.id")
    private Account account;

}
