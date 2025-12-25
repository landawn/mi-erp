package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Address;

public interface AddressDAO extends UncheckedCrudDao<Address, Long, SQLBuilder.PSC, AddressDAO> {

}
