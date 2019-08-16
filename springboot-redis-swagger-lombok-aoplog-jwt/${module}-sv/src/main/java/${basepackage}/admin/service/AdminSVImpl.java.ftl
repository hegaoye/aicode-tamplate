/*
 * ${copyright}
 */
package ${basePackage}.admin.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
import ${basePackage}.admin.dao.AdminDAO;
import ${basePackage}.admin.entity.Admin;
import ${basePackage}.admin.entity.AdminState;
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.base.BaseSVImpl;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.tools.security.Md5;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("adminSV")
@Slf4j
public class AdminSVImpl extends BaseSVImpl<Admin, Long> implements AdminSV {

    @Autowired
    private AdminDAO adminDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return adminDAO;
    }

    /**
    * 保存account对象
    *
    * @param entity 实体
    * @throws BaseException
    */
    @Override
    public void save(Admin entity) throws BaseException {
        entity.setCreateTime(new Date());
        entity.setUpdateTime(new Date());
        super.save(entity);
    }

    /**
     * 加载一个对象Admin
     * @param id 主键ID
     * @return ADMIN
     */
    @Override
    public Admin load(Long id) {
       if(id==null){
          throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid("id"));
       }

        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        return adminDAO.load(param);
    }


    /**
     * 加载一个对象Admin 通过id
     * @param id 主键ID
     * @return ADMIN
     */
    @Override
    public Admin loadById(Long id) {
        if(id==null){
           throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }
        return adminDAO.loadById(id);
    }

    /**
     * 删除对象Admin
     * @param id 主键ID
     * @return ADMIN
     */
    @Override
    public void delete(Long id) {
        if(id==null){
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }
        Map<String,Object> param=new HashMap<>();
        param.put("id",id);
        adminDAO.delete(param);
    }

    /**
    * 查询Admin分页
    *
    * @param admin  对象
    * @param offset 查询开始行
    * @param limit  查询行数
    * @return List<ADMIN>
    */
    @Override
    public List<Admin> list(Admin admin, int offset, int limit) {
        if (offset < 0) {
           offset = 0;
        }

        if (limit < 0) {
           limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (admin != null) {
           map = JSON.parseObject(JSON.toJSONString(admin, SerializerFeature.WriteDateUseDateFormat));
        } else {
           map = new HashMap<>();
        }
        return adminDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public  int count(Admin admin){
        Map<String, Object> map = null;
        if (admin != null) {
           map = JSON.parseObject(JSON.toJSONString(admin, SerializerFeature.WriteDateUseDateFormat));
        } else {
           map = new HashMap<>();
        }
        return adminDAO.count(map);
     }

    /**
     * 通过账号和密码查询管理员信息
     * 用于管理员账号密码登录接口
     *
     * @param account  登录账户
     * @param password 密码
     * @return
     */
    @Override
    public Admin load(String account, String password) {

        if (StringUtils.isBlank(account)) {
            throw new BaseException(BaseException.ExceptionEnums.paramIsEmpty("登录账户"));
        }
        if (StringUtils.isBlank(password)) {
            throw new BaseException(BaseException.ExceptionEnums.paramIsEmpty("密码"));
        }

        Map<String, Object> params = new HashMap<>();
        params.put("loginAccount", account);
        params.put("password", Md5.md5(password));

        return adminDAO.load(params);
    }

    /**
     * 通过编码查询管理员信息
     * 此接口仅供过滤器使用
     * @param code
     * @return
     */
    @Override
    public Admin loadByCode(String code) {

        if (StringUtils.isBlank(code)) {
            throw new BaseException(BaseException.ExceptionEnums.paramIsEmpty("管理员编码"));
        }

        Map<String, Object> params = new HashMap<>();
        params.put("code", code);

        return adminDAO.load(params);
    }
}
