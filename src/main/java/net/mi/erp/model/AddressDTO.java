package net.mi.erp.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = false)
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

    private String comments;

    private java.sql.Timestamp lastUpdatedTime;

    private java.sql.Timestamp createdTime;

}
