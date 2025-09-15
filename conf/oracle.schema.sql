CREATE TABLE config_info (
    id NUMBER(20) NOT NULL,
    data_id varchar2(255) NOT NULL,
    group_id varchar2(128) NOT NULL,
    tenant_id varchar2(128) default '',
    app_name varchar2(128),
    content CLOB NOT NULL,
    md5 varchar2(32) DEFAULT NULL,
    gmt_create timestamp(3) NOT NULL DEFAULT TIMESTAMP '2010-05-05 00:00:00.000',
    gmt_modified timestamp(3) NOT NULL DEFAULT TIMESTAMP '2010-05-05 00:00:00.000',
    src_user varchar2(128) DEFAULT NULL,
    src_ip varchar2(50) DEFAULT NULL,
    c_desc varchar2(256) DEFAULT NULL,
    c_use varchar2(64) DEFAULT NULL,
    effect varchar2(64) DEFAULT NULL,
    type varchar2(64) DEFAULT NULL,
    c_schema CLOB DEFAULT NULL,
    encrypted_data_key CLOB DEFAULT NULL,
    constraint configinfo_id_key PRIMARY KEY (id),
    constraint uk_configinfo_datagrouptenant UNIQUE (data_id,group_id,tenant_id)
);

CREATE SEQUENCE seq_config_info
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_config_info_insert
before insert on config_info for each row
begin
select seq_config_info.nextval into :new.id from dual;
end;

CREATE INDEX idx_config_info_dataid ON config_info(data_id);
CREATE INDEX idx_config_info_groupid ON config_info(group_id);
CREATE INDEX idx_config_info_dataid_group ON config_info(data_id, group_id);

CREATE TABLE his_config_info (
    id NUMBER(20) NOT NULL,
    nid NUMBER(20) NOT NULL,
    data_id varchar2(255) NOT NULL,
    group_id varchar2(128) NOT NULL,
    tenant_id varchar2(128) default '',
    app_name varchar2(128),
    content CLOB NOT NULL,
    md5 varchar2(32) DEFAULT NULL,
    gmt_create timestamp(3) NOT NULL DEFAULT TIMESTAMP '2010-05-05 00:00:00.000',
    gmt_modified timestamp(3) NOT NULL DEFAULT TIMESTAMP '2010-05-05 00:00:00.000',
    src_user varchar2(128),
    src_ip varchar2(50) DEFAULT NULL,
    publish_type varchar2(50) DEFAULT 'formal',
    gray_name varchar2(128) DEFAULT NULL,
    ext_info CLOB,
    op_type char(10) DEFAULT NULL,
    encrypted_data_key CLOB DEFAULT NULL,
    constraint hisconfiginfo_nid_key PRIMARY KEY (nid)
);

CREATE SEQUENCE seq_his_config_info
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_his_config_info_insert
before insert on his_config_info for each row
begin
select seq_his_config_info.nextval into :new.nid from dual;
end;

CREATE INDEX idx_his_config_info_dataid ON his_config_info(data_id);
CREATE INDEX idx_his_config_info_gmt_create ON his_config_info(gmt_create);
CREATE INDEX idx_his_config_info_gmt_modified ON his_config_info(gmt_modified);

CREATE TABLE config_info_gray (
    id NUMBER(20) NOT NULL,
    data_id varchar2(255) NOT NULL,
    group_id varchar2(128) NOT NULL,
    tenant_id varchar2(128) default '',
    gray_name varchar2(128) NOT NULL,
    gray_rule CLOB,
    app_name varchar2(128),
    content CLOB NOT NULL,
    md5 varchar2(32) DEFAULT NULL,
    src_user varchar2(128) DEFAULT NULL,
    src_ip varchar2(100) DEFAULT NULL,
    gmt_create timestamp(3) NOT NULL DEFAULT TIMESTAMP '2010-05-05 00:00:00.000',
    gmt_modified timestamp(3) NOT NULL DEFAULT TIMESTAMP '2010-05-05 00:00:00.000',
    encrypted_data_key varchar2(256) DEFAULT '',
    constraint configinfogray_id_key PRIMARY KEY (id),
    constraint uk_configinfogray_datagrouptenantgrayname UNIQUE (data_id,group_id,tenant_id,gray_name)
);

CREATE SEQUENCE seq_config_info_gray
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_config_info_gray_insert
before insert on config_info_gray for each row
begin
select seq_config_info_gray.nextval into :new.id from dual;
end;

CREATE INDEX idx_config_info_gray_di_gm ON config_info_gray(data_id,gmt_modified);
CREATE INDEX idx_config_info_gray_gm ON config_info_gray(gmt_modified);

CREATE TABLE app_list (
    id NUMBER(20) NOT NULL,
    app_name varchar2(128) NOT NULL,
    is_dynamic_collect_disabled NUMBER(1) DEFAULT 0,
    last_sub_info_collected_time timestamp DEFAULT TIMESTAMP '1970-01-01 08:00:00',
    sub_info_lock_owner varchar2(128),
    sub_info_lock_time timestamp DEFAULT TIMESTAMP '1970-01-01 08:00:00',
    constraint applist_id_key PRIMARY KEY (id),
    constraint uk_appname UNIQUE (app_name)
);

CREATE SEQUENCE seq_app_list
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_app_list_insert
before insert on app_list for each row
begin
select seq_app_list.nextval into :new.id from dual;
end;

CREATE TABLE app_configdata_relation_subs (
    id NUMBER(20) NOT NULL,
    app_name varchar2(128) NOT NULL,
    data_id varchar2(255) NOT NULL,
    group_id varchar2(128) NOT NULL,
    gmt_modified timestamp DEFAULT TIMESTAMP '2010-05-05 00:00:00',
    constraint configdatarelationsubs_id_key PRIMARY KEY (id),
    constraint uk_app_sub_config_datagroup UNIQUE (app_name, data_id, group_id)
);

