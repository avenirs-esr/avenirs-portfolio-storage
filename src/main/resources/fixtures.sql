
\connect avenirs_access_control

DELETE FROM role;
DELETE FROM permission;
DELETE FROM action;

INSERT INTO role (name, description) 
VALUES 
('ROLE_GUEST', 'Default role'),
('ROLE_OWNER', 'Owner of the resource'),
('ROLE_HEAD_TEACHER', 'Teacher able to provide feedback'),
('ROLE_CONTRIBUTOR', 'Contributor for the resource'),
('ROLE_PAIR', 'Pair that can do feedback');


INSERT INTO permission (name, description) 
VALUES
('PERM_SEE', 'See permission'),
('PERM_READ', 'Read permission'),
('PERM_WRITE', 'Write permission'),
('PERM_COMMENT', 'Comments and feedbacks'),
('PERM_SHARE', 'Share permission'),
('PERM_DELETE', 'Delete permission');


INSERT INTO action (name, description) 
VALUES
('ACT_SHARE_READ_RESOURCE', 'Share a resource readonly'),
('ACT_SHARE_WRITE_RESOURCE', 'Share a portfolio read and write'),
('ACT_DISPLAY', 'Visualize a resource'),
('ACT_EDIT', 'Edit a resource'),
('ACT_DO_FEEDBACK', 'Do a feedback');

INSERT INTO action_permission (id_action, id_permission) 
VALUES 
((SELECT id FROM action WHERE action.name = 'ACT_SHARE_READ_RESOURCE'), (SELECT id FROM permission WHERE permission.name = 'PERM_SHARE')),
((SELECT id FROM action WHERE action.name = 'ACT_SHARE_WRITE_RESOURCE'), (SELECT id FROM permission WHERE permission.name = 'PERM_SHARE')),
((SELECT id FROM action WHERE action.name = 'ACT_DISPLAY'), (SELECT id FROM permission WHERE permission.name = 'PERM_READ')),
((SELECT id FROM action WHERE action.name = 'ACT_EDIT'), (SELECT id FROM permission WHERE permission.name = 'PERM_WRITE')),
((SELECT id FROM action WHERE action.name = 'ACT_DO_FEEDBACK'), (SELECT id FROM permission WHERE permission.name = 'PERM_WRITE'));

INSERT INTO role_permission (id_role, id_permission) 
VALUES 
((SELECT id FROM role WHERE role.name = 'ROLE_OWNER'), (SELECT id FROM permission WHERE permission.name = 'PERM_WRITE')),
((SELECT id FROM role WHERE role.name = 'ROLE_OWNER'), (SELECT id FROM permission WHERE permission.name = 'PERM_DELETE')),
((SELECT id FROM role WHERE role.name = 'ROLE_OWNER'), (SELECT id FROM permission WHERE permission.name = 'PERM_SHARE')),
((SELECT id FROM role WHERE role.name = 'ROLE_PAIR'), (SELECT id FROM permission WHERE permission.name = 'PERM_READ')),
((SELECT id FROM role WHERE role.name = 'ROLE_PAIR'), (SELECT id FROM permission WHERE permission.name = 'PERM_COMMENT')),
((SELECT id FROM role WHERE role.name = 'ROLE_CONTRIBUTOR'), (SELECT id FROM permission WHERE permission.name = 'PERM_WRITE'));



