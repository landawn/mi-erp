package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.EmployeeAddressMap;

public interface EmployeeAddressMapDAO extends UncheckedCrudDao<EmployeeAddressMap, Long, SQLBuilder.PSC, EmployeeAddressMapDAO> {

}
