/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerRatioConfigException extends BaseException implements Serializable {
    public PlayerRatioConfigException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerRatioConfigException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerRatioConfigException(String message) {
        super(message);
    }

    public PlayerRatioConfigException(String message, Throwable cause) {
        super(message, cause);
    }
}
