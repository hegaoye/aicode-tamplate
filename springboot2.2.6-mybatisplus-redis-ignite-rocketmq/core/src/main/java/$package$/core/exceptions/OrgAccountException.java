/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgAccountException extends BaseException implements Serializable {
    public OrgAccountException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgAccountException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgAccountException(String message) {
        super(message);
    }

    public OrgAccountException(String message, Throwable cause) {
        super(message, cause);
    }
}
