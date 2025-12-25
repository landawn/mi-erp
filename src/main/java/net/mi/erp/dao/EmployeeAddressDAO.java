package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.EmployeeAddress;

public interface EmployeeAddressDAO extends UncheckedCrudDao<EmployeeAddress, Integer, SQLBuilder.PSC, EmployeeAddressDAO> {

}
