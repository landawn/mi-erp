package net.mi.erp.entity;

import com.landawn.abacus.annotation.Column;
import com.landawn.abacus.annotation.Id;
import com.landawn.abacus.annotation.ReadOnly;
import com.landawn.abacus.annotation.Table;
import com.landawn.abacus.annotation.Type;
import com.landawn.abacus.annotation.Type.EnumBy;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "acl_group")
public class AclGroup {

    @Id
    @ReadOnly
    @Column(name = "id")
    private int id;

    @ReadOnly
    @Column(name = "uuid")
    private String uuid;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "status")
    @Type(enumerated = EnumBy.ORDINAL)
    private net.mi.erp.model.UnifiedStatus status;

    @ReadOnly
    @Column(name = "last_updated_time")
    private java.sql.Timestamp lastUpdatedTime;

    @ReadOnly
    @Column(name = "created_time")
    private java.sql.Timestamp createdTime;

}
