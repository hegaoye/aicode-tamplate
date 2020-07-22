/*
* config1
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapConfigException extends BaseException implements Serializable {
    public HandicapConfigException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapConfigException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapConfigException(String message) {
        super(message);
    }

    public HandicapConfigException(String message, Throwable cause) {
        super(message, cause);
    }
}
