/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class RoleGroupException extends BaseException implements Serializable {
    public RoleGroupException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public RoleGroupException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public RoleGroupException(String message) {
        super(message);
    }

    public RoleGroupException(String message, Throwable cause) {
        super(message, cause);
    }
}
