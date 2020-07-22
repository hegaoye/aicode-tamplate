/*
* config1
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapBetOptionConfigException extends BaseException implements Serializable {
    public HandicapBetOptionConfigException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapBetOptionConfigException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapBetOptionConfigException(String message) {
        super(message);
    }

    public HandicapBetOptionConfigException(String message, Throwable cause) {
        super(message, cause);
    }
}
