package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;

import net.mi.erp.entity.AclGroup;

public interface AclGroupDAO extends UncheckedCrudDao<AclGroup, Integer, AclGroupDAO>,
        UncheckedCrudJoinEntityHelper<AclGroup, Integer, AclGroupDAO> {

}
