/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class RoleGroupMemberException extends BaseException implements Serializable {
    public RoleGroupMemberException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public RoleGroupMemberException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public RoleGroupMemberException(String message) {
        super(message);
    }

    public RoleGroupMemberException(String message, Throwable cause) {
        super(message, cause);
    }
}
