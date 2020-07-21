/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerHorizontalRelationException extends BaseException implements Serializable {
    public PlayerHorizontalRelationException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerHorizontalRelationException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerHorizontalRelationException(String message) {
        super(message);
    }

    public PlayerHorizontalRelationException(String message, Throwable cause) {
        super(message, cause);
    }
}
