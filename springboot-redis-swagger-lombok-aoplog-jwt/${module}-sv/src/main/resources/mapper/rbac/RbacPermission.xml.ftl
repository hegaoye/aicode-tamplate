<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacPermissionDAO">

    <resultMap id="rs_base" type="RbacPermission">
        <result property="id" column="id"/>
        <result property="menuId" column="menu_id"/>
        <result property="actionCode" column="action_code"/>
        <result property="name" column="name"/>
        <result property="type" column="type"/>
        <result property="state" column="state"/>
        <result property="description" column="description"/>
        <result property="sort" column="sort"/>
        <result property="createTime" column="create_time"/>
        <result property="updateTime" column="update_time"/>
    </resultMap>

    <sql id="columns">
    id,menu_id,action_code,name,type,state,description,sort,create_time,update_time
    </sql>

    <resultMap id="rs_base_relation" type="RbacPermission" extends="rs_base">
        <association property="rbacPermissionMenu" column="{id=menu_id}"
                     select="${basePackage}.rbac.dao.RbacPermissionMenuDAO.loadForOneToOne"/>
        <association property="rbacPermissionAction" column="{action_code=action_code}"
                     select="${basePackage}.rbac.dao.RbacPermissionActionDAO.loadForOneToOne"/>
        <collection property="rbacPermissionApiList" column="{permission_id=id}"
                    select="${basePackage}.rbac.dao.RbacPermissionApiDAO.queryForOneToMany"/>
        <collection property="rbacRolePermissionRelationList" column="{permission_id=id}"
                    select="${basePackage}.rbac.dao.RbacRolePermissionRelationDAO.queryForOneToMany"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="permissionIds != null">
                <foreach collection="permissionIds" item="item" open="and id in (" close=")" separator=",">
                    ${r'#{item}'}
                </foreach>
            </if>
            <if test="menuId!=null">
                AND menu_id = ${r'#{menuId}'}
            </if>
            <if test="actionCode!=null and actionCode!=''">
                AND action_code = ${r'#{actionCode}'}
            </if>
            <if test="name!=null and name!=''">
                AND name = ${r'#{name}'}
            </if>
            <if test="type!=null and type!=''">
                AND type = ${r'#{type}'}
            </if>
            <if test="state!=null and state!=''">
                AND state = ${r'#{state}'}
            </if>
            <if test="description!=null and description!=''">
                AND description = ${r'#{description}'}
            </if>
            <if test="sort!=null and sort!=''">
                AND sort = ${r'#{sort}'}
            </if>
            <if test="createTimeBegin!=null">
                AND create_time >= ${r'#{createTimeBegin}'}
            </if>
            <if test="createTimeEnd!=null">
                AND create_time &lt;= ${r'#{createTimeEnd}'}
            </if>
            <if test="updateTimeBegin!=null">
                AND update_time >= ${r'#{updateTimeBegin}'}
            </if>
            <if test="updateTimeEnd!=null">
                AND update_time &lt;= ${r'#{updateTimeEnd}'}
            </if>
        </where>
    </sql>

    <!--向rbac_permission插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacPermission">
        INSERT INTO `rbac_permission` (
        id ,
        menu_id ,
        action_code ,
        name ,
        type ,
        state ,
        description ,
        sort ,
        create_time ,
        update_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{menuId}'} ,
        ${r'#{actionCode}'} ,
        ${r'#{name}'} ,
        ${r'#{type}'} ,
        ${r'#{state}'} ,
        ${r'#{description}'} ,
        ${r'#{sort}'} ,
        ${r'#{createTime}'} ,
        ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_permission批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacPermission">
        INSERT INTO `rbac_permission` (
        id ,
        menu_id ,
        action_code ,
        name ,
        type ,
        state ,
        description ,
        sort ,
        create_time ,
        update_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.menuId}'},
            ${r'#{item.actionCode}'},
            ${r'#{item.name}'},
            ${r'#{item.type}'},
            ${r'#{item.state}'},
            ${r'#{item.description}'},
            ${r'#{item.sort}'},
            ${r'#{item.createTime}'},
            ${r'#{item.updateTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_permission -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_permission`
        <trim prefix="set" suffixOverrides=",">
            <trim prefix="menu_id = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="menuId!=null and menuId!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.menuId}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="action_code = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="actionCode!=null and actionCode!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.actionCode}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="name = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="name!=null and name!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.name}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="type = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="type!=null and type!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.type}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="state = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="state!=null and state!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.state}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="description = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="description!=null and description!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.description}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="sort = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="sort!=null and sort!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.sort}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="update_time = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="item.updateTime!=null">
                        when id = ${r'#{item.id}'} then ${r'#{item.updateTime}'}
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

    <!--根据主键更新 rbac_permission 的数据-->
    <update id="update" parameterType="RbacPermission">
        UPDATE `rbac_permission`
        <trim prefix="set" suffixOverrides=",">
            <if test="actionCode!=null and actionCode!=''">
                action_code = ${r'#{actionCode}'} ,
            </if>
            <if test="name!=null and name!=''">
                name = ${r'#{name}'} ,
            </if>
            <if test="type!=null and type!=''">
                type = ${r'#{type}'} ,
            </if>
            <if test="state!=null and state!=''">
                state = ${r'#{state}'} ,
            </if>
            <if test="description!=null and description!=''">
                description = ${r'#{description}'} ,
            </if>
            <if test="sort!=null and sort!=''">
                sort = ${r'#{sort}'} ,
            </if>
            <if test="updateTime!=null">
                update_time = ${r'#{updateTime}'}
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
        FROM `rbac_permission`
        <include refid="where"/>
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_permission 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_permission`
        <trim prefix="set" suffixOverrides=",">
            <if test="newState!=null and newState!=''">
                state = ${r'#{newState}'},
            </if>
            <if test="updateTime!=null">
                update_time = ${r'#{updateTime}'},
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

    <!--根据主键更新 rbac_permission 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_permission`
        <trim prefix="set" suffixOverrides=",">
            <if test="state!=null and state!=''">
                state = ${r'#{state}'},
            </if>
            <if test="updateTime!=null">
                update_time = ${r'#{updateTime}'},
            </if>
        </trim>
        where id=${r'#{id}'}
    </update>
    <!--修改菜单权限资源中权限名称-->
    <update id="updateMenuPermissionName" parameterType="map">
        update rbac_permission
        set name = ${r'#{name}'}, update_time = ${r'#{updateTime}'}
        where menu_id = ${r'#{menuId}'} and type = ${r'#{type}'}
    </update>


    <!--根据任意条件删除rbac_permission信息-->
    <delete id="delete">
        DELETE FROM `rbac_permission`
        <include refid="where"/>
    </delete>

    <!--根据菜单id删除所有权限资源-->
    <delete id="deleteByMenuId" parameterType="long">
        delete from rbac_permission
        where menu_id = ${r'#{menuId}'}
    </delete>

    <!--根据任何条件加载一条rbac_permission的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_permission loadById  通过id -->
    <select id="loadById" resultMap="rs_base_relation" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission`
        where id = ${r'#{id}'}
    </select>


    <!--根据任何条件统计rbac_permission数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_permission`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_permission-->
    <select id="list" resultMap="rs_base_relation">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>


</mapper>
