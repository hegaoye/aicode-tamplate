<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacAdminDAO">

    <resultMap id="rs_base" type="RbacAdmin">
        <result property="id" column="id"/>
        <result property="code" column="code"/>
        <result property="account" column="account"/>
        <result property="phone" column="phone"/>
        <result property="email" column="email"/>
        <result property="idcard" column="idcard"/>
        <result property="password" column="password"/>
        <result property="name" column="name"/>
        <result property="whetherAuth" column="whether_auth"/>
        <result property="state" column="state"/>
        <result property="type" column="type"/>
        <result property="creatorCode" column="creator_code"/>
        <result property="createTime" column="create_time"/>
        <result property="updateTime" column="update_time"/>
    </resultMap>

    <sql id="columns">
    id,code,account,phone,email,idcard,password,name,whether_auth,state,type,creator_code,create_time,update_time
    </sql>

    <resultMap id="rs_base_creator" type="RbacAdmin" extends="rs_base">
        <association property="creatorName" column="{code=creator_code}" select="getCreatorName"></association>
    </resultMap>

    <resultMap id="rs_base_relation" type="RbacAdmin" extends="rs_base">
        <collection property="rbacAdminRoleRelationList" column="{adminCode=code}"
                    select="${basePackage}.rbac.dao.RbacAdminRoleRelationDAO.queryForOneToMany"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null and id!=''">
                AND id = ${r'#{id}'}
            </if>
            <if test="code!=null and code!=''">
                AND code = ${r'#{code}'}
            </if>
            <if test="account!=null and account!=''">
                AND account = ${r'#{account}'}
            </if>
            <if test="phone!=null and phone!=''">
                AND phone = ${r'#{phone}'}
            </if>
            <if test="email!=null and email!=''">
                AND email = ${r'#{email}'}
            </if>
            <if test="idcard!=null and idcard!=''">
                AND idcard = ${r'#{idcard}'}
            </if>
            <if test="password!=null and password!=''">
                AND password = ${r'#{password}'}
            </if>
            <if test="name!=null and name!=''">
                AND name = ${r'#{name}'}
            </if>
            <if test="whetherAuth!=null and whetherAuth!=''">
                AND whether_auth = ${r'#{whetherAuth}'}
            </if>
            <if test="state!=null and state!=''">
                AND state = ${r'#{state}'}
            </if>
            <if test="type!=null and type!=''">
                AND type = ${r'#{type}'}
            </if>
            <if test="creatorCode!=null and creatorCode!=''">
                AND creator_code = ${r'#{creatorCode}'}
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

    <!--向rbac_admin插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacAdmin">
        INSERT INTO `rbac_admin` (
        id ,
        code ,
        account ,
        phone ,
        email ,
        idcard ,
        password ,
        name ,
        whether_auth ,
        state ,
        type ,
        creator_code ,
        create_time ,
        update_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{code}'} ,
        ${r'#{account}'} ,
        ${r'#{phone}'} ,
        ${r'#{email}'} ,
        ${r'#{idcard}'} ,
        ${r'#{password}'} ,
        ${r'#{name}'} ,
        ${r'#{whetherAuth}'} ,
        ${r'#{state}'} ,
        ${r'#{type}'} ,
        ${r'#{creatorCode}'} ,
        ${r'#{createTime}'} ,
        ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_admin批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacAdmin">
        INSERT INTO `rbac_admin` (
        id ,
        code ,
        account ,
        phone ,
        email ,
        idcard ,
        password ,
        name ,
        whether_auth ,
        state ,
        type ,
        creator_code ,
        create_time ,
        update_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'}'}'},
            ${r'#{item.code}'}'}'},
            ${r'#{item.account}'}'}'},
            ${r'#{item.phone}'}'}'},
            ${r'#{item.email}'}'}'},
            ${r'#{item.idcard}'}'}'},
            ${r'#{item.password}'}'}'},
            ${r'#{item.name}'}'}'},
            ${r'#{item.whetherAuth}'}'}'},
            ${r'#{item.state}'}'}'},
            ${r'#{item.type}'}'}'},
            ${r'#{item.creatorCode}'}'}'},
            ${r'#{item.createTime}'}'}'},
            ${r'#{item.updateTime}'}'}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_admin -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_admin`
        <trim prefix="set" suffixOverrides=",">
            <trim prefix="code = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="code!=null and code!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.code}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="account = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="account!=null and account!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.account}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="phone = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="phone!=null and phone!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.phone}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="email = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="email!=null and email!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.email}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="idcard = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="idcard!=null and idcard!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.idcard}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="password = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="password!=null and password!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.password}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="name = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="name!=null and name!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.name}'}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="whether_auth = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="whetherAuth!=null and whetherAuth!=''">
                        when id = ${r'#{item.id}'}'} then ${r'#{item.whetherAuth}'}'}
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
            <trim prefix="creator_code = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="creatorCode!=null and creatorCode!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.creatorCode}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="create_time = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="item.createTime!=null">
                        when id = ${r'#{item.id}'} then ${r'#{item.createTime}'}
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

    <!--根据主键更新 rbac_admin 的数据-->
    <update id="update" parameterType="RbacAdmin">
        UPDATE `rbac_admin`
        <trim prefix="set" suffixOverrides=",">
            <if test="account!=null and account!=''">
                account = ${r'#{account}'} ,
            </if>
            <if test="phone!=null and phone!=''">
                phone = ${r'#{phone}'} ,
            </if>
            <if test="email!=null and email!=''">
                email = ${r'#{email}'} ,
            </if>
            <if test="idcard!=null and idcard!=''">
                idcard = ${r'#{idcard}'} ,
            </if>
            <if test="password!=null and password!=''">
                password = ${r'#{password}'} ,
            </if>
            <if test="name!=null and name!=''">
                name = ${r'#{name}'} ,
            </if>
            <if test="whetherAuth!=null">
                whether_auth = ${r'#{whetherAuth}'} ,
            </if>
            <if test="state!=null and state!=''">
                state = ${r'#{state}'} ,
            </if>
            <if test="creatorCode!=null and creatorCode!=''">
                creator_code = ${r'#{creatorCode}'} ,
            </if>
            <if test="updateTime!=null">
                update_time = ${r'#{updateTime}'}
            </if>
        </trim>
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="code!=null and code!=''">
                and code = ${r'#{code}'}
            </if>
        </where>
    </update>


    <!--查询关联数据-->
    <select id="getDetail" resultMap="rs_base_relation">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin`
        <include refid="where"/>
    </select>

    <!--根据编码获得创建者姓名-->
    <select id="getCreatorName" parameterType="map" resultType="string">
        select name from rbac_admin where code = ${r'#{code}'}
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_admin 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_admin`
        <trim prefix="set" suffixOverrides=",">
            <if test="newState!=null">
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

    <!--根据主键更新 rbac_admin 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_admin`
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


    <!--根据任意条件删除rbac_admin信息-->
    <delete id="delete">
        DELETE FROM `rbac_admin`
        <include refid="where"/>
    </delete>
    <!--删除管理员-->
    <delete id="deleteByCode" parameterType="string">
        delete from rbac_admin where code = ${r'#{code}'}
    </delete>

    <!--根据任何条件加载一条rbac_admin的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_admin loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin`
        where id = ${r'#{id}'}
    </select>


    <!--根据任何条件统计rbac_admin数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_admin`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_admin-->
    <select id="list" resultMap="rs_base_creator">
        SELECT
        <include refid="columns"/>
        FROM `rbac_admin`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>
    <!--根据编码查询授权用户（管理员）-->
    <select id="loadByCode" resultMap="rs_base_creator">
        select
        <include refid="columns"/>
        from rbac_admin
        where code = ${r'#{code}'}
    </select>


</mapper>
