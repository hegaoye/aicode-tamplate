/*
* config1
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapPlayMethodConfigException extends BaseException implements Serializable {
    public HandicapPlayMethodConfigException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapPlayMethodConfigException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapPlayMethodConfigException(String message) {
        super(message);
    }

    public HandicapPlayMethodConfigException(String message, Throwable cause) {
        super(message, cause);
    }
}
