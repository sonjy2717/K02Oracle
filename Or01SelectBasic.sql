/****************************
���ϸ� : Or01SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
���� : select, where �� ���� �⺻���� DQL�� ����غ���
****************************/

/*
SQL Developer���� �ּ� ����ϱ�
    ������ �ּ� : �ڹٿ� ����
    ���δ��� �ּ� : -- ���๮��. ������ 2���� �������� ���
*/

-- select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�.
/*
����]
    select �÷�1, �÷�2, ...[�Ǵ� *]
    from ���̺��
    where ����1 and ����2 or ����3 ...
    order by �������÷� asc(��������), desc(��������);
*/

-- ��� ���̺� ����� ��� ���ڵ带 ��ȸ�ϱ�
select * from employees;

/*
�÷����� �����ؼ� �����ڰ� ������� �÷��� ��ȸ�ϱ�
=> ��� ��ȣ, �̸�, �̸���, �μ� ���̵� ��ȸ�غ���
*/
select employee_id, first_name, last_name, email, department_id from employees;

-- ���̺��� �Ӽ��� �ڷ����� Ȯ���ϴ� ��ɾ�
desc employees;

-- �ش� �÷��� number(����)�� ��� ������� ����
select employee_id, first_name, salary, salary+100 from employees;
-- ���� Ÿ���� �÷������� ���굵 �����ϴ�
select employee_id, first_name, salary, commission_pct, salary+commission_pct
    from employees;

/*
AS(�˸��ƽ�) : ���̺� Ȥ�� �÷��� ��Ī(����)�� �ο��� �� ����Ѵ�
    ���� ���ϴ� �̸�(����, �ѱ�)���� ������ �� ����� �� �ִ�.
    Ȱ���] ���� 2�� �̻��� ���̺��� JOIN(����)�ؾ� �� ��� �÷�����
        �ߺ��� �� �����ϴ� �뵵�� ����Ѵ�.
*/
select first_name, salary, salary+100 as "�޿�100����" from employees;
select first_name, salary, salary+100 as salaryUp100 from employees;

-- as�� ������ �� �ִ�
select employee_id "������̵�", first_name, last_name "��"
    from employees where first_name = 'William';
    
-- ����Ŭ�� �⺻������ ��ҹ��ڸ� �������� �ʴ´�. ������ �� �� ����� �� �ִ�.
SELECT employee_id "�����ȣ", first_name, email
    FROM employees WHERE first_name = 'Alexander';
-- ��, ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�. �Ʒ� SQL�������� �ƹ��� ����� ��µ��� �ʴ´�.    
SELECT employee_id "�����ȣ", first_name, email
    FROM employees WHERE first_name = 'ALEXander';-- �̸��� ��ҹ��ڰ� �߸��Էµ�.

/*
where���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
    : last_name�� Smith�� ���ڵ带 �����Ѵ�.
    ����] where���� ������ �Է��� �� �÷��� �������̸�
        �̱� �����̼��� ����ؾ� �Ѵ�. �������� ��� ������ �� �ִ�.
*/
SELECT * FROM employees WHERE last_name = 'Smith'; --2�� ����
SELECT * FROM employees WHERE last_name = 'Smith' and salary = 8000; -- 1�� ����
SELECT * FROM employees WHERE last_name = 'Smith' or salary = 8000; -- 4�� ����

/*
�񱳿����ڸ� ���� ���� �ۼ�
    : �̻�, ���Ͽ� ���� ���ǿ� >, <= �� ���� �񱳿����ڸ� ����� �� �ִ�.
    ��¥�� ��� ������ ��¥�� ���� ���ǵ� �����ϴ�.
*/
-- �޿��� 5000�̸��� ����� ������ �����Ͻÿ�
SELECT * FROM employees WHERE salary < 5000;
-- �Ի����� 04��01��01�� ������ ��� ������ �����Ͻÿ�
SELECT * FROM employees WHERE hire_date >= '04/01/01';

