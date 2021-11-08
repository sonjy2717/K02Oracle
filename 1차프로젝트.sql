/***********************
1차 프로젝트 JDBC
***********************/

create table phonebook_tb (
    idx number primary key,
    name varchar2(10),
    phone_number varchar2(15),
    birthday date
);

create sequence seq_phonebook
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
