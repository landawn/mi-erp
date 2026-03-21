package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.AclUser;

public interface AclUserDAO
        extends UncheckedCrudDao<AclUser, Integer, SqlBuilder.PSC, AclUserDAO>, UncheckedCrudJoinEntityHelper<AclUser, Integer, SqlBuilder.PSC, AclUserDAO> {

}