/*
in������ : or �����ڿ� ����� ������� �ϳ��� �÷��� ����������
    ������ �ɰ���� �� ����ϴ� ������
    �޿��� 4200, 6400, 8000�� ������ ������ ��ȸ�Ͻÿ�
*/
-- ���1 : or�� ����Ѵ�. �÷����� �ݺ������� ����ؾ� �Ѵ�.
SELECT * FROM employees WHERE salary = 4200 or salary = 6400 or salary = 8000;
-- ���2 : in�� ����ϸ� �÷��� �� ���� ����ϸ� �ǹǷ� ���ϴ�.
SELECT * FROM employees WHERE salary IN (4200, 6400, 8000);

/*
not������ : �ش� ������ �ƴ� ���ڵ带 �����´�.
    �μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�Ͻÿ�
*/
SELECT * FROM employees WHERE department_id <> 50;
SELECT * FROM employees WHERE NOT (department_id = 50);

/*
between and ������ : �÷��� ������ ���� �˻��� �� ����Ѵ�.
    �޿��� 4000~8000 ������ ��������� ��ȸ�Ͻÿ�
*/
SELECT * FROM employees WHERE salary >= 4000 AND salary <= 8000;
SELECT * FROM employees WHERE salary BETWEEN 4000 and 8000;

/*
distinct : �÷����� �ߺ��Ǵ� ���ڵ带 ������ �� ����Ѵ�.
    Ư�� �������� select���� �� �ϳ��� �÷����� �ߺ��Ǵ� ����
    �ִ� ��� �ߺ� ���� ������ �� ����� ����� �� �ִ�.
*/
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;

/*
like ������ : Ư�� Ű���带 ���� ���ڿ� �˻��ϱ�
    ����] �÷��� like '%�˻���%'
    ���ϵ�ī�� ����
        % : ��� ���� Ȥ�� ���ڿ��� ��ü�Ѵ�.
        ex) D�� �����ϴ� �ܾ� : %D -> Da, Dae, Daewoo
            Z�� ������ �ܾ� : %Z -> aZ, abcZ
            C�� ���ԵǴ� �ܾ� : %C% -> aCb, abCde, Vitamin-C
        _ : ����ٴ� �ϳ��� ���ڸ� ��ü�Ѵ�.
        ex) D�� �����ϴ� 3������ �ܾ� : D__ -> Dab, Ddd, Dxy
            A�� �߰��� ���� 3������ �ܾ� : _A_ -> aAa, xAy
*/
-- first_name�� 'D'�� �����ϴ� ������ �˻��Ͻÿ�
SELECT * FROM employees WHERE first_name LIKE 'D%';
-- first_name�� �� ��° ���ڰ� 'a'�� ������ �����Ͻÿ�
SELECT * FROM employees WHERE first_name LIKE '__a%';
-- last_name���� 'y'�� ������ ������ �����Ͻÿ�
SELECT * FROM employees WHERE last_name LIKE '%y';
-- ��ȭ��ȣ�� 1344�� ���Ե� ���� ��ü�� �˻��Ͻÿ�
SELECT * FROM employees WHERE phone_number LIKE '%1344%';

/*
���ڵ� �����ϱ�(sorting)
    �������� ���� : order by �÷��� asc (Ȥ�� ��������)
    �������� ���� : order by �÷��� desc
    
    2�� �̻��� �÷����� �����ؾ� �� ��� �޸��� �����ؼ� �����Ѵ�.
    ��, �� �� ���� �Է��� �÷����� ���ĵ� ���¿��� �� ��° �÷��� ���ĵȴ�.
*/
/*
������� ���̺��� �޿��� ������������ ���������� �������� �����Ͽ� ��ȸ�Ͻÿ�
����� �÷� : first_name, salary, email, phone_number
*/
SELECT first_name, salary, email, phone_number FROM employees 
    ORDER BY salary ASC;
