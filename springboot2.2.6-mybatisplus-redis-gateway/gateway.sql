DROP DATABASE IF EXISTS gateway;
CREATE DATABASE gateway DEFAULT CHARSET utf8mb4;

USE gateway;

-- 网关路由表
DROP TABLE IF EXISTS gateway_route;
CREATE TABLE gateway_route
(
    id          VARCHAR(20) PRIMARY KEY COMMENT 'id',
    route_id    VARCHAR(100) NOT NULL COMMENT '路由id',
    uri         VARCHAR(100) NOT NULL COMMENT 'uri路径',
    predicates  TEXT         NOT NULL COMMENT '判定器',
    filters     TEXT COMMENT '过滤器',
    orders      INT COMMENT '排序',
    description VARCHAR(500) COMMENT '描述',
    status      VARCHAR(1) COMMENT '状态: 启用 Enable, 停用 Disable ',
    create_time DATETIME     NOT NULL COMMENT '创建时间',
    update_time DATETIME     NOT NULL COMMENT '更新时间'
) COMMENT '网关路由表' CHARACTER SET = utf8mb4
                  COLLATE = utf8mb4_general_ci;

CREATE UNIQUE INDEX ux_gateway_routes_uri ON gateway_route (uri);