CREATE SEQUENCE seq_app_configdata_rel_subs
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_app_rel_subs_insert
before insert on app_configdata_relation_subs for each row
begin
select seq_app_configdata_rel_subs.nextval into :new.id from dual;
end;

CREATE TABLE app_configdata_relation_pubs (
    id NUMBER(20) NOT NULL,
    app_name varchar2(128) NOT NULL,
    data_id varchar2(255) NOT NULL,
    group_id varchar2(128) NOT NULL,
    gmt_modified timestamp DEFAULT TIMESTAMP '2010-05-05 00:00:00',
    constraint configdatarelationpubs_id_key PRIMARY KEY (id),
    constraint uk_app_pub_config_datagroup UNIQUE (app_name, data_id, group_id)
);

CREATE SEQUENCE seq_app_configdata_rel_pubs
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_app_rel_pubs_insert
before insert on app_configdata_relation_pubs for each row
begin
select seq_app_configdata_rel_pubs.nextval into :new.id from dual;
end;

CREATE TABLE config_tags_relation (
    id NUMBER(20) NOT NULL,
    tag_name varchar2(128) NOT NULL,
    tag_type varchar2(64) DEFAULT NULL,
    data_id varchar2(255) NOT NULL,
    group_id varchar2(128) NOT NULL,
    tenant_id varchar2(128) DEFAULT '',
    nid NUMBER(20) NOT NULL,
    constraint config_tags_id_key PRIMARY KEY (nid),
    constraint uk_configtagrelation_configidtag UNIQUE (id, tag_name, tag_type)
);

CREATE SEQUENCE seq_config_tags_relation
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_config_tags_relation_insert
before insert on config_tags_relation for each row
begin
select seq_config_tags_relation.nextval into :new.nid from dual;
end;

CREATE INDEX idx_config_tags_tenant_id ON config_tags_relation(tenant_id);

CREATE TABLE group_capacity (
    id NUMBER(20) NOT NULL,
    group_id varchar2(128) DEFAULT '',
    quota NUMBER(10) DEFAULT 0,
    usage NUMBER(10) DEFAULT 0,
    max_size NUMBER(10) DEFAULT 0,
    max_aggr_count NUMBER(10) DEFAULT 0,
    max_aggr_size NUMBER(10) DEFAULT 0,
    max_history_count NUMBER(10) DEFAULT 0,
    gmt_create timestamp DEFAULT TIMESTAMP '2010-05-05 00:00:00',
    gmt_modified timestamp DEFAULT TIMESTAMP '2010-05-05 00:00:00',
    constraint group_capacity_id_key PRIMARY KEY (id),
    constraint uk_group_id UNIQUE (group_id)
);

CREATE SEQUENCE seq_group_capacity
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_group_capacity_insert
before insert on group_capacity for each row
begin
select seq_group_capacity.nextval into :new.id from dual;
end;

CREATE TABLE tenant_capacity (
    id NUMBER(20) NOT NULL,
    tenant_id varchar2(128) DEFAULT '',
    quota NUMBER(10) DEFAULT 0,
    usage NUMBER(10) DEFAULT 0,
    max_size NUMBER(10) DEFAULT 0,
    max_aggr_count NUMBER(10) DEFAULT 0,
    max_aggr_size NUMBER(10) DEFAULT 0,
    max_history_count NUMBER(10) DEFAULT 0,
    gmt_create timestamp DEFAULT TIMESTAMP '2010-05-05 00:00:00',
    gmt_modified timestamp DEFAULT TIMESTAMP '2010-05-05 00:00:00',
    constraint tenant_capacity_id_key PRIMARY KEY (id),
    constraint uk_tenant_id UNIQUE (tenant_id)
);

CREATE SEQUENCE seq_tenant_capacity
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_tenant_capacity_insert
before insert on tenant_capacity for each row
begin
select seq_tenant_capacity.nextval into :new.id from dual;
end;

CREATE TABLE tenant_info (
    id NUMBER(20) NOT NULL,
    kp varchar2(128) NOT NULL,
    tenant_id varchar2(128) DEFAULT '',
    tenant_name varchar2(128) DEFAULT '',
    tenant_desc varchar2(256) DEFAULT NULL,
    create_source varchar2(32) DEFAULT NULL,
    gmt_create NUMBER(20) NOT NULL,
    gmt_modified NUMBER(20) NOT NULL,
    constraint tenant_info_id_key PRIMARY KEY (id),
    constraint uk_tenant_info_kptenantid UNIQUE (kp,tenant_id)
);

CREATE SEQUENCE seq_tenant_info
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCACHE;

create or replace trigger tr_tenant_info_insert
before insert on tenant_info for each row
begin
select seq_tenant_info.nextval into :new.id from dual;
end;

CREATE INDEX idx_tenant_info_tenant_id ON tenant_info(tenant_id);

CREATE TABLE users (
    username varchar2(50) NOT NULL PRIMARY KEY,
    password varchar2(500) NOT NULL,
    enabled NUMBER(1) DEFAULT 1 NOT NULL
);

CREATE TABLE roles (
    username varchar2(50) NOT NULL,
    role varchar2(50) NOT NULL,
    constraint uk_username_role UNIQUE (username,role)
);

CREATE TABLE permissions (
    role varchar2(50) NOT NULL,
    resource varchar2(512) NOT NULL,
    action varchar2(8) NOT NULL,
    constraint uk_role_permission UNIQUE (role,resource,action)
);