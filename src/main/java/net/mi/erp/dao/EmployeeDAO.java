package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedCrudJoinEntityHelper;

import net.mi.erp.entity.Employee;

public interface EmployeeDAO extends UncheckedCrudDao<Employee, Integer, EmployeeDAO>,
        UncheckedCrudJoinEntityHelper<Employee, Integer, EmployeeDAO> {

}
