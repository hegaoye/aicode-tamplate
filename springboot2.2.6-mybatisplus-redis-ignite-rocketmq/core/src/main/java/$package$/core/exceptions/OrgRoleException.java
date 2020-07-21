/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgRoleException extends BaseException implements Serializable {
    public OrgRoleException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgRoleException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgRoleException(String message) {
        super(message);
    }

    public OrgRoleException(String message, Throwable cause) {
        super(message, cause);
    }
}
