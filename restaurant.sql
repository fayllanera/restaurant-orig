create function login(par_email text, par_password text) returns text
LANGUAGE plpgsql
AS $$
declare
    loc_email text;
    loc_password text;
    loc_res text;
  begin
     select into loc_email acc.email from acc
       where acc.email = par_email and acc.password = par_password;

     if loc_email isnull then
       loc_res = 'Error';
     else
       loc_res = 'ok';
     end if;
     return loc_res;
  end;
$$;

--get password
create or replace function getpassword(par_email text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password from acc where email = par_email;
     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

--select getpassword('python');


create or replace function res_search(in par_resname text, in random text, out TEXT, out TEXT, out BIGINT, out BOOLEAN) returns setof record as
 $$

   select resname, address, contact, true from res_search where resname ilike par_resname;

 $$
  language 'sql';

select res_search('Delecta', 'Big Dipper');


create or replace function rate(in par_value TEXT, in par_diner text) returns text as
$$
  declare
    loc_res text;
  begin
     if par_value NOTNULL then
       INSERT INTO res_rate (answer, diner_name) VALUES (par_value,  par_diner);
       loc_res = 'ok';
     else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function view_ratings(out TEXT, out TEXT) returns setof record as
$$

  select diner_name, answer from res_rate;
$$
 language 'sql';



create or REPLACE FUNCTION reservations(IN restaurants text, IN cusname TEXT, IN attendees1 int, IN resdate date, IN restime text) RETURNS Text AS
 $$
 DECLARE
   loc_res text;
 BEGIN
     INSERT INTO reservation
         (diner, cus_name, attendees, res_date, res_time)
     VALUES (restaurants, cusname, attendees1, resdate, restime);
   loc_res = 'stored';
   return loc_res;
 END;
 $$

 LANGUAGE 'plpgsql' VOLATILE;


create or replace function myreservation(out TEXT, out TEXT, out INT, out DATE, out TEXT) returns setof record as
$$

  select diner, cus_name, attendees, res_date, res_time from reservation;
$$
 language 'sql';



--  create or replace function res_average(in par_value decimal) returns text as
-- $$
--   declare
--     loc_res text;
-- 
--   begin
--     if par_value NOTNULL THEN
-- 
--       SELECT diner_name, AVG(answer) from res_rate;
--     loc_res = 'ok';
--      else
--        loc_res = 'Error';
--      end if;
--      return loc_res;
--       end;
-- $$
--  language 'plpgsql';
-- 
-- select res_average('1');



----- SCRATCH -----

--UPDATE res_rate set answer = par_value;
       --UPDATE res_rate set (points, quality) = (par_value, '');
       --UPDATE res_rate set (points, quality) = (3,'EXCELLENT') where answer = 'A' or answer = 'a';
       --UPDATE res_rate set (points, quality) = (2,'VERY GOOD') where answer = 'B' or answer = 'b';
       --UPDATE res_rate set (points, quality) = (1,'GOOD') where answer = 'C' or answer = 'c';


--  create or replace function res_rate(in par_avg DECIMAL(2,2)) returns text as
--    $$
--   declare
--     loc_res text;
--
--   begin
--     if par_avg NOTNULL THEN
--
--       update res_rate set avg =  (select AVG(answer) from res_rate);
--     loc_res = 'ok';
--      else
--        loc_res = 'Error';
--      end if;
--      return loc_res;
--       end;
-- $$
--  language 'plpgsql';
--
-- select res_rate('1');



-- create or replace function rate(in par_value DECIMAL, in par_diner text) returns text as
-- $$
--   declare
--     loc_res text;
--   begin
--      if par_value NOTNULL then
--        INSERT INTO res_rate (answer, diner_name) VALUES (par_value,  par_diner);
--        loc_res = 'ok';
--      else
--        loc_res = 'Error';
--      end if;
--      return loc_res;
--   end;
-- $$
--  language 'plpgsql';
--
-- create or replace function view_ratings(out TEXT, out DECIMAL) returns setof record as
-- $$
--
--   select diner_name, answer from res_rate;
-- $$
--  language 'sql';

-- create or replace function login(in par_user_name  text, in par_user_password text) returns text as
-- $$
--   declare
--     loc_user_name text;
--     loc_user_password text;
--     loc_res text;
--   begin
--      select into loc_user_name username, loc_user_password pwd
--      from "acc" where username = par_user_name and pwd = par_user_password;
--
--      if loc_user_name isnull AND loc_user_password isnull then
--        loc_res = 'Error';
--      else
--        loc_res = 'ok';
--      end if;
--      return loc_res;
--   end;
-- $$
--  language 'plpgsql' VOLATILE ;
--
-- select login('fay', 'asd');

-- CREATE OR REPLACE FUNCTION login(IN par_username TEXT, IN par_password TEXT)
--  RETURNS TEXT AS
-- $$
-- DECLARE
--  loc_username TEXT;
--  loc_password TEXT;
--  loc_res      TEXT;
-- BEGIN
--  SELECT INTO loc_username
--    "username",
--    loc_password "pwd"
--  FROM acc
--  WHERE username = par_username AND pwd = par_password;
--  IF loc_username ISNULL AND loc_password ISNULL
--  THEN
--    loc_res = 'Error Username or password';
--  ELSE
--    loc_res = 'ok';
--  END IF;
--  RETURN loc_res;
-- END;
--
-- $$
-- LANGUAGE 'plpgsql' VOLATILE;
--
-- select login('fay', 'asd');










