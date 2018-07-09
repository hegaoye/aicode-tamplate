package ${basePackage}.core.base;

import lombok.Data;
import com.alibaba.fastjson.annotation.JSONField;

@Data
public class BaseEntity implements java.io.Serializable {
    @JSONField(serialize = false)
    protected Long id;
}
