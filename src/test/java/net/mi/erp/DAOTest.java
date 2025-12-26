package net.mi.erp;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;

import com.landawn.abacus.jdbc.JdbcUtil;
import com.landawn.abacus.util.N;

import net.mi.erp.dao.AccountDAO;
import net.mi.erp.dao.AddressDAO;
import net.mi.erp.dao.EmployeeAddressDAO;
import net.mi.erp.dao.EmployeeDAO;
import net.mi.erp.dao.LoginDAO;
import net.mi.erp.dao.ProjectDAO;
import net.mi.erp.entity.Account;
import net.mi.erp.entity.Address;
import net.mi.erp.entity.Employee;
import net.mi.erp.entity.EmployeeAddress;
import net.mi.erp.entity.Login;
import net.mi.erp.entity.Project;
import net.mi.erp.model.UnifiedStatus;

public class DAOTest {

    static final String url = "jdbc:mysql://localhost:3306/mi_erp";
    static final DataSource dataSource = JdbcUtil.createHikariDataSource(url, "root", "admin");

    static final AccountDAO accountDAO = JdbcUtil.createDao(AccountDAO.class, dataSource);
    static final LoginDAO loginDAO = JdbcUtil.createDao(LoginDAO.class, dataSource);
    static final ProjectDAO projectDAO = JdbcUtil.createDao(ProjectDAO.class, dataSource);
    static final EmployeeDAO employeeDAO = JdbcUtil.createDao(EmployeeDAO.class, dataSource);
    static final AddressDAO addressDAO = JdbcUtil.createDao(AddressDAO.class, dataSource);
    static final EmployeeAddressDAO employeeAddressDAO = JdbcUtil.createDao(EmployeeAddressDAO.class, dataSource);

    @Test
    public void test_LoginDAO() {
        Account account = Account.builder().firstName("Jack").lastName("Johnson").emailAddress("jack@email.com").status(UnifiedStatus.ACTIVE).build();
        int accountId = accountDAO.insert(account);
        Account accountFromDB = accountDAO.gett(accountId);
        N.println(accountFromDB);

        Login login = Login.builder().accountId(accountId).loginId("Jack_Johnson").loginPassword("123").status(UnifiedStatus.ACTIVE).build();
        int loginId = loginDAO.insert(login);
        Login loginFromDB = loginDAO.gett(loginId);
        N.println(loginFromDB);

        loginDAO.loadJoinEntities(loginFromDB, Account.class);
        N.println(loginFromDB);
        N.println(loginFromDB.getAccount());

        accountDAO.deleteById(accountId);
        loginDAO.deleteById(accountId);

        N.println(accountDAO.gett(accountId));
        N.println(loginDAO.gett(loginId));

    }

    @Test
    public void test_ProjectDAO() {
        Project project = Project.builder().name("proj-001").status(UnifiedStatus.ACTIVE).build();

        int id = projectDAO.insert(project);

        Project projectFromDB = projectDAO.gett(id);
        N.println(projectFromDB);

        projectDAO.deleteById(id);

        N.println(projectDAO.gett(id));

    }

    @Test
    public void test_EmployeeDAO() {
        // employeeDAO.delete(Filters.alwaysTrue());

        Employee employee = Employee.builder().employeeNo(123).firstName("coderA").lastName("la").status(UnifiedStatus.ACTIVE).build();
        Address address = Address.builder()
                .addressLine("123 main street")
                .city("Sunnyvale")
                .state("ca")
                .countryCode("us")
                .postalCode("55213")
                .status(UnifiedStatus.ACTIVE)
                .build();

        int employeeId = employeeDAO.insert(employee);
        int addressId = addressDAO.insert(address);

        Employee employeeFromDB = employeeDAO.gett(employeeId);
        Address addressFromDB = addressDAO.gett(addressId);

        N.println(employeeFromDB);
        N.println(addressFromDB);

        EmployeeAddress employeeAddress = EmployeeAddress.builder().employeeId(employeeId).addressId(addressId).status(UnifiedStatus.ACTIVE).build();

        employeeAddressDAO.insert(employeeAddress);

        employeeDAO.loadJoinEntities(employeeFromDB, Address.class);

        N.println(employeeFromDB);

        employeeDAO.deleteById(employeeId);
        addressDAO.deleteById(addressId);

        N.println(employeeDAO.gett(employeeId));
        N.println(addressDAO.gett(addressId));
    }

}
