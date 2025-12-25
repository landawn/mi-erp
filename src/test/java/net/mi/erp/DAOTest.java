package net.mi.erp;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;

import com.landawn.abacus.jdbc.JdbcUtil;
import com.landawn.abacus.util.N;

import net.mi.erp.dao.AddressDAO;
import net.mi.erp.dao.EmployeeAddressDAO;
import net.mi.erp.dao.EmployeeDAO;
import net.mi.erp.dao.ProjectDAO;
import net.mi.erp.entity.Address;
import net.mi.erp.entity.Employee;
import net.mi.erp.entity.EmployeeAddress;
import net.mi.erp.entity.Project;

public class DAOTest {

    static final String url = "jdbc:mysql://localhost:3306/mi_erp";
    static final DataSource dataSource = JdbcUtil.createHikariDataSource(url, "root", "admin");

    static final ProjectDAO projectDAO = JdbcUtil.createDao(ProjectDAO.class, dataSource);
    static final EmployeeDAO employeeDAO = JdbcUtil.createDao(EmployeeDAO.class, dataSource);
    static final AddressDAO addressDAO = JdbcUtil.createDao(AddressDAO.class, dataSource);
    static final EmployeeAddressDAO employeeAddressDAO = JdbcUtil.createDao(EmployeeAddressDAO.class, dataSource);

    @Test
    public void test_dao_01() {
        Project project = Project.builder().name("proj-001").build();

        int id = projectDAO.insert(project);

        Project projectFromDB = projectDAO.gett(id);
        N.println(projectFromDB);

        projectDAO.deleteById(id);

        N.println(projectDAO.gett(id));

    }

    @Test
    public void test_dao_02() {
        // employeeDAO.delete(Filters.alwaysTrue());

        Employee employee = Employee.builder().employeeNo(123).firstName("coderA").lastName("la").build();
        Address address = Address.builder().addressLine("123 main street").city("Sunnyvale").state("ca").countryCode("us").postalCode("55213").build();

        int employeeId = employeeDAO.insert(employee);
        int addressId = addressDAO.insert(address);

        Employee employeeFromDB = employeeDAO.gett(employeeId);
        Address addressFromDB = addressDAO.gett(addressId);

        N.println(employeeFromDB);
        N.println(addressFromDB);

        EmployeeAddress employeeAddress = EmployeeAddress.builder().employeeId(employeeId).addressId(addressId).build();

        employeeAddressDAO.insert(employeeAddress);

        employeeDAO.loadJoinEntities(employeeFromDB, Address.class);

        N.println(employeeFromDB);

        employeeDAO.deleteById(employeeId);
        addressDAO.deleteById(addressId);

        N.println(employeeDAO.gett(employeeId));
        N.println(addressDAO.gett(addressId));
    }

}
