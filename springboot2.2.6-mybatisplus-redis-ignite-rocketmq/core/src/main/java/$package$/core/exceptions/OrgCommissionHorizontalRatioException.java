/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OrgCommissionHorizontalRatioException extends BaseException implements Serializable {
    public OrgCommissionHorizontalRatioException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OrgCommissionHorizontalRatioException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OrgCommissionHorizontalRatioException(String message) {
        super(message);
    }

    public OrgCommissionHorizontalRatioException(String message, Throwable cause) {
        super(message, cause);
    }
}
