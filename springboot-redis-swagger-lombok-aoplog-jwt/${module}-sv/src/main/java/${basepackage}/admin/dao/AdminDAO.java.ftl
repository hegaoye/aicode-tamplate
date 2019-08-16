/*
 * ${copyright}
 */
package ${basePackage}.admin.dao;

import ${basePackage}.admin.entity.Admin;
import ${basePackage}.admin.entity.AdminState;
import ${basePackage}.core.base.BaseDAO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 管理员表
 *
 * @author borong
 */
@Mapper
@Repository
public  interface AdminDAO extends BaseDAO<Admin, Long> {

    /**
     * 加载一个对象Admin 通过id
     * @param id 主键ID
     * @return ADMIN
     */
     Admin loadById(@Param("id") Long id);

    /**
     * 删除对象Admin
     *@param params 实体的属性
     */
     void delete(Map<String, Object> params);



   /**
    * 查询Admin列表
    * @param rowBounds 分页参数
    * @return List<ADMIN>
    */
    List<Admin> list(RowBounds rowBounds);


   /**
    * 查询Admin分页 根据状态
    *
    * @param id  主键ID
    * @return List<ADMIN>
    */
    List<Admin> listByPk(Long id, AdminState state, RowBounds rowBounds);
    int countByPk(Long id, AdminState state);
}
