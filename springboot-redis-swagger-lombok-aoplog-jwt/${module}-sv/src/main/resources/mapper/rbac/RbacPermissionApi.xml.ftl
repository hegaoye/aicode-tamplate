<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacPermissionApiDAO">

    <resultMap id="rs_base" type="RbacPermissionApi">
        <result property="id" column="id"/>
        <result property="permissionId" column="permission_id"/>
        <result property="actionUrl" column="action_url"/>
        <result property="createTime" column="create_time"/>
        <result property="updateTime" column="update_time"/>
    </resultMap>

    <sql id="columns">
    id,permission_id,action_url,create_time,update_time
    </sql>

    <resultMap id="rs_base_relation" type="RbacPermissionApi" extends="rs_base">
                <association property="rbacPermission" column="{id=permissionId}" select="${basePackage}.rbac.dao.RbacPermissionDAO.loadForOneToOne"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null and id!=''">
                AND id = ${r'#{id}'}
            </if>
            <if test="permissionId!=null and permissionId!=''">
                AND permission_id = ${r'#{permissionId}'}
            </if>
            <if test="actionUrl!=null and actionUrl!=''">
                AND action_url = ${r'#{actionUrl}'}
            </if>
        </where>
    </sql>

    <!--向rbac_permission_api插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacPermissionApi">
        INSERT INTO `rbac_permission_api` (
        id ,
        permission_id ,
        action_url ,
        create_time ,
        update_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{permissionId}'} ,
        ${r'#{actionUrl}'} ,
        ${r'#{createTime}'} ,
        ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_permission_api批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacPermissionApi">
        INSERT INTO `rbac_permission_api` (
            id ,
            permission_id ,
            action_url ,
            create_time ,
            update_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.permissionId}'},
            ${r'#{item.actionUrl}'},
            ${r'#{item.createTime}'},
            ${r'#{item.updateTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_permission_api -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_permission_api`
        <trim prefix="set" suffixOverrides=",">
                <trim prefix="permission_id = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="permissionId!=null and permissionId!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.permissionId}'}
                        </if>
                    </foreach>
                </trim>
                <trim prefix="action_url = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="actionUrl!=null and actionUrl!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.actionUrl}'}
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

    <!--根据主键更新 rbac_permission_api 的数据-->
    <update id="update" parameterType="RbacPermissionApi">
        UPDATE `rbac_permission_api`
        <trim prefix="set" suffixOverrides=",">
                <if test="permissionId!=null">
                permission_id = ${r'#{permissionId}'} ,
                </if>
                <if test="actionUrl!=null and actionUrl!=''">
                action_url = ${r'#{actionUrl}'} ,
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
        SELECT <include refid="columns" />
        FROM `rbac_permission_api`
        <include refid="where"/>
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT <include refid="columns" />
        FROM `rbac_permission_api`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT <include refid="columns" />
        FROM `rbac_permission_api`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'#{sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_permission_api 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_permission_api`
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

    <!--根据主键更新 rbac_permission_api 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_permission_api`
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



    <!--根据任意条件删除rbac_permission_api信息-->
    <delete id="delete">
        DELETE FROM `rbac_permission_api`
        <include refid="where"/>
    </delete>

    <!--根据任何条件加载一条rbac_permission_api的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission_api`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_permission_api loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission_api`
        where id = ${r'#{id}'}
    </select>


    <!--根据任何条件统计rbac_permission_api数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_permission_api`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_permission_api-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission_api`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>


</mapper>
