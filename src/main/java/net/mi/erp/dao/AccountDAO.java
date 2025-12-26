package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Account;

public interface AccountDAO extends UncheckedCrudDao<Account, Integer, SQLBuilder.PSC, AccountDAO> {

}
