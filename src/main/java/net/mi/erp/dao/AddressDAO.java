package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.CrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Address;

public interface AddressDAO extends CrudDao<Address, Integer, SQLBuilder.PSC, AddressDAO> {

}
