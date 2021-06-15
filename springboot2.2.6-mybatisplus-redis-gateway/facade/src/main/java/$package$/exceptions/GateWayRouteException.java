/*
 * subo
 */
package $package$.exceptions;


import $package$.core.exceptions.BaseException;

import java.io.Serializable;

public class GateWayRouteException extends BaseException implements Serializable {
    public GateWayRouteException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public GateWayRouteException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public GateWayRouteException(String message) {
        super(message);
    }

    public GateWayRouteException(String message, Throwable cause) {
        super(message, cause);
    }
}
