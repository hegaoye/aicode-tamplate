/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgCommissionChainRatioException extends BaseException implements Serializable {
    public OrgCommissionChainRatioException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgCommissionChainRatioException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgCommissionChainRatioException(String message) {
        super(message);
    }

    public OrgCommissionChainRatioException(String message, Throwable cause) {
        super(message, cause);
    }
}
