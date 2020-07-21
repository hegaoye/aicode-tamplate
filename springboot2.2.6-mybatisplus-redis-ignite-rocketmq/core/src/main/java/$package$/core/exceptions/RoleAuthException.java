/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class RoleAuthException extends BaseException implements Serializable {
    public RoleAuthException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public RoleAuthException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public RoleAuthException(String message) {
        super(message);
    }

    public RoleAuthException(String message, Throwable cause) {
        super(message, cause);
    }
}
