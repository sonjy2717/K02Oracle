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
    
insert into sh_product_code values(seq_total_idx.nextval, '°¡Àü');
insert into sh_product_code values(seq_total_idx.nextval, 'µµ¼­');
insert into sh_product_code values(seq_total_idx.nextval, 'ÀÇ·ù');

insert into sh_goods
    values (seq_total_idx.nextval, '³ÃÀå°í', 2300000, '1996-09-20', 1);

insert into sh_goods
    values (seq_total_idx.nextval, 'TV', 2300000, sysdate - 34, 1);
    
insert into sh_goods
    values (seq_total_idx.nextval, '¼¼Å¹±â', 1800000, sysdate, 1);
    
insert into sh_goods 
    values (seq_total_idx.nextval, 'Å»¹«µå', 15000, sysdate - 531, 2);
    
insert into sh_goods 
    values (seq_total_idx.nextval, '¾î¸°¿ÕÀÚ', 18000, sysdate - 486, 2);
    
insert into sh_goods 
    values (seq_total_idx.nextval, 'ÃÑ±Õ¼è', 23000, sysdate - 27, 2);
    
insert into sh_goods 
    values (seq_total_idx.nextval, 'Ã»¹ÙÁö', 45000, sysdate - 22, 3);
    
insert into sh_goods 
    values (seq_total_idx.nextval, '´ÏÆ®', 32000, sysdate - 920, 3);

insert into sh_goods 
    values (seq_total_idx.nextval, '·ÕÆÐµù', 190000, sysdate - 77, 3);
    
update sh_goods set g_idx = 4 where goods_name = '³ÃÀå°í';

commit;