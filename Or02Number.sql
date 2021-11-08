/**********************
���ϸ� : Or02Number.sql
����(����) ���� �Լ�
���� : ���ڵ����͸� ó���ϱ� ���� ���ڰ��� �Լ��� �˾ƺ���
    ���̺� ������ number Ÿ������ ����� �÷��� ����� �����͸�
    ������� �Ѵ�.
**********************/

/*
DUAL ���̺�
    : �� ������ ����� ����ϱ� ���� �����Ǵ� ���̺�� ����Ŭ����
    �ڵ����� �����Ǵ� �ӽ� ���̺��̴�.
    varchar2(1)�� ���ǵ� dummy��� �� �ϳ��� �÷����� �����Ǿ��ִ�.
*/
SELECT * FROM dual;
SELECT 1+2 FROM dual;

/*
abs() : ���밪 ���ϱ�
*/
SELECT ABS(12000) FROM dual;
select abs(-9000) from dual;
select abs(salary) "�޿��� ���밪" from employees;

/*
trunc() : �Ҽ����� Ư�� �ڸ������� �߶� �� ����ϴ� �Լ�
    ���� : trunc(�÷��� Ȥ�� ��, �Ҽ��� ���� �ڸ���)
        �� ��° ���ڰ�
            ����� �� : �־��� ���ڸ�ŭ ǥ��
            ���� �� : �����θ� ǥ��. �� �Ҽ��� �Ʒ��κ��� ����
            ������ �� : �����θ� ���ڸ�ŭ �߶� �������� 0���� ä��
*/
select trunc(1234.123456, 2) from dual;
select trunc(1234.123456) from dual;
select trunc(1234.123456, -2) from dual;
/*
�ó�����] ��� ���̺��� ��������� 1000�ҿ� ���� Ŀ�̼��� ����Ͽ�
    �޿��� ���� ����� ����ϴ� �������� �ۼ��Ͻÿ�
*/
-- 1.������� ã��(��������� job_id�� ��� SA_XXX�� ���� �����Ѵ�.)
select salary, commission_pct, job_id from employees where job_id like 'SA%';
-- 2.Ŀ�̼� ����Ͽ� ���
select salary, commission_pct, job_id, (salary + (1000 * commission_pct))
    from employees where job_id like 'SA%';
-- 3.��Ī���� ó��
select salary, commission_pct, job_id,
    (salary + (1000 * commission_pct)) as TotalSalary
    from employees where job_id like 'SA%';
-- 4.Ŀ�̼��� �Ҽ��� 1�ڸ����� ������ �ݾ� ����ϱ�
select salary, commission_pct, trunc(commission_pct, 1), job_id,
    (salary + (1000 * trunc(commission_pct, 1))) as TotalSalary
    from employees where job_id like 'SA%';
    
/*
�ó�����] ��� ���̺��� ���ʽ����� �ִ� ����� ������ �� ���ʽ�����
    �Ҽ��� 1�ڸ��� ǥ���Ͻÿ�
*/
-- 1.Ŀ�̼��� �ִ� ����� �����ϱ�
select first_name, salary, commission_pct from employees
    where commission_pct is not null;
-- 2.�Ҽ��� ó���ϱ�
select first_name, salary, trunc(commission_pct, 1) as Round
    from employees where commission_pct is not null;

/*
�Ҽ��� �����Լ�

ceil() : �Ҽ��� ���ϸ� ������ �ø�ó��
floor() : �Ҽ��� ���ϸ� ������ ����ó��
round(��, �ڸ���) : �ݿø� ó��
    �� ��° ���ڰ�
        ���� ��� : �Ҽ��� ù ��° �ڸ��� 5�̻��̸� �ø�, �̸��̸� ����
        �ִ� ��� : ���ڸ�ŭ �Ҽ����� ǥ���ǹǷ� �� �������� 5�̻��̸� �ø�,
            �̸��̸� ����
*/
select ceil(32.8) from dual; -- 33
select ceil(32.2) from dual; -- 33

select floor(32.8) from dual; -- 32
select floor(32.2) from dual; -- 32

select round(0.123), round(0.543) from dual; -- 0, 1
-- ù ��° �׸� : �Ҽ����� 6�ڸ����� ǥ���ϹǷ� 7�� �ø�ó���Ͽ� 0.123457
-- �� ��° �׸� : �Ҽ����� 4�ڸ����� ǥ���ϹǷ� 1�� ����ó���Ͽ� 2.3456
select round(0.1234567, 6), round(2.345612, 4) from dual;
/*
�ó�����] ��� ���̺��� ��������� Ŀ�̼��� �ݿø��Ͽ� ����Ͻÿ�
    �� �Ҽ��� 1�ڸ����� ǥ���Ͻÿ�
*/
select commission_pct, round(commission_pct, 1) as Round from employees
    where commission_pct is not null;
    
/*
mod() : �������� ���ϴ� �Լ�
power() : �ŵ������� ����ϴ� �Լ�
sqrt() : ������(��Ʈ)�� ���ϴ� �Լ�
*/
select mod(99, 4) "99�� 4�� ���� ������" from dual; -- 3
select power(2, 10) "2�� 10��" from dual; -- 1024
select sqrt(49) "49�� ������" from dual; -- 7