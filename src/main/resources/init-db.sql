\connect template1;

DROP DATABASE IF EXISTS avenirs_access_control;
DROP ROLE  IF EXISTS  avenirs_security_admin;
DROP ROLE  IF EXISTS avenirs_security_admin_role;

CREATE ROLE avenirs_security_admin_role SUPERUSER; 
CREATE ROLE avenirs_security_admin PASSWORD 'S33c@DM4avn' NOSUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;
GRANT avenirs_security_admin_role to avenirs_security_admin;


CREATE DATABASE avenirs_access_control OWNER avenirs_security_admin;

GRANT ALL PRIVILEGES ON DATABASE avenirs_access_control TO avenirs_security_admin_role;

\connect avenirs_access_control

CREATE TABLE role(
	id serial,
	name VARCHAR(80) NOT NULL,
	description VARCHAR(255),
	
	CONSTRAINT role_pk PRIMARY KEY(id)
);
ALTER TABLE role OWNER TO avenirs_security_admin_role;

CREATE TABLE permission(
	id serial,
	name VARCHAR(80) NOT NULL,
	description VARCHAR(255),
	
	CONSTRAINT permission_pk PRIMARY KEY(id)
);
ALTER TABLE permission OWNER TO avenirs_security_admin_role;

CREATE TABLE action(
	id serial,
	name VARCHAR(80) NOT NULL,
	description VARCHAR(255),
	
	CONSTRAINT action_pk PRIMARY KEY(id)
);
ALTER TABLE action OWNER TO avenirs_security_admin_role;


-- The resources field is used to determine the linked resources, this is a first
-- step.  To be improved.
CREATE TABLE scope(
	id serial,
	name VARCHAR(80),
	description VARCHAR(255),
	resources TEXT NOT NULL,
	CONSTRAINT scope_pk PRIMARY KEY(id)
);
ALTER TABLE scope OWNER TO avenirs_security_admin_role;

CREATE TABLE context(
	id serial,
	name VARCHAR(80),
	description VARCHAR(255),
	validityStart TIMESTAMP,
	validityEnd TIMESTAMP,
	establishment VARCHAR(255),
	CONSTRAINT context_pk PRIMARY KEY(id)
);
ALTER TABLE context OWNER TO avenirs_security_admin_role;

CREATE TABLE action_permission(
	id_action INTEGER,
	id_permission INTEGER,
	CONSTRAINT action_permission_pk PRIMARY KEY(id_permission, id_action)
);
ALTER TABLE action_permission OWNER TO avenirs_security_admin_role;

ALTER TABLE action_permission ADD CONSTRAINT action_permission_id_action_fk FOREIGN KEY(id_action)
REFERENCES action(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE action_permission ADD CONSTRAINT action_permission_id_permission_fk FOREIGN KEY(id_permission)
REFERENCES permission(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

CREATE TABLE role_permission(
	id_role INTEGER,
	id_permission INTEGER,
	CONSTRAINT role_permission_pk PRIMARY KEY(id_role,id_permission)
);
ALTER TABLE role_permission OWNER TO avenirs_security_admin_role;

ALTER TABLE role_permission ADD CONSTRAINT role_permission_id_role_fk FOREIGN KEY(id_role)
REFERENCES role(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE role_permission ADD CONSTRAINT role_permission_id_permission_fk FOREIGN KEY(id_permission)
REFERENCES permission(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

CREATE TABLE role_assignment(
	id_role INTEGER,
	id_user VARCHAR(40) NOT NULL,
	id_scope INTEGER,
	id_context INTEGER,
	CONSTRAINT role_assignment_pk PRIMARY KEY(id_role, id_user, id_scope, id_context)
);
ALTER TABLE role_assignment OWNER TO avenirs_security_admin_role;

ALTER TABLE role_assignment ADD CONSTRAINT role_assignment_id_role_fk FOREIGN KEY(id_role)
REFERENCES role(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE role_assignment ADD CONSTRAINT role_assignment_id_scope_fk FOREIGN KEY(id_scope)
REFERENCES scope(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE role_assignment ADD CONSTRAINT role_assignment_id_context_fk FOREIGN KEY(id_context)
REFERENCES context(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE role_assignment ADD CONSTRAINT role_assignment_id_user_fk FOREIGN KEY(id_role)
REFERENCES role(id) MATCH FULL
ON DELETE CASCADE NOT DEFERRABLE;

-- The user deletion will have to be processed
-- ALTER TABLE role_assignment ADD CONSTRAINT role_assignment_id_user_fk FOREIGN KEY(id_role)
-- REFERENCES role(id) MATCH FULL
-- ON DELETE CASCADE NOT DEFERRABLE;



