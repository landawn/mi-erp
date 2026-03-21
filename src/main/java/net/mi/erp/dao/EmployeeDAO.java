package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;
import com.landawn.abacus.query.SqlBuilder;

import net.mi.erp.entity.Employee;

public interface EmployeeDAO extends UncheckedCrudDao<Employee, Integer, SqlBuilder.PSC, EmployeeDAO>,
        UncheckedCrudJoinEntityHelper<Employee, Integer, SqlBuilder.PSC, EmployeeDAO> {

}
