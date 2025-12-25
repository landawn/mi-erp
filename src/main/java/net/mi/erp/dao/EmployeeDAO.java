package net.mi.erp.dao;

import com.landawn.abacus.jdbc.dao.UncheckedCrudDao;
import com.landawn.abacus.jdbc.dao.UncheckedJoinEntityHelper;
import com.landawn.abacus.query.SQLBuilder;

import net.mi.erp.entity.Employee;

public interface EmployeeDAO
        extends UncheckedCrudDao<Employee, Long, SQLBuilder.PSC, EmployeeDAO>, UncheckedJoinEntityHelper<Employee, SQLBuilder.PSC, EmployeeDAO> {

}
