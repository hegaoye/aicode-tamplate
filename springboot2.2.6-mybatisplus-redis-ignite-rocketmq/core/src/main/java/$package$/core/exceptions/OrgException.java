/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgException extends BaseException implements Serializable {
    public OrgException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgException(String message) {
        super(message);
    }

    public OrgException(String message, Throwable cause) {
        super(message, cause);
    }
}
