package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.Account;

public interface AccountDAO extends UncheckedCrudDao<Account, Integer, SqlBuilder.PSC, AccountDAO> {

}
