/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgAccountRoleException extends BaseException implements Serializable {
    public OrgAccountRoleException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgAccountRoleException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgAccountRoleException(String message) {
        super(message);
    }

    public OrgAccountRoleException(String message, Throwable cause) {
        super(message, cause);
    }
}
