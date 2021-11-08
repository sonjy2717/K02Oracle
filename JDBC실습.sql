-- JDBC�ǽ��� ����

/*
JAVA���� ó������ JDBC���α׷��� �غ���
*/
-- �켱 system�������� ������ �� ���ο� �ǽ��� ������ �����Ѵ�.
create user kosmo identified by 1234;
grant connect, resource to kosmo;

-- ���⼭���ʹ� kosmo�������� �ǽ��մϴ�.

-- ���̺� �����ϱ�1 : ȸ������ ���̺�
create table member (
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    regidate date default sysdate,
    primary key (id)
);

select * from user_constraints;

-- ���̵����� �Է��ϱ�
insert into member (id, pass, name) values ('test', '1234', '�׽�Ʈ');
-- ������ : �ֿܼ��� �Է� �� �ݵ�� commit�ؾ� �Ѵ�. �׷��� ������
-- JDBC���α׷������� ���ڵ尡 ������ �ʴ´�.

select * from member;
select to_char(regidate, 'yyyy-mm-dd hh24:mi:ss') "ȸ��������" from member;

-- ���̺� �����ϱ�2 : �Խ��� ���̺� ����
create table board (
    num number primary key, -- �Խù��� �Ϸù�ȣ
    title varchar2(200) not null, -- ����
    content varchar2(2000) not null, -- ����
    id varchar2(30) not null, -- �ۼ����� ���̵�
    postdate date default sysdate not null, -- �ۼ���
    visitcount number default 0 not null -- ��ȸ��
);

/*
����] ������ ������ ���̺� �ܷ�Ű�� �������� �����Ͻÿ�.
1. �ܷ�Ű�� : board_mem_fk
    board ���̺��� id �÷��� member ���̺��� id �÷��� �����ϵ���
    �ܷ�Ű�� ����
2. �������� : seq_board_num
    board ���̺� �����͸� �Է½� num�÷��� �ڵ����� �� �� �ֵ���
    �������� ����
*/
-- �������� ���� : ���������� �߸� ���� ��� ������ �ȵǹǷ� ���� �� ������ؾ���
alter table board drop constraint board_mem_fk;

-- 1. �ܷ�Ű����
alter table board add
    constraint board_mem_fk
        foreign key (id) references member (id);
        
select * from user_constraints;

-- 2. ����������
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
select * from user_sequences;

select seq_board_num.nextval from dual;

insert into member (id, pass, name) values ('test91', '9191', '�׽�Ʈ91');
commit;