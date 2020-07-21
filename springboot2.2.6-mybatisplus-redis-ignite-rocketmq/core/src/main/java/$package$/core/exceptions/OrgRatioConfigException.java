/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgRatioConfigException extends BaseException implements Serializable {
    public OrgRatioConfigException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgRatioConfigException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgRatioConfigException(String message) {
        super(message);
    }

    public OrgRatioConfigException(String message, Throwable cause) {
        super(message, cause);
    }
}
