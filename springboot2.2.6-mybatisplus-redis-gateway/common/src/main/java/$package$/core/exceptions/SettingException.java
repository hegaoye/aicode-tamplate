/*
* d
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class SettingException extends BaseException implements Serializable {
    public SettingException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public SettingException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public SettingException(String message) {
        super(message);
    }

    public SettingException(String message, Throwable cause) {
        super(message, cause);
    }
}
