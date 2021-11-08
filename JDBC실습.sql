-- JDBC실습용 문서

/*
JAVA에서 처음으로 JDBC프로그래밍 해보기
*/
-- 우선 system계정으로 연결한 후 새로운 실습용 계정을 생성한다.
create user kosmo identified by 1234;
grant connect, resource to kosmo;

-- 여기서부터는 kosmo계정에서 실습합니다.

-- 테이블 생성하기1 : 회원관리 테이블
create table member (
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    regidate date default sysdate,
    primary key (id)
);

select * from user_constraints;

-- 더미데이터 입력하기
insert into member (id, pass, name) values ('test', '1234', '테스트');
-- ※주의 : 콘솔에서 입력 후 반드시 commit해야 한다. 그렇지 않으면
-- JDBC프로그램에서는 레코드가 보이지 않는다.

select * from member;
select to_char(regidate, 'yyyy-mm-dd hh24:mi:ss') "회원가입일" from member;

-- 테이블 생성하기2 : 게시판 테이블 생성
create table board (
    num number primary key, -- 게시물의 일련번호
    title varchar2(200) not null, -- 제목
    content varchar2(2000) not null, -- 내용
    id varchar2(30) not null, -- 작성자의 아이디
    postdate date default sysdate not null, -- 작성일
    visitcount number default 0 not null -- 조회수
);

/*
퀴즈] 위에서 생성한 테이블에 외래키와 시퀀스를 설정하시오.
1. 외래키명 : board_mem_fk
    board 테이블의 id 컬럼이 member 테이블의 id 컬럼을 참조하도록
    외래키를 생성
2. 시퀀스명 : seq_board_num
    board 테이블에 데이터를 입력시 num컬럼이 자동증가 할 수 있도록
    시퀀스를 생성
*/
-- 제약조건 삭제 : 제약조건을 잘못 만든 경우 수정이 안되므로 삭제 후 재생성해야함
alter table board drop constraint board_mem_fk;

-- 1. 외래키생성
alter table board add
    constraint board_mem_fk
        foreign key (id) references member (id);
        
select * from user_constraints;

-- 2. 시퀀스생성
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
select * from user_sequences;

select seq_board_num.nextval from dual;

insert into member (id, pass, name) values ('test91', '9191', '테스트91');
commit;