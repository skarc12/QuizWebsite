delimiter @

drop procedure if exists addUser@
create procedure addUser(firstname varchar(100),lastname varchar(100),loginname varchar(100), mail varchar(100),userPassword varchar(100))
begin

	insert into users(first_name,last_name, username, email, password)
	values(firstname, lastname,loginname,mail,userPassword);
	
end@

drop procedure if exists getUser@
create procedure getUser(userID int)
begin
	select * from users where ID = userID;
end@

create procedure getPopularQuizes()
begin
	select b.* from take_quize as a,quizes as b
	where a.quizID = b.ID
	group by a.quizID
	order by count(a.quizID) desc
	limit 2;
end@

create procedure getQuestionIDs(ID int)
begin
	select * from questions
	where quizID = ID;
end@

drop procedure if exists getQuestion@
create procedure getQuestion(questID int, categoryID int)
begin
	if categoryID=1 then 
		select * from fill_the_gaps
		where questionID = questID;
	elseif categoryID=2 then 
		select * from multiple_choice
		where questionID = questID;
	elseif categoryID=3 then 
		select * from picture_quiz
		where questionID = questID;
	elseif categoryID=4 then 
		select * from question_answer
		where questionID = questID;
	end if;
end@

drop procedure if exists getUnreadMessages@
create procedure getUnreadMessages(userID int)
begin
	select fromID, toID, msg, seen from messages
	where toID = userID
	and seen = 0;

end@

drop procedure if exists getUserIDByUsername@
create procedure getUserByUsername(uname varchar(100))
begin
	select ID from users where  username = uname;
end@

select * from messages@
call getUnreadMessages(10)@

drop procedure if exists recentCreatedQuizes@
create procedure recentCreatedQuizes(userID int)
begin
	select * from quizes as a
	where a.creatorID = userID
	order by a.quiz_date desc
	limit 2;
end@