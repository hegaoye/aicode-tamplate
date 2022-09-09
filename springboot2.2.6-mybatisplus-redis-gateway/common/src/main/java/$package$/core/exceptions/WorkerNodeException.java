/*
* d
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class WorkerNodeException extends BaseException implements Serializable {
    public WorkerNodeException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public WorkerNodeException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public WorkerNodeException(String message) {
        super(message);
    }

    public WorkerNodeException(String message, Throwable cause) {
        super(message, cause);
    }
}