/*
�μ���ȣ�� ������������ ������ �� �ش� �μ����� ���� �޿��� �޴� ������
���� ��µǵ��� �ϴ� SQL���� �ۼ��Ͻÿ�
����׸� : �����ȣ, �̸�, ��, �޿�, �μ���ȣ
*/
SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    ORDER BY department_id desc, salary asc;

/*
is null Ȥ�� is not null
    : ���� null�̰ų� null�� �ƴ� ���ڵ� ��������
    �÷� �� null���� ����ϴ� ��� ���� �Է����� ������ null����
    �Ǵµ� �̸� ������� select�� �� ����Ѵ�.
*/
-- ���ʽ����� ���� ����� ��ȸ�Ͻÿ�
SELECT * FROM employees WHERE commission_pct IS NULL;
-- ���ʽ����� �ִ� ����� ��ȸ�Ͻÿ�
SELECT * FROM employees WHERE commission_pct IS NOT NULL;
-- ��������̸鼭 �޿��� 8000�̻��� ����� ��ȸ�Ͻÿ�
SELECT * FROM employees WHERE salary >= 8000 and commission_pct IS NOT NULL;

/************************************************************************/

/*
1. ���� �����ڸ� �̿��Ͽ� ��� ����� ���ؼ� $300�� �޿��λ��� ������� �̸�, 
�޿�, �λ�� �޿��� ����Ͻÿ�.

2. ����� �̸�, �޿�, ������ ������ �����ͺ��� ���������� ����Ͻÿ�. 
������ ���޿� 12�� ������ $100�� ���ؼ� ����Ͻÿ�.

3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�

4. �����ȣ�� 7782�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.

5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�.

6. �Ի����� 81��2��20�� ���� 81��5��1�� ������ ����� �̸�, ������, 
�Ի����� ����Ͻÿ�.

7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� 
�̸��� ����(��������)���� ����Ͻÿ�

8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� 
�̸�, �޿��� �μ���ȣ�� ����ϵ� �̸���(��������)���� ����Ͻÿ�

9. 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
(like �����ڿ� ���ϵ�ī�� ���)

10. �����ڰ� ���� ����� �̸��� �������� ����Ͻÿ�. 

11. Ŀ�̼��� ������ �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, 
Ŀ�̼��� ����ϵ� �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ����Ͻÿ�.

12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.

13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.

14. �������� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭 
�޿��� $1600, $950, $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 

15. Ŀ�̼��� $500 �̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�. 
*/

select ename, sal, (sal + 300) as "�λ�� �޿�" from emp;

-- ���Ľ� ���������� �����ϴ� �÷����� ����ϴ°� �⺻�̴�.
select ename, sal, ((sal * 12) + 100) as "����" from emp 
    order by "����" desc;
    
select ename, sal from emp where sal > 2000 order by ename desc, sal desc;

select ename, deptno from emp where empno = 7782;

select ename, sal from emp where not (sal between 2000 and 3000);

select ename, job, hiredate from emp where hiredate 
    between '81/02/20' and '81/05/01';
    
select ename, deptno from emp where deptno in(20, 30) order by ename desc;

select ename, sal, deptno from emp where (sal between 2000 and 3000) 
    and (deptno in(20, 30)) order by ename;
    
select ename, hiredate from emp where hiredate like '81%';

select ename, job from emp where mgr is null;

select ename, sal, comm from emp where comm is not null 
    order by sal desc, comm desc;

-- ���� ���� %�� ������ �� ������ ���ڵ常 �˻��Ѵ�.
select ename from emp where ename like '__R%';

select ename from emp where ename like '%A%' and ename like '%E%';
/* �Ʒ��� ���� ��� A�� E�� ���ԵǱ� �ϳ� ������ �����Ƿ� E�� �����ϰ�
A�� ������ �̸��� �˻����� �ʴ´�. */
-- select ename from emp where ename like '%A%E%';

select ename, job, sal from emp where (job in('CLERK', 'SALESMAN')) 
    and (sal not in(1600, 950, 1300));
    
select ename, sal, comm from emp where comm >= 500;