<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacRolePermissionRelationDAO">

    <resultMap id="rs_base" type="RbacRolePermissionRelation">
        <result property="id" column="id"/>
        <result property="roleId" column="role_id"/>
        <result property="permissionId" column="permission_id"/>
        <result property="createTime" column="create_time"/>
    </resultMap>

    <sql id="columns">
    id,role_id,permission_id,create_time
    </sql>

    <resultMap id="rs_base_permission" type="RbacRolePermissionRelation" extends="rs_base">
        <association property="rbacPermission" column="{id=permission_id}"
                     select="${basePackage}.rbac.dao.RbacPermissionDAO.getDetail"/>
    </resultMap>

    <resultMap id="rs_base_relation" type="RbacRolePermissionRelation" extends="rs_base">
        <association property="rbacRole" column="{id=role_id}"
                     select="${basePackage}.rbac.dao.RbacRoleDAO.loadForOneToOne"/>
        <association property="rbacPermission" column="{id=permission_id}"
                     select="${basePackage}.rbac.dao.RbacPermissionDAO.loadForOneToOne"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="roleId!=null">
                AND role_id = ${r'#{roleId}'}
            </if>
            <if test="permissionId!=null">
                AND permission_id = ${r'#{permissionId}'}
            </if>
            <if test="permissionIds != null">
                <foreach collection="permissionIds" item="item" open="and permission_id in (" close=")" separator=",">
                    ${r'#{item}'}
                </foreach>
            </if>
        </where>
    </sql>

    <!--向rbac_role_permission_relation插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacRolePermissionRelation">
        INSERT INTO `rbac_role_permission_relation` (
        id ,
        role_id ,
        permission_id ,
        create_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{roleId}'} ,
        ${r'#{permissionId}'} ,
        ${r'#{createTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_role_permission_relation批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacRolePermissionRelation">
        INSERT INTO `rbac_role_permission_relation` (
        id ,
        role_id ,
        permission_id ,
        create_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.roleId}'},
            ${r'#{item.permissionId}'},
            ${r'#{item.createTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_role_permission_relation -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_role_permission_relation`
        <trim prefix="set" suffixOverrides=",">
            <trim prefix="role_id = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="roleId!=null and roleId!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.roleId}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="permission_id = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="permissionId!=null and permissionId!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.permissionId}'}
                    </if>
                </foreach>
            </trim>
        </trim>
        <!-- 批量更新 参照条件 -->
        <foreach collection="list" item="item" open="where id in (" close=")" separator=",">
            ${r'#{item.id}'}
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </update>

    <!--根据主键更新 rbac_role_permission_relation 的数据-->
    <update id="update" parameterType="RbacRolePermissionRelation">
        UPDATE `rbac_role_permission_relation`
        <trim prefix="set" suffixOverrides=",">
            <if test="roleId!=null and roleId!=''">
                role_id = ${r'#{roleId}'} ,
            </if>
            <if test="permissionId!=null and permissionId!=''">
                permission_id = ${r'#{permissionId}'} ,
            </if>
        </trim>
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
        </where>
    </update>


    <!--查询关联数据-->
    <select id="getDetail" resultMap="rs_base_relation">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        <include refid="where"/>
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_role_permission_relation 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_role_permission_relation`
        <trim prefix="set" suffixOverrides=",">
            <if test="newState!=null and newState!=''">
                state = ${r'#{newState}'},
            </if>
            <if test="updateTime!=null">
                updateTime = ${r'#{updateTime}'},
            </if>
        </trim>
        <where>
            <if test="id!=null">
                id = ${r'#{id}'}
            </if>
            <if test="oldStates!=null">
                AND state in
                <foreach collection="oldStates" index="index" item="stateIn" open="(" separator="," close=")">
                    ${r'#{stateIn}'}
                </foreach>
            </if>
        </where>
    </update>

    <!--根据主键更新 rbac_role_permission_relation 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_role_permission_relation`
        <trim prefix="set" suffixOverrides=",">
            <if test="state!=null and state!=''">
                state = ${r'#{state}'},
            </if>
            <if test="updateTime!=null">
                updateTime = ${r'#{updateTime}'},
            </if>
        </trim>
        where id=${r'#{id}'}
    </update>


    <!--根据任意条件删除rbac_role_permission_relation信息-->
    <delete id="delete">
        DELETE FROM `rbac_role_permission_relation`
        <include refid="where"/>
    </delete>
    <!--删除角色当前已经绑定的所有权限-->
    <delete id="deleteByRoleId" parameterType="long">
        DELETE FROM `rbac_role_permission_relation`
        where role_id = ${r'#{roleId}'}
    </delete>

    <!--根据权限资源id集 删除角色与菜单权限对应关系-->
    <delete id="deleteByPermissionIds" parameterType="list">
        DELETE from rbac_role_permission_relation
        where
        <foreach collection="permissionIds" item="item" open="permission_id in (" close=")" separator=",">
            ${r'#{item}'}
        </foreach>
    </delete>

    <!--根据任何条件加载一条rbac_role_permission_relation的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_role_permission_relation loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        where id = ${r'#{id}'}
    </select>


    <!--根据任何条件统计rbac_role_permission_relation数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_role_permission_relation`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_role_permission_relation-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>

    <!--根据角色查询绑定的所有权限-->
    <select id="queryRolePermissions" parameterType="long" resultMap="rs_base_permission">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`
        where role_id = ${r'#{roleId}'}
    </select>

    <!--根据多角色查询绑定的所有权限-->
    <select id="queryRolesPermissions" parameterType="list" resultMap="rs_base_permission">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role_permission_relation`

        where
        <foreach collection="roleIds" item="item" open="role_id in (" close=")" separator=",">
            ${r'#{item}'}
        </foreach>
    </select>


</mapper>
