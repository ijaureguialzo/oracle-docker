-- REF: http://www.dba-oracle.com/t_ora_65096_create_user_12c_without_c_prefix.htm
alter session set "_ORACLE_SCRIPT"=true;

drop user egibide cascade;

-- REF: http://oracle-apprentice.blogspot.com/2011/03/oracle-password-restriction-solution.html
create user egibide
identified by "12345abcde";

grant connect, resource to egibide;
grant unlimited tablespace to egibide;
grant create synonym, create public synonym to egibide;
grant create view to egibide;
