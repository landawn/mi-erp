package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.AclUser;

public interface AclUserDAO extends UncheckedCrudDao<AclUser, Integer, SQLBuilder.PSC, AclUserDAO> {

}
