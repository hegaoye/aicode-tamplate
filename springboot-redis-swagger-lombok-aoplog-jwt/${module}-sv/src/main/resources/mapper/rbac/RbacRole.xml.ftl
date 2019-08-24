<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.rbac.dao.RbacRoleDAO">

    <resultMap id="rs_base" type="RbacRole">
        <result property="id" column="id"/>
        <result property="idPre" column="id_pre"/>
        <result property="roleName" column="role_name"/>
        <result property="state" column="state"/>
        <result property="isLeaf" column="is_leaf"/>
        <result property="description" column="description"/>
        <result property="createTime" column="create_time"/>
        <result property="updateTime" column="update_time"/>
    </resultMap>

    <sql id="columns">
    id,id_pre,role_name,state,is_leaf,description,create_time,update_time
    </sql>

    <resultMap id="rs_base_relation" type="RbacRole" extends="rs_base">
        <collection property="rbacAdminRoleRelationList" column="{role_id=id}"
                    select="${basePackage}.rbac.dao.RbacAdminRoleRelationDAO.queryForOneToMany"/>
        <collection property="rbacRolePermissionRelationList" column="{role_id=id}"
                    select="${basePackage}.rbac.dao.RbacRolePermissionRelationDAO.queryForOneToMany"/>
    </resultMap>

    <sql id="where">
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="idPre!=null">
                AND id_pre = ${r'#{idPre}'}
            </if>
            <if test="roleName!=null and roleName!=''">
                AND role_name = ${r'#{roleName}'}
            </if>
            <if test="state!=null and state!=''">
                AND state = ${r'#{state}'}
            </if>
            <if test="isLeaf!=null and isLeaf!=''">
                AND is_leaf = ${r'#{isLeaf}'}
            </if>
        </where>
    </sql>

    <!--向rbac_role插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacRole">
        INSERT INTO `rbac_role` (
        id ,
        id_pre ,
        role_name ,
        state ,
        is_leaf ,
        description ,
        create_time ,
        update_time
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{idPre}'} ,
        ${r'#{roleName}'} ,
        ${r'#{state}'} ,
        ${r'#{isLeaf}'} ,
        ${r'#{description}'} ,
        ${r'#{createTime}'} ,
        ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向rbac_role批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="RbacRole">
        INSERT INTO `rbac_role` (
        id ,
        id_pre ,
        role_name ,
        state ,
        is_leaf ,
        description ,
        create_time ,
        update_time
        )
        VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.idPre}'},
            ${r'#{item.roleName}'},
            ${r'#{item.state}'},
            ${r'#{item.isLeaf}'},
            ${r'#{item.description}'},
            ${r'#{item.createTime}'},
            ${r'#{item.updateTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!-- 根据主键批量更新  rbac_role -->
    <update id="batchUpdate" parameterType="map">
        update `rbac_role`
        <trim prefix="set" suffixOverrides=",">
            <trim prefix="id_pre = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="idPre!=null and idPre!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.idPre}'}
                    </if>
                </foreach>
            </trim>
            <trim prefix="role_name = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="roleName!=null and roleName!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.roleName}'}
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
            <trim prefix="is_leaf = case" suffix="end,">
                <foreach collection="list" item="item">
                    <if test="isLeaf!=null and isLeaf!=''">
                        when id = ${r'#{item.id}'} then ${r'#{item.isLeaf}'}
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

    <!--根据主键更新 rbac_role 的数据-->
    <update id="update" parameterType="RbacRole">
        UPDATE `rbac_role`
        <trim prefix="set" suffixOverrides=",">
            <if test="idPre!=null and idPre!=''">
                id_pre = ${r'#{idPre}'} ,
            </if>
            <if test="roleName!=null and roleName!=''">
                role_name = ${r'#{roleName}'} ,
            </if>
            <if test="state!=null and state!=''">
                state = ${r'#{state}'} ,
            </if>
            <if test="isLeaf!=null and isLeaf!=''">
                is_leaf = ${r'#{isLeaf}'} ,
            </if>
            <if test="description!=null and description!=''">
                description = ${r'#{description}'} ,
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
        FROM `rbac_role`
        <include refid="where"/>
    </select>

    <!--关联查询一条记录使用-->
    <select id="loadForOneToOne" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role`
        <include refid="where"/>
    </select>

    <!--关联查询集合使用-->
    <select id="queryForOneToMany" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>

    <!--根据主键更新 rbac_role 的数据-->
    <update id="updateStateById" parameterType="map">
        UPDATE `rbac_role`
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

    <!--根据主键更新 rbac_role 的状态数据-->
    <update id="updateById" parameterType="map">
        UPDATE `rbac_role`
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

    <!--更新角色的叶子节点状态-->
    <update id="updateRoleLeaf" parameterType="map">
        update rbac_role
        set is_leaf = ${r'#{isLeaf}'}
        where id = ${r'#{id}'}
    </update>

    <!--根据任意条件删除rbac_role信息-->
    <delete id="delete">
        DELETE FROM `rbac_role`
        <include refid="where"/>
    </delete>

    <!--根据角色id删除角色-->
    <delete id="deleteById" parameterType="long">
        delete from rbac_role where id = ${r'#{id}'}
    </delete>

    <!--根据任何条件加载一条rbac_role的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role`
        <include refid="where"/>
    </select>

    <!--查询一条rbac_role loadById  通过id -->
    <select id="loadById" resultMap="rs_base" parameterType="java.lang.Long">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role`
        where id = ${r'#{id}'}
    </select>


    <!--根据任何条件统计rbac_role数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `rbac_role`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询rbac_role-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `rbac_role`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>


</mapper>
