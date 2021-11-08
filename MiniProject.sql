create table sh_product_code (
    p_code number primary key,
    category_name varchar2(30)
);

create table sh_goods (
    g_idx number primary key,
    goods_name varchar2(30),
    goods_price number(10),
    regidate date default sysdate,
    p_code number(10),
    
    foreign key (p_code) references sh_product_code (p_code)
);

create sequence seq_total_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
insert into sh_product_code values(seq_total_idx.nextval, '����');
insert into sh_product_code values(seq_total_idx.nextval, '����');
insert into sh_product_code values(seq_total_idx.nextval, '�Ƿ�');

insert into sh_goods
    values (seq_total_idx.nextval, '�����', 2300000, '1996-09-20', 1);

insert into sh_goods
    values (seq_total_idx.nextval, 'TV', 2300000, sysdate - 34, 1);
    
insert into sh_goods
    values (seq_total_idx.nextval, '��Ź��', 1800000, sysdate, 1);
    
insert into sh_goods 
    values (seq_total_idx.nextval, 'Ż����', 15000, sysdate - 531, 2);
    
insert into sh_goods 
    values (seq_total_idx.nextval, '�����', 18000, sysdate - 486, 2);
    
insert into sh_goods 
    values (seq_total_idx.nextval, '�ѱռ�', 23000, sysdate - 27, 2);
    
insert into sh_goods 
    values (seq_total_idx.nextval, 'û����', 45000, sysdate - 22, 3);
    
insert into sh_goods 
    values (seq_total_idx.nextval, '��Ʈ', 32000, sysdate - 920, 3);

insert into sh_goods 
    values (seq_total_idx.nextval, '���е�', 190000, sysdate - 77, 3);
    
update sh_goods set g_idx = 4 where goods_name = '�����';

commit;