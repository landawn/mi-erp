package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;

import net.mi.erp.entity.Address;

public interface AddressDAO extends UncheckedCrudDao<Address, Integer, AddressDAO> {

}
