<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${basePackage}.basic.dao.BasicSettingsDAO">

    <resultMap id="rs_base" type="BasicSettings">
        <result property="id" column="id"/>
        <result property="k" column="k"/>
        <result property="v" column="v"/>
        <result property="remark" column="remark"/>
        <result property="createTime" column="createTime"/>
        <result property="updateTime" column="updateTime"/>
    </resultMap>

    <!--查询表信息关联信息-->

    <sql id="columns">
    id,k,v,remark,createTime,updateTime
    </sql>

    <sql id="where">
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="k!=null and k!=''">
                AND k = ${r'#{k}'}
            </if>
            <if test="ks!=null">
                <foreach collection="ks" item="item" open="and k in (" close=")" separator=",">
                    ${r'#{item}'}
                </foreach>
            </if>
        </where>
    </sql>

    <!--向basic_settings插入一条数据-->
    <insert id="insert" useGeneratedKeys="true" keyProperty="id" parameterType="BasicSettings">
        INSERT INTO `basic_settings` (
        id ,
        k ,
        v ,
        remark ,
        createTime ,
        updateTime
        ) VALUES (
        ${r'#{id}'} ,
        ${r'#{k}'} ,
        ${r'#{v}'} ,
        ${r'#{remark}'} ,
        ${r'#{createTime}'} ,
        ${r'#{updateTime}'}
        )
        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--向basic_settings批量插入数据-->
    <insert id="batchInsert" useGeneratedKeys="true" keyProperty="id" parameterType="BasicSettings">
        INSERT INTO `basic_settings` (
        id ,
        k ,
        v ,
        remark ,
        createTime ,
        updateTime
        ) VALUES
        <foreach item='item' index='index' collection='list' separator=','>
            (
            ${r'#{item.id}'},
            ${r'#{item.k}'},
            ${r'#{item.v}'},
            ${r'#{item.remark}'},
            ${r'#{item.createTime}'},
            ${r'#{item.updateTime}'}
            )
        </foreach>

        <selectKey keyProperty="id" resultType="long">
            select LAST_INSERT_ID()
        </selectKey>
    </insert>

    <!--根据主键更新 basic_settings 的数据-->
    <update id="update" parameterType="BasicSettings">
        UPDATE `basic_settings`
        <trim prefix="set" suffixOverrides=",">
            <if test="v!=null and v!=''">
                v = ${r'#{v}'} ,
            </if>
            <if test="remark!=null and remark!=''">
                remark = ${r'#{remark}'} ,
            </if>
            <if test="updateTime!=null">
                updateTime = ${r'#{updateTime}'}
            </if>
        </trim>
        <where>
            <if test="id!=null">
                AND id = ${r'#{id}'}
            </if>
            <if test="k!=null and k!=''">
                and k = ${r'#{k}'}
            </if>
        </where>
    </update>

    <!--根据任意条件删除basic_settings信息-->
    <delete id="delete">
        DELETE FROM `basic_settings`
        <include refid="where"/>
    </delete>

    <!--根据任何条件加载一条basic_settings的数据-->
    <select id="load" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `basic_settings`
        <include refid="where"/>
    </select>

    <!--根据任何条件统计basic_settings数据条数-->
    <select id="count" resultType="integer">
        SELECT count(1) FROM `basic_settings`
        <include refid="where"/>
    </select>

    <!--根据任何条件分页查询basic_settings-->
    <select id="list" resultMap="rs_base">
        SELECT
        <include refid="columns"/>
        FROM `basic_settings`
        <include refid="where"/>

        <if test="sortColumns!=null and sortColumns!=''">
            ORDER BY ${r'${sortColumns}'}
        </if>
    </select>
    <!--根据键 查询 数据字典-->
    <select id="loadByK" resultType="${basePackage}.basic.entity.BasicSettings">
        SELECT
        <include refid="columns"/>
        FROM `basic_settings`
        where k = ${r'#{k}'}
    </select>
</mapper>
