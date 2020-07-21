/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class DepartmentRoleException extends BaseException implements Serializable {
    public DepartmentRoleException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public DepartmentRoleException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public DepartmentRoleException(String message) {
        super(message);
    }

    public DepartmentRoleException(String message, Throwable cause) {
        super(message, cause);
    }
}
