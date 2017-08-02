DROP TABLE IF EXISTS grouprooms;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS groups;


CREATE TABLE groups(
	group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(30)
);

INSERT INTO groups(group_name)
VALUES
('I.T.'), ('Sales'), ('Administration'), ('Operations');

CREATE TABLE users(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100),
    group_id INT,
    CONSTRAINT FOREIGN KEY (group_id) REFERENCES groups(group_id)
);

INSERT INTO users (user_name, group_id)
VALUES
('Modesto', 1), 
('Ayine', 1), 
('Christopher', 2), 
('Cheong woo', 2), 
('Saulot', 3), 
('Heidy', NULL);

CREATE TABLE rooms(
	room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(30)
);

INSERT INTO rooms(room_name)
VALUES
('101'),
('102'),
('Auditorium A'),
('Auditorium B');

CREATE TABLE grouprooms(
	grouproom_id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT,
    CONSTRAINT FOREIGN KEY(room_id) REFERENCES rooms(room_id) ON DELETE SET NULL,
	group_id INT,
    CONSTRAINT FOREIGN KEY(group_id) REFERENCES groups(group_id) ON DELETE SET NULL
);

INSERT INTO grouprooms(room_id, group_id)
VALUES
(1, 1),
(2, 1), 
(2, 2),
(3, 2),
(NULL, 4);


SELECT g.group_name AS 'Group', u.user_name AS 'Name' FROM groups g
LEFT JOIN users u 
ON g.group_id = u.group_id;

SELECT r.room_name AS 'Room', g.group_name AS 'Group' FROM rooms r
LEFT JOIN grouprooms gr
ON r.room_id = gr.room_id
LEFT JOIN groups g
ON gr.group_id = g.group_id;


SELECT u.user_name AS 'Name', g.group_name AS 'Group', r.room_name AS 'Room' FROM users u
LEFT JOIN groups g
ON u.group_id = g.group_id
LEFT JOIN grouprooms gr
ON g.group_id = gr.group_id
LEFT JOIN rooms r
ON gr.room_id = r.room_id
ORDER BY u.user_name ASC, g.group_name ASC, r.room_name ASC;
