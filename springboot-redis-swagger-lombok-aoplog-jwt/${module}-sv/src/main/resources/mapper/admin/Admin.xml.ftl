<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.admin.dao.AdminDAO">

    <resultMap id="rs_base" type="Admin">
        <result property="id" column="id"/>
        <result property="code" column="code"/>
        <result property="name" column="name"/>
        <result property="loginAccount" column="loginAccount"/>
        <result property="password" column="password"/>
        <result property="phone" column="phone"/>
        <result property="idcard" column="idcard"/>
        <result property="role" column="role"/>
        <result property="permissions" column="permissions"/>
        <result property="state" column="state"/>
        <result property="operatorCode" column="operatorCode"/>
        <result property="operatorName" column="operatorName"/>
        <result property="createTime" column="createTime"/>
        <result property="updateTime" column="updateTime"/>
    </resultMap>

    <!--查询表信息关联信息-->

    <sql id="columns">
        id,code,name,loginAccount,password,phone,idcard,role,permissions,state,
        operatorCode,operatorName,createTime,updateTime
    </sql>

    <sql id="where">
        <where>
                <if test="id!=null">
                    AND id = ${r'#{id}'}
                </if>
                <if test="code!=null and code!=''">
                    AND code = ${r'#{code}'}
                </if>
                <if test="name!=null and name!=''">
                    AND name = ${r'#{name}'}
                </if>
                <if test="loginAccount!=null and loginAccount!=''">
                    AND loginAccount = ${r'#{loginAccount}'}
                </if>
                <if test="password!=null and password!=''">
                    AND password = ${r'#{password}'}
                </if>
                <if test="phone!=null and phone!=''">
                    AND phone = ${r'#{phone}'}
                </if>
                <if test="idcard!=null and idcard!=''">
                    AND idcard = ${r'#{idcard}'}
                </if>
                <if test="role!=null and role!=''">
                    AND role = ${r'#{role}'}
                </if>
                <if test="permissions!=null and permissions!=''">
                    AND permissions = ${r'#{permissions}'}
                </if>
                <if test="state!=null and state!=''">
                    AND state = ${r'#{state}'}
                </if>
                <if test="operatorCode!=null and operatorCode!=''">
                    AND operatorCode = ${r'#{operatorCode}'}
                </if>
                <if test="operatorName!=null and operatorName!=''">
                    AND operatorName = ${r'#{operatorName}'}
                </if>
                <if test="createTimeBegin!=null">
                    AND createTime >= ${r'#{createTimeBegin}'}
                </if>
                <if test="createTimeEnd!=null">
                    AND createTime &lt;= ${r'#{createTimeEnd}'}
                </if>
                <if test="updateTimeBegin!=null">
                    AND updateTime >= ${r'#{updateTimeBegin}'}
                </if>
                <if test="updateTimeEnd!=null">
                    AND updateTime &lt;= ${r'#{updateTimeEnd}'}
                </if>
        </where>
    </sql>

    <!--向admin插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="Admin">
        INSERT INTO `admin` (
            id ,
            code ,
            name ,
            loginAccount ,
            password ,
            phone ,
            idcard ,
            role ,
            permissions ,
            state ,
            operatorCode ,
            operatorName ,
            createTime ,
            updateTime
        ) VALUES (
            ${r'#{id}'} ,
            ${r'#{code}'} ,
            ${r'#{name}'} ,
            ${r'#{loginAccount}'} ,
            ${r'#{password}'} ,
            ${r'#{phone}'} ,
            ${r'#{idcard}'} ,
            ${r'#{role}'} ,
            ${r'#{permissions}'} ,
            ${r'#{state}'} ,
            ${r'#{operatorCode}'} ,
            ${r'#{operatorName}'} ,
            ${r'#{createTime}'} ,
            ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向admin批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="Admin">
        INSERT INTO `admin` (
            id ,
            code ,
            name ,
            loginAccount ,
            password ,
            phone ,
            idcard ,
            role ,
            permissions ,
            state ,
            operatorCode ,
            operatorName ,
            createTime ,
            updateTime
        ) VALUES
        <foreach item='item' index='index' collection='list' separator=','>
        (
            ${r'#{item.id}'},
            ${r'#{item.code}'},
            ${r'#{item.name}'},
            ${r'#{item.loginAccount}'},
            ${r'#{item.password}'},
            ${r'#{item.phone}'},
            ${r'#{item.idcard}'},
            ${r'#{item.role}'},
            ${r'#{item.permissions}'},
            ${r'#{item.state}'},
            ${r'#{item.operatorCode}'},
            ${r'#{item.operatorName}'},
            ${r'#{item.createTime}'},
            ${r'#{item.updateTime}'}
        )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--根据主键更新 admin 的数据-->
    <update id="update" parameterType="Admin">
        UPDATE `admin`
        <trim prefix="set" suffixOverrides=",">
            <if test="code!=null and code!=''">
            code = ${r'#{code}'} ,
            </if>
            <if test="name!=null and name!=''">
            name = ${r'#{name}'} ,
            </if>
            <if test="loginAccount!=null and loginAccount!=''">
            loginAccount = ${r'#{loginAccount}'} ,
            </if>
            <if test="password!=null and password!=''">
            password = ${r'#{password}'} ,
            </if>
            <if test="phone!=null and phone!=''">
            phone = ${r'#{phone}'} ,
            </if>
            <if test="idcard!=null and idcard!=''">
            idcard = ${r'#{idcard}'} ,
            </if>
            <if test="role!=null and role!=''">
            role = ${r'#{role}'} ,
            </if>
            <if test="permissions!=null and permissions!=''">
            permissions = ${r'#{permissions}'} ,
            </if>
            <if test="state!=null and state!=''">
            state = ${r'#{state}'} ,
            </if>
            <if test="operatorCode!=null and operatorCode!=''">
            operatorCode = ${r'#{operatorCode}'} ,
            </if>
            <if test="operatorName!=null and operatorName!=''">
            operatorName = ${r'#{operatorName}'} ,
            </if>
            <if test="createTime!=null">
            createTime = ${r'#{createTime}'} ,
            </if>
            <if test="updateTime!=null">
            updateTime = ${r'#{updateTime}'}
            </if>
        </trim>
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="createTimeBegin!=null">
                AND createTime >= ${r'#{createTimeBegin}'}
            </if>
            <if test="createTimeEnd!=null">
                AND createTime &lt;= ${r'#{createTimeEnd}'}
            </if>
            <if test="updateTimeBegin!=null">
                AND updateTime >= ${r'#{updateTimeBegin}'}
            </if>
            <if test="updateTimeEnd!=null">
                AND updateTime &lt;= ${r'#{updateTimeEnd}'}
            </if>
        </where>
    </update>

    <!--根据任意条件删除admin信息-->
    <delete id="delete">
        DELETE FROM `admin`
        <include refid="where"/>
    </delete>

    <!--根据任何条件加载一条admin的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `admin`
        <include refid="where"/>
    </select>

    <!--查询一条admin loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `admin`
        where id = ${r'#{id}'}
    </select>

    <!--根据任何条件统计admin数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `admin`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询admin-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `admin`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>
</mapper>