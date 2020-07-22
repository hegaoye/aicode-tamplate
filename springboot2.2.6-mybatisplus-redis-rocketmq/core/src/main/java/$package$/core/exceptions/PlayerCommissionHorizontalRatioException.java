/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerCommissionHorizontalRatioException extends BaseException implements Serializable {
    public PlayerCommissionHorizontalRatioException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerCommissionHorizontalRatioException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerCommissionHorizontalRatioException(String message) {
        super(message);
    }

    public PlayerCommissionHorizontalRatioException(String message, Throwable cause) {
        super(message, cause);
    }
}
