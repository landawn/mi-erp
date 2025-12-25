package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.CrudDao;
import com.landawn.abacus.jdbc.dao.JoinEntityHelper;
import com.landawn.abacus.query.SQLBuilder;
import com.landawn.abacus.samples.entity.Employee;

public interface EmployeeDAO extends CrudDao<Employee, Integer, SQLBuilder.PSC, EmployeeDAO>, JoinEntityHelper<Employee, SQLBuilder.PSC, EmployeeDAO> {

}
