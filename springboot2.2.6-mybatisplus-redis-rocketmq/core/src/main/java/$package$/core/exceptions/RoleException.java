/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class RoleException extends BaseException implements Serializable {
    public RoleException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public RoleException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public RoleException(String message) {
        super(message);
    }

    public RoleException(String message, Throwable cause) {
        super(message, cause);
    }
}
