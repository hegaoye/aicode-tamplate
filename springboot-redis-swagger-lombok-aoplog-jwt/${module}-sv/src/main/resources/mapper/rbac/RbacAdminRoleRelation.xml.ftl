<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacAdminRoleRelationDAO">

    <resultMap id="rs_base" type="RbacAdminRoleRelation">
        <result property="id" column="id"/>
        <result property="adminCode" column="admin_code"/>
        <result property="roleId" column="role_id"/>
        <result property="toAuthAdminCode" column="to_auth_admin_code"/>
        <result property="createTime" column="create_time"/>
    </resultMap>

    <sql id="columns">
    id,admin_code,role_id,to_auth_admin_code,create_time
    </sql>

    <resultMap id="rs_base_relation" type="RbacAdminRoleRelation" extends="rs_base">
                <association property="rbacAdmin" column="{code=adminCode}" select="${basePackage}.rbac.dao.RbacAdminDAO.loadForOneToOne"/>
                <association property="rbacRole" column="{id=roleId}" select="${basePackage}.rbac.dao.RbacRoleDAO.loadForOneToOne"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null and id!=''">
                AND id = ${r'#{id}'}
            </if>
            <if test="adminCode!=null and adminCode!=''">
                AND admin_code = ${r'#{adminCode}'}
            </if>
            <if test="roleId!=null and roleId!=''">
                AND role_id = ${r'#{roleId}'}
            </if>
            <if test="toAuthAdminCode!=null and toAuthAdminCode!=''">
                AND to_auth_admin_code = ${r'#{toAuthAdminCode}'}
            </if>
        </where>
    </sql>

    <!--向rbac_admin_role_relation插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacAdminRoleRelation">
        INSERT INTO `rbac_admin_role_relation` (
        id ,
        admin_code ,
        role_id ,
        to_auth_admin_code ,
        create_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{adminCode}'} ,
        ${r'#{roleId}'} ,
        ${r'#{toAuthAdminCode}'} ,
        ${r'#{createTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_admin_role_relation批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacAdminRoleRelation">
        INSERT INTO `rbac_admin_role_relation` (
            id ,
            admin_code ,
            role_id ,
            to_auth_admin_code ,
            create_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.adminCode}'},
            ${r'#{item.roleId}'},
            ${r'#{item.toAuthAdminCode}'},
            ${r'#{item.createTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_admin_role_relation -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_admin_role_relation`
        <trim prefix="set" suffixOverrides=",">
                <trim prefix="admin_code = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="adminCode!=null and adminCode!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.adminCode}'}
                        </if>
                    </foreach>
                </trim>
                <trim prefix="role_id = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="roleId!=null and roleId!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.roleId}'}
                        </if>
                    </foreach>
                </trim>
                <trim prefix="to_auth_admin_code = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="toAuthAdminCode!=null and toAuthAdminCode!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.toAuthAdminCode}'}
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

    <!--根据主键更新 rbac_admin_role_relation 的数据-->
    <update id="update" parameterType="RbacAdminRoleRelation">
        UPDATE `rbac_admin_role_relation`
        <trim prefix="set" suffixOverrides=",">
                <if test="adminCode!=null and adminCode!=''">
                admin_code = ${r'#{adminCode}'} ,
                </if>
                <if test="roleId!=null and roleId!=''">
                role_id = ${r'#{roleId}'} ,
                </if>
                <if test="toAuthAdminCode!=null and toAuthAdminCode!=''">
                to_auth_admin_code = ${r'#{toAuthAdminCode}'} ,
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
        SELECT <include refid="columns" />
        FROM `rbac_admin_role_relation`
        <include refid="where"/>
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT <include refid="columns" />
        FROM `rbac_admin_role_relation`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT <include refid="columns" />
        FROM `rbac_admin_role_relation`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'#{sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_admin_role_relation 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_admin_role_relation`
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

    <!--根据主键更新 rbac_admin_role_relation 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_admin_role_relation`
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

    <!--根据任意条件删除rbac_admin_role_relation信息-->
    <delete id="delete">
        DELETE FROM `rbac_admin_role_relation`
        <include refid="where"/>
    </delete>

    <!--根据角色id 删除角色与授权用户的关系-->
    <delete id="deleteByRoleId" parameterType="long">
        DELETE FROM `rbac_admin_role_relation`
        where role_id = ${r'#{roleId}'}
    </delete>

    <!--删除管理员与角色的绑定关系-->
    <delete id="deleteByAdminCode" parameterType="string">
        delete from rbac_admin_role_relation where admin_code = ${r'#{adminCode}'}
    </delete>

    <!--根据任何条件加载一条rbac_admin_role_relation的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin_role_relation`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_admin_role_relation loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin_role_relation`
        where id = ${r'#{id}'}
    </select>

    <!--查询管理员拥有的所有角色id-->
    <select id="listAdminRoleIds" parameterType="map" resultType="long">
        select role_id from rbac_admin_role_relation
        where admin_code = ${r'#{adminCode}'}
    </select>

    <!--根据任何条件统计rbac_admin_role_relation数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_admin_role_relation`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_admin_role_relation-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin_role_relation`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>


</mapper>
