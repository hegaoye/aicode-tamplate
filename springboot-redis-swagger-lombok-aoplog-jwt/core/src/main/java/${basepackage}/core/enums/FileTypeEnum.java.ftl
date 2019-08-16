/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * Created by borong on 2019/5/10 18:15
 * 允许上传的文件类型
 */
public enum FileTypeEnum {
    JPEG("image/jpeg"),
    JPG("image/jpeg"),
    PNG("image/png"),
    GIF("image/gif"),
    BMP("image/bmp"),
    RAR("application/octet-stream"),
    ZIP("application/zip"),
    DOC("application/msword"),
    XLS("application/vnd.ms-excel"),
    PPT("application/vnd.ms-powerpoint"),
    DOCX("application/msword"),
    XLSX("application/vnd.ms-excel"),
    PPTX("application/vnd.ms-powerpoint"),
    FLV("application/octet-stream"),
    TXT("text/plain"),
    ;
    public String value;

    FileTypeEnum(String value) {
        this.value = value;
    }

    public static FileTypeEnum getEnum(String name) {
        for (FileTypeEnum fileType : FileTypeEnum.values()) {
            if (fileType.value.equalsIgnoreCase(name)) {
                return fileType;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined);
    }
}
