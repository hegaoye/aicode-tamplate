/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class DepartmentException extends BaseException implements Serializable {
    public DepartmentException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public DepartmentException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public DepartmentException(String message) {
        super(message);
    }

    public DepartmentException(String message, Throwable cause) {
        super(message, cause);
    }
}
