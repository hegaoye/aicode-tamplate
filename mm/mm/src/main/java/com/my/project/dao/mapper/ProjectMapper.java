package com.my.project.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.my.core.cache.MybatisRedisCache;
import com.my.project.entity.Project;
import org.apache.ibatis.annotations.CacheNamespace;
import org.springframework.stereotype.Repository;

/**
 * Project mapper
 * 直接与xml映射
 */
@Repository
@CacheNamespace(implementation = MybatisRedisCache.class, eviction = MybatisRedisCache.class)
public interface ProjectMapper extends BaseMapper<Project> {

}
