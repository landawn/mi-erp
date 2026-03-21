package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.EmployeeAddress;

public interface EmployeeAddressDAO extends UncheckedCrudDao<EmployeeAddress, Integer, SqlBuilder.PSC, EmployeeAddressDAO> {

}
