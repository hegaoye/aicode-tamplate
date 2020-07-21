/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class PlayerChainRelationException extends BaseException implements Serializable {
    public PlayerChainRelationException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public PlayerChainRelationException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public PlayerChainRelationException(String message) {
        super(message);
    }

    public PlayerChainRelationException(String message, Throwable cause) {
        super(message, cause);
    }
}
