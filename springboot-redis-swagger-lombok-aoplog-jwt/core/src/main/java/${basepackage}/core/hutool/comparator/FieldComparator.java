package ${basePackage}.core.hutool.comparator;

import ${basePackage}.core.hutool.util.ClassUtil;
import ${basePackage}.core.hutool.util.ObjectUtil;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.Comparator;

/**
 * Bean字段排序器<br>
 * 参阅feilong-core中的PropertyComparator
 *
 * @param <T> 被比较的Bean
 * @author Looly
 */
public class FieldComparator<T> implements Comparator<T>, Serializable {
    private static final long serialVersionUID = 9157326766723846313L;

    private final Field field;

    public FieldComparator(Class<T> beanClass, String fieldName) {
        this.field = ClassUtil.getDeclaredField(beanClass, fieldName);
        if (this.field == null) {
            throw new IllegalArgumentException("字段" + fieldName + "在类" + beanClass + "中不存在");
        }
    }

    @Override
    public int compare(T o1, T o2) {
        if (o1 == o2) {
            return 0;
        } else if (null == o1) {// null 排在后面
            return 1;
        } else if (null == o2) {
            return -1;
        }

        Comparable<?> v1;
        Comparable<?> v2;
        try {
            v1 = (Comparable<?>) field.get(o1);
            v2 = (Comparable<?>) field.get(o2);
        } catch (Exception e) {
            throw new ComparatorException(e);
        }

        return compare(o1, o2, v1, v2);
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private int compare(T o1, T o2, Comparable fieldValue1, Comparable fieldValue2) {
        int result = ObjectUtil.compare(fieldValue1, fieldValue2);
        if (0 == result && ObjectUtil.notEqual(o1, o2)) {
            //避免TreeSet / TreeMap 过滤掉排序字段相同但是对象不相同的情况
            return 1;
        }
        return result;
    }
}
