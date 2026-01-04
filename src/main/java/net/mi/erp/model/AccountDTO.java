package net.mi.erp.model;

import com.landawn.abacus.annotation.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "account")
public class AccountDTO {
    private String firstName;

    private String middleName;

    private String lastName;

    private java.sql.Date birthDate;

    private String gender;

    private String emailAddress;

    private String type;

    private String status;

}
