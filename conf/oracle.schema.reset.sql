-- Drop sequences first
DROP SEQUENCE seq_config_info;
DROP SEQUENCE seq_his_config_info;
DROP SEQUENCE seq_config_info_gray;
DROP SEQUENCE seq_app_list;
DROP SEQUENCE seq_app_configdata_rel_subs;
DROP SEQUENCE seq_app_configdata_rel_pubs;
DROP SEQUENCE seq_config_tags_relation;
DROP SEQUENCE seq_group_capacity;
DROP SEQUENCE seq_tenant_capacity;
DROP SEQUENCE seq_tenant_info;

-- Drop triggers
DROP TRIGGER tr_config_info_insert;
DROP TRIGGER tr_his_config_info_insert;
DROP TRIGGER tr_config_info_gray_insert;
DROP TRIGGER tr_app_list_insert;
DROP TRIGGER tr_app_configdata_rel_subs_insert;
DROP TRIGGER tr_app_configdata_rel_pubs_insert;
DROP TRIGGER tr_config_tags_relation_insert;
DROP TRIGGER tr_group_capacity_insert;
DROP TRIGGER tr_tenant_capacity_insert;
DROP TRIGGER tr_tenant_info_insert;

-- Drop indexes first
DROP INDEX idx_tenant_info_tenant_id;
DROP INDEX idx_config_tags_tenant_id;
DROP INDEX idx_config_info_gray_gm;
DROP INDEX idx_config_info_gray_di_gm;
DROP INDEX idx_his_config_info_gmt_modified;
DROP INDEX idx_his_config_info_gmt_create;
DROP INDEX idx_his_config_info_dataid;
DROP INDEX idx_config_info_dataid_group;
DROP INDEX idx_config_info_groupid;
DROP INDEX idx_config_info_dataid;

-- Drop tables (in reverse order of dependencies)
DROP TABLE permissions;
DROP TABLE roles;
DROP TABLE users;
DROP TABLE tenant_info;
DROP TABLE tenant_capacity;
DROP TABLE group_capacity;
DROP TABLE config_tags_relation;
DROP TABLE app_configdata_relation_pubs;
DROP TABLE app_configdata_relation_subs;
DROP TABLE app_list;
DROP TABLE config_info_gray;
DROP TABLE his_config_info;
DROP TABLE config_info;
