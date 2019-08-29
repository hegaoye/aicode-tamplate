package ${basePackage}.core.tools.security;

import java.security.Security;

/**
 * 加密基类
 * 
 * @author ${author}
 *
 *
 */
public abstract class SecurityCoder {
    private static Byte ADDFLAG = 0;
    static {
        if (ADDFLAG == 0) {
            // 加入BouncyCastleProvider支持
            Security.addProvider(new BouncyCastleProvider());
            ADDFLAG = 1;
        }
    }
}
