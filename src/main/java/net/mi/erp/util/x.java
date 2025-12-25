package net.mi.erp.util;

/**
 * String constant class for entity field name
 */
public abstract class x {
    private x() {
        // utility class.
    }

    /** field name in entities: [EmployeeAddress] */
    public static final String addressId = "addressId";

    /** field name in entities: [Address] */
    public static final String addressLine = "addressLine";

    /** field name in entities: [Address] */
    public static final String addressLine2 = "addressLine2";

    /** field name in entities: [Employee] */
    public static final String addresses = "addresses";

    /** field name in entities: [Address] */
    public static final String city = "city";

    /** field name in entities: [Project] */
    public static final String code = "code";

    /** field name in entities: [Address] */
    public static final String countryCode = "countryCode";

    /** field name in entities: [Address, Employee, EmployeeAddress, Project] */
    public static final String createdTime = "createdTime";

    /** field name in entities: [Project] */
    public static final String description = "description";

    /** field name in entities: [EmployeeAddress] */
    public static final String employeeId = "employeeId";

    /** field name in entities: [Employee] */
    public static final String employeeNo = "employeeNo";

    /** field name in entities: [Project] */
    public static final String endDate = "endDate";

    /** field name in entities: [Employee] */
    public static final String firstName = "firstName";

    /** field name in entities: [Address, Employee, EmployeeAddress, Project] */
    public static final String id = "id";

    /** field name in entities: [Address] */
    public static final String isPrimary = "isPrimary";

    /** field name in entities: [Employee] */
    public static final String lastName = "lastName";

    /** field name in entities: [Address, Employee, EmployeeAddress, Project] */
    public static final String lastUpdatedTime = "lastUpdatedTime";

    /** field name in entities: [Employee] */
    public static final String middleName = "middleName";

    /** field name in entities: [Project] */
    public static final String name = "name";

    /** field name in entities: [Address] */
    public static final String postalCode = "postalCode";

    /** field name in entities: [Project] */
    public static final String startDate = "startDate";

    /** field name in entities: [Address] */
    public static final String state = "state";

    /** field name in entities: [Address] */
    public static final String type = "type";

    /** field name in entities: [Address] */
    public static final String unitNumber = "unitNumber";

    /** field name in entities: [Employee, Project] */
    public static final String uuid = "uuid";

    public static final class fn extends x {
        private fn() {
            // utility class.
        }
    }
}
