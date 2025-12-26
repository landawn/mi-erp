package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.AclGroup;

public interface AclGroupDAO extends UncheckedCrudDao<AclGroup, Integer, SQLBuilder.PSC, AclGroupDAO>,
        UncheckedCrudJoinEntityHelper<AclGroup, Integer, SQLBuilder.PSC, AclGroupDAO> {

}
