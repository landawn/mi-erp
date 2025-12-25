package net.mi.erp.dto;

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
public class AddressDTO {

    private int id;
    private String addressLine;

    private String addressLine2;

    private String unitNumber;

    private String city;

    private String state;

    private String postalCode;

    private String countryCode;

    private int type;

    private boolean isPrimary;

    private java.sql.Timestamp lastUpdatedTime;

    private java.sql.Timestamp createdTime;

}
