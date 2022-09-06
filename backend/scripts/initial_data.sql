INSERT INTO `todo`.`user`
(`email`,
`passwrod`)
VALUES
('AnyValue',
'anyPass');


INSERT INTO `todo`.`todo_list`
(`name`,
`user_id`)
VALUES
('AnyName',
1);


INSERT INTO `todo`.`task`
(`todo_id`,
`name`,
`task_child_id`)
VALUES
(1,
'AnyName',
2);
