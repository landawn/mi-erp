package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.AclGroup;

public interface AclGroupDAO extends UncheckedCrudDao<AclGroup, Integer, SqlBuilder.PSC, AclGroupDAO>,
        UncheckedCrudJoinEntityHelper<AclGroup, Integer, SqlBuilder.PSC, AclGroupDAO> {

}
