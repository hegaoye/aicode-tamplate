/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.upload.entity;

import java.io.Serializable;

/**
 * 用于文件上传代理缓存业务处理
 */
public class UploadBasicEntity implements Serializable {
    private String uid;
    private String uniqueCode;
    private Object data;
    private String state;
    private String fileType;


    public enum UploadState {
        CREATED,/*已创建*/
        UPLOADED,/*已上传*/
        UPDATED,/*已更新*/
        OVERDUE;/*过期销毁*/
    }

    public UploadBasicEntity() {
    }

    public UploadBasicEntity(String uid, String uniqueCode) {
        this.uid = uid;
        this.uniqueCode = uniqueCode;
        this.state = UploadState.CREATED.name();
    }

    public UploadBasicEntity(String uid, String uniqueCode, Object data) {
        this.uid = uid;
        this.uniqueCode = uniqueCode;
        this.data = data;
        this.state = UploadState.CREATED.name();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUniqueCode() {
        return uniqueCode;
    }

    public void setUniqueCode(String uniqueCode) {
        this.uniqueCode = uniqueCode;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
}
