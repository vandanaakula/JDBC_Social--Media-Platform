use dbmspbl;
/*
TABLE : User
*/
create table User(
Name char(45),
Age int,
DOB date,
Emailid varchar(45) primary key ,
Passwor varchar(45),
PhoneNumber bigint,
Gender char(45),
Location char(50));
insert into User values("Akanksha",23,"2000-08-
25","aaku123@gmail.com","aaku",9642646305,"F","srikakulam");
insert into User values("Amrutha",27,"1997-11-
29","asmi143@gmail.com","Asmi143",8639960458,"F","odisha"),
("Divya",19,"2004-06-18","ddivyaprasanthi@gmail.com","Divya@9848",9848646305,"F","vizag"),
("jai",22,"2002-08-29","jahykrish@gmail.com","1234567",9705929705,"M","pune"),
("vandana",20,"2003-07-13","vandana@gmail.com","vandu",7730056305,"F","salur");

/*TABLE : User_Profile*/

create table User_Profile(
Userid varchar(50) primary key,
Username char(50),
Emailid varchar(50),
foreign key (Emailid) references User(Emailid),
DOB date,
Location char(50),
Work_Profile varchar(50));
insert into User_profile values("amrutha","@asmi","asmi143@gmail.com","1997-11-29","odisha","Manager"),
("dad's_cutie","@akanksha","aaku123@gmail.com","2000-08-25","Srikakulam","Designer"),
("jai","@jai","jahykrish@gmail.com","2002-08-29","pune","Artist"),
("Self_beliver","@divya","ddivyaprasanthi@gmail.com","2004-06-18","vizag","student"),
("vandu","@vandana","vandana@gmail.com","2003-07-13","salur","student");

/*TABLE : Post*/

create table Post(
Postid varchar(45) primary key,
PostType char(50),
Caption Text,
Userid varchar(50),
foreign key(Userid) references User_Profile(Userid));
insert into Post values("p1","reels","This is my new reel","dad's_cutie"),
("p2","images","Hey there new pic alert","vandu"),
("p3","articles","This is my latest trendy article!","amrutha"),
("p4","Gifs","Adding new GIF","jai"),
("p5","blog","This is my new blog","vandu"),
("p6","text","Sunday Funday!","amrutha");

/*TABLE : Comments*/

create table Comments(
Ctype char(10) primary key);
insert into Comments values("GIF"),("Text"),("Emoji");

/*TABLE : Likes*/

create table Likes(
Lstatus char(10) primary key);
INSERT INTO `dbmspbl`.`Likes` (`Lstatus`) VALUES ('Like');
INSERT INTO `dbmspbl`.`Likes` (`Lstatus`) VALUES ('Dislike');

/*TABLE : Friends_list*/

create table Friends_list(
Account_Type char(45),
Fid varchar(45) primary key);
insert into Friends_list
values('Public','amrutha'),('Private',"dad's_cutie"),('Public','jai'),('Private',"Self_beliver"),('Public','vandu');

/*TABLE : Notifications*/

create table Notifications(
Nid int,
Content text,
primary key(Nid));
insert into Notifications values(1,'You have a new friend request'),
(2,'Your post got 10 likes'),
(3,'You have new friend suggestion'),
(4,'Someone started following you'),
(5,'Someone commented on your post'),
(6,'Someone liked your post');

/*TABLE : Messages*/

create table Messages(
Mid int primary key,
Mtype char(45)
);
insert into Messages values(1,'video'),(2,'audio'),(3,'image'),(4,'text');

/* RELATIONSHIP TABLES */
/* TABLE : User_Notify (User & Notifications) */

create table User_Notify(
Userid varchar(45),
Nid int,
Time_stamp timestamp,
Status char(10),
foreign key(Userid) references User_profile(Userid),
foreign key(Nid) references Notifications(Nid));
insert into User_Notify values("jai",1,"2023-09-13 10:30:00","Unread");
insert into User_Notify values("dad's_cutie",2,"2023-09-12 11:15:55","Unread"),
("vandu",3,"2023-09-15 14:22:02","Unread"),
("amrutha",2,"2023-09-08 15:41:22","Unread"),
("dad's_cutie",5,"2023-09-13 10:30:00","Unread"),
("jai",3,"2023-09-10 10:59:00","read");

/*-----------------------------------TABLE : User_Manage_Friendlist (User & Friendlist) -----------------------------------*/

create table User_Manage_Friendlist(
Userid varchar(45),
Fid varchar(45) ,
Status char(45),
foreign key (Userid) references User_profile(Userid),
foreign key (Fid) references Friends_list(Fid));
insert into User_Manage_Friendlist values('jai','amrutha','Accepted'),
('jai',"dad's_cutie",'NotAccepted'),
('jai','vandu','Accepted'),
("dad's_cutie",'jai','Accepted'),
('amrutha','Self_beliver','Accepted'),
('vandu','amrutha','Accepted'),
('jai','Self_beliver','Not Accepted');
select * from User_Manage_Friendlist;

/* TABLE : User_messages(User & Message) */

create table User_messages(
Userid varchar(45),
foreign key(Userid) references User_profile(Userid),
Mid int,
foreign key(Mid) references Messages(Mid));
insert into User_messages
values('jai',1),('amrutha',2),('Self_beliver',1),('vandu',3),("dad's_cutie",4),('Self_beliver',2);
select*from User_messages;
/* TABLE : Post_contains_Likes(Post & Likes) */
create table Post_contains_Likes (
postid varchar(45),Lstatus char(10),Userid varchar(50),
foreign key (Postid) references Post(Postid),
foreign key(Lstatus) references Likes(Lstatus),
foreign key (Userid) references User_Profile(Userid));

insert into Post_contains_Likes values("p1","Like","amrutha"),
("p1","Dislike","Self_beliver"),
("p1","Like","vandu"),
("p1","Like","dad's_cutie"),
("p3","Like","jai"),
("p3","Dislike","amrutha"),
("p3","Dislike","Self_beliver"),
("p3","Dislike","vandu"),
("p5","Like","vandu"),
("p5","Like","jai"),
("p5","Like","amrutha");
select * from Post_contains_Likes;

/*-------------------------------TABLE : Post_contains_Comments(Post & Comments)------------------------------------*/

create table Post_contains_comments(
postid varchar(45),Ctype char(10),Userid varchar(50),Ctime timestamp,
foreign key (Postid) references Post(Postid),
foreign key(Ctype) references Comments(Ctype),
foreign key (Userid) references User_Profile(Userid));
select * from Post_contains_comments;
insert into Post_contains_Comments values
("p1","GIF","amrutha",'2023-09-13 23:55:22'),
("p1","Text","Self_beliver",'2023-09-12 15:12:02'),
("p2","Emoji","jai",'2023-09-12 03:05:22'),
("p1","Emoji","vandu",'2023-09-13 12:20:11'),
("p3","Text","jai",'2023-09-14 07:32:00'),
("p3","Emoji","vandu",'2023-09-13 11:12:22'),
("p3","GIF","Self_beliver",'2023-09-07 13:08:07'),
("p4","GIF","vandu",'2023-09-14 06:55:22'),
("p6","Text","vandu",'2023-09-13 18:10:25'),
("p5","Emoji","jai",'2023-09-12 23:55:22'),
("p5","Text","amrutha",'2023-09-14 16:04:30');
