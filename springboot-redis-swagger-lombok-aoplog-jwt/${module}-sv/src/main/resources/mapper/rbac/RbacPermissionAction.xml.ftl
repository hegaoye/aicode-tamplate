<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacPermissionActionDAO">

    <resultMap id="rs_base" type="RbacPermissionAction">
        <result property="id" column="id"/>
        <result property="actionCode" column="action_code"/>
        <result property="actionName" column="action_name"/>
        <result property="actionIcon" column="action_icon"/>
        <result property="description" column="description"/>
        <result property="createTime" column="create_time"/>
        <result property="updateTime" column="update_time"/>
    </resultMap>

    <sql id="columns">
    id,action_code,action_name,action_icon,description,create_time,update_time
    </sql>

    <resultMap id="rs_base_relation" type="RbacPermissionAction" extends="rs_base">
                <collection property="rbacPermissionList" column="{actionCode=actionCode}" select="${basePackage}.rbac.dao.RbacPermissionDAO.queryForOneToMany"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null and id!=''">
                AND id = ${r'#{id}'}
            </if>
            <if test="actionCode!=null and actionCode!=''">
                AND action_code = ${r'#{actionCode}'}
            </if>
            <if test="actionName!=null and actionName!=''">
                AND action_name = ${r'#{actionName}'}
            </if>
            <if test="actionIcon!=null and actionIcon!=''">
                AND action_icon = ${r'#{actionIcon}'}
            </if>
            <if test="description!=null and description!=''">
                AND description = ${r'#{description}'}
            </if>
        </where>
    </sql>

    <!--向rbac_permission_action插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacPermissionAction">
        INSERT INTO `rbac_permission_action` (
        id ,
        action_code ,
        action_name ,
        action_icon ,
        description ,
        create_time ,
        update_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{actionCode}'} ,
        ${r'#{actionName}'} ,
        ${r'#{actionIcon}'} ,
        ${r'#{description}'} ,
        ${r'#{createTime}'} ,
        ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_permission_action批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacPermissionAction">
        INSERT INTO `rbac_permission_action` (
            id ,
            action_code ,
            action_name ,
            action_icon ,
            description ,
            create_time ,
            update_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.actionCode}'},
            ${r'#{item.actionName}'},
            ${r'#{item.actionIcon}'},
            ${r'#{item.description}'},
            ${r'#{item.createTime}'},
            ${r'#{item.updateTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_permission_action -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_permission_action`
        <trim prefix="set" suffixOverrides=",">
                <trim prefix="action_code = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="actionCode!=null and actionCode!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.actionCode}'}
                        </if>
                    </foreach>
                </trim>
                <trim prefix="action_name = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="actionName!=null and actionName!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.actionName}'}
                        </if>
                    </foreach>
                </trim>
                <trim prefix="action_icon = case" suffix="end,">
                    <foreach collection="list" item="item">
                        <if test="actionIcon!=null and actionIcon!=''">
                            when id = ${r'#{item.id}'} then ${r'#{item.actionIcon}'}
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

    <!--根据主键更新 rbac_permission_action 的数据-->
    <update id="update" parameterType="RbacPermissionAction">
        UPDATE `rbac_permission_action`
        <trim prefix="set" suffixOverrides=",">
                <if test="actionName!=null and actionName!=''">
                action_name = ${r'#{actionName}'} ,
                </if>
                <if test="actionIcon!=null and actionIcon!=''">
                action_icon = ${r'#{actionIcon}'} ,
                </if>
                <if test="description!=null and description!=''">
                description = ${r'#{description}'} ,
                </if>
                <if test="update_time!=null">
                updateTime = ${r'#{updateTime}'}
                </if>
        </trim>
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="actionCode!=null and actionCode!=''">
                and action_code = ${r'#{actionCode}'}
            </if>
        </where>
    </update>


    <!--查询关联数据-->
    <select id="getDetail" resultMap="rs_base_relation">
        SELECT <include refid="columns" />
        FROM `rbac_permission_action`
        <include refid="where"/>
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT <include refid="columns" />
        FROM `rbac_permission_action`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT <include refid="columns" />
        FROM `rbac_permission_action`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_permission_action 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_permission_action`
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

    <!--根据主键更新 rbac_permission_action 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_permission_action`
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



    <!--根据任意条件删除rbac_permission_action信息-->
    <delete id="delete">
        DELETE FROM `rbac_permission_action`
        <include refid="where"/>
    </delete>

    <!--根据任何条件加载一条rbac_permission_action的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission_action`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_permission_action loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission_action`
        where id = ${r'#{id}'}
    </select>


    <!--根据任何条件统计rbac_permission_action数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_permission_action`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_permission_action-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_permission_action`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>


</mapper>
