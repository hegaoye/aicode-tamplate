/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerCommissionChainRatioException extends BaseException implements Serializable {
    public PlayerCommissionChainRatioException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerCommissionChainRatioException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerCommissionChainRatioException(String message) {
        super(message);
    }

    public PlayerCommissionChainRatioException(String message, Throwable cause) {
        super(message, cause);
    }
}
