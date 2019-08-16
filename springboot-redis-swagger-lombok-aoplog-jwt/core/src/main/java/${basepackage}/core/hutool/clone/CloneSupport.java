package ${basePackage}.core.hutool.clone;

/**
 * 克隆支持类，提供默认的克隆方法
 *
 * @param
 * @author Looly
 */
public class CloneSupport implements Cloneable {

    @SuppressWarnings("unchecked")
    @Override
    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException e) {
            throw new CloneRuntimeException(e);
        }
    }

}
