<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.syslog.dao.SystemLogsDAO">

    <resultMap id="rs_base" type="SystemLogs">
        <result property="id" column="id"/>
        <result property="roleType" column="role_type"/>
        <result property="roleCode" column="role_code"/>
        <result property="type" column="type"/>
        <result property="description" column="description"/>
        <result property="responseState" column="response_state"/>
        <result property="ipAddress" column="ip_address"/>
        <result property="system" column="system"/>
        <result property="browser" column="browser"/>
        <result property="createTime" column="create_time"/>
    </resultMap>

    <sql id="columns">
        id,role_type,role_code,type,description,response_state,ip_address,system,browser,create_time
    </sql>


    <sql id="where">
        <where>
            <if test="id!=null and id!=''">
                AND id = ${r'#{id}'}
            </if>
            <if test="roleType!=null and roleType!=''">
                AND role_type = ${r'#{roleType}'}
            </if>
            <if test="roleCode!=null and roleCode!=''">
                AND role_code = ${r'#{roleCode}'}
            </if>
            <if test="type!=null and type!=''">
                AND type = ${r'#{type}'}
            </if>
            <if test="description!=null and description!=''">
                AND description = ${r'#{description}'}
            </if>
            <if test="responseState!=null and responseState!=''">
                AND response_state = ${r'#{responseState}'}
            </if>
            <if test="ipAddress!=null and ipAddress!=''">
                AND ip_address = ${r'#{ipAddress}'}
            </if>
            <if test="system!=null and system!=''">
                AND system = ${r'#{system}'}
            </if>
            <if test="browser!=null and browser!=''">
                AND browser = ${r'#{browser}'}
            </if>
            <if test="createTimeBegin!=null">
                AND create_time >= ${r'#{createTimeBegin}'}
            </if>
            <if test="createTimeEnd!=null">
                AND create_time &lt;= ${r'#{createTimeEnd}'}
            </if>
        </where>
    </sql>

    <!--向system_logs插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="SystemLogs">
        INSERT INTO `system_logs` (
        id ,
        role_type ,
        role_code ,
        type ,
        description ,
        response_state ,
        ip_address ,
        system ,
        browser ,
        create_time
        ) VALUES (
    ${r'#{id}'} ,
    ${r'#{roleType}'} ,
    ${r'#{roleCode}'} ,
    ${r'#{type}'} ,
    ${r'#{description}'} ,
    ${r'#{responseState}'} ,
    ${r'#{ipAddress}'} ,
    ${r'#{system}'} ,
    ${r'#{browser}'} ,
    ${r'#{createTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向system_logs批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="SystemLogs">
        INSERT INTO `system_logs` (
        id ,
        role_type ,
        role_code ,
        type ,
        description ,
        response_state ,
        ip_address ,
        system ,
        browser ,
        create_time
        ) VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
        ${r'#{item.id}'},
        ${r'#{item.roleType}'},
        ${r'#{item.roleCode}'},
        ${r'#{item.type}'},
        ${r'#{item.description}'},
        ${r'#{item.responseState}'},
        ${r'#{item.ipAddress}'},
        ${r'#{item.system}'},
        ${r'#{item.browser}'},
        ${r'#{item.createTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--根据任意条件删除system_logs信息-->
    <delete id="delete">
        DELETE FROM `system_logs`
        <include refid="where"/>
    </delete>

    <!--根据任何条件加载一条system_logs的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `system_logs`
        <include refid="where"/>
    </select>

    <!--根据任何条件统计system_logs数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `system_logs`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询system_logs-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `system_logs`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>


</mapper>
