package net.mi.erp.entity;

import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.ReadOnly;
import com.landawn.abacus.annotation.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "address")
public class Address {

    @Id
    @ReadOnly
    @Column(name = "id")
    private int id;

    @Column(name = "address_line")
    private String addressLine;

    @Column(name = "address_line2")
    private String addressLine2;

    @Column(name = "unit_number")
    private String unitNumber;

    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "postal_code")
    private String postalCode;

    @Column(name = "country_code")
    private String countryCode;

    @Column(name = "type")
    private int type;

    @Column(name = "comments")
    private String comments;

    @Column(name = "is_primary")
    private boolean isPrimary;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

}
