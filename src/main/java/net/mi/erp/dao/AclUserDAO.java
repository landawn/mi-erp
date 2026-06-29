package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;

import net.mi.erp.entity.AclUser;

public interface AclUserDAO
        extends UncheckedCrudDao<AclUser, Integer, AclUserDAO>, UncheckedCrudJoinEntityHelper<AclUser, Integer, AclUserDAO> {

}
