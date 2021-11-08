/****************************
파일명 : Or01SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 혹은 Query문)
설명 : select, where 등 가장 기본적인 DQL문 사용해보기
****************************/

/*
SQL Developer에서 주석 사용하기
    블럭단위 주석 : 자바와 동일
    라인단위 주석 : -- 실행문장. 하이픈 2개를 연속으로 사용
*/

-- select문 : 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당한다.
/*
형식]
    select 컬럼1, 컬럼2, ...[또는 *]
    from 테이블명
    where 조건1 and 조건2 or 조건3 ...
    order by 정렬할컬럼 asc(오름차순), desc(내림차순);
*/

-- 사원 테이블에 저장된 모든 레코드를 조회하기
select * from employees;

/*
컬럼명을 지정해서 개발자가 보고싶은 컬럼만 조회하기
=> 사원 번호, 이름, 이메일, 부서 아이디만 조회해보자
*/
select employee_id, first_name, last_name, email, department_id from employees;

-- 테이블의 속성과 자료형을 확인하는 명령어
desc employees;

-- 해당 컬럼이 number(숫자)인 경우 산술연산 가능
select employee_id, first_name, salary, salary+100 from employees;
-- 숫자 타입의 컬럼끼리의 연산도 가능하다
select employee_id, first_name, salary, commission_pct, salary+commission_pct
    from employees;

/*
AS(알리아스) : 테이블 혹은 컬럼에 별칭(별명)을 부여할 때 사용한다
    내가 원하는 이름(영문, 한글)으로 변경한 후 출력할 수 있다.
    활용법] 차후 2개 이상의 테이블을 JOIN(조인)해야 할 경우 컬럼명이
        중복될 때 구분하는 용도로 사용한다.
*/
select first_name, salary, salary+100 as "급여100증가" from employees;
select first_name, salary, salary+100 as salaryUp100 from employees;

-- as는 생략할 수 있다
select employee_id "사원아이디", first_name, last_name "성"
    from employees where first_name = 'William';
    
-- 오라클은 기본적으로 대소문자를 구분하지 않는다. 예약어는 둘 다 사용할 수 있다.
SELECT employee_id "사원번호", first_name, email
    FROM employees WHERE first_name = 'Alexander';
-- 단, 레코드인 경우 대소문자를 구분한다. 아래 SQL문에서는 아무런 결과가 출력되지 않는다.    
SELECT employee_id "사원번호", first_name, email
    FROM employees WHERE first_name = 'ALEXander';-- 이름에 대소문자가 잘못입력됨.

/*
where절을 이용해서 조건에 맞는 레코드 추출하기
    : last_name이 Smith인 레코드를 추출한다.
    주의] where절에 조건을 입력할 때 컬럼이 문자형이면
        싱글 쿼테이션을 사용해야 한다. 숫자형인 경우 생략할 수 있다.
*/
SELECT * FROM employees WHERE last_name = 'Smith'; --2개 인출
SELECT * FROM employees WHERE last_name = 'Smith' and salary = 8000; -- 1개 인출
SELECT * FROM employees WHERE last_name = 'Smith' or salary = 8000; -- 4개 인출

/*
비교연산자를 통한 쿼리 작성
    : 이상, 이하와 같은 조건에 >, <= 와 같은 비교연산자를 사용할 수 있다.
    날짜인 경우 이후의 날짜와 같은 조건도 가능하다.
*/
-- 급여가 5000미만인 사원의 정보를 추출하시오
SELECT * FROM employees WHERE salary < 5000;
-- 입사일이 04년01월01일 이후인 사원 정보를 추출하시오
SELECT * FROM employees WHERE hire_date >= '04/01/01';

/*
in연산자 : or 연산자와 비슷한 기능으로 하나의 컬럼에 여러값으로
    조건을 걸고싶을 때 사용하는 연산자
    급여가 4200, 6400, 8000인 직원의 정보를 조회하시오
*/
-- 방법1 : or를 사용한다. 컬러명을 반복적으로 기술해야 한다.
SELECT * FROM employees WHERE salary = 4200 or salary = 6400 or salary = 8000;
-- 방법2 : in을 사용하면 컬럼을 한 번만 기술하면 되므로 편리하다.
SELECT * FROM employees WHERE salary IN (4200, 6400, 8000);

/*
not연산자 : 해당 조건이 아닌 레코드를 가져온다.
    부서번호가 50이 아닌 사원정보를 조회하시오
*/
SELECT * FROM employees WHERE department_id <> 50;
SELECT * FROM employees WHERE NOT (department_id = 50);

/*
between and 연산자 : 컬럼의 구간을 정해 검색할 때 사용한다.
    급여가 4000~8000 사이의 사원정보를 조회하시오
*/
SELECT * FROM employees WHERE salary >= 4000 AND salary <= 8000;
SELECT * FROM employees WHERE salary BETWEEN 4000 and 8000;

/*
distinct : 컬럼에서 중복되는 레코드를 제거할 때 사용한다.
    특정 조건으로 select했을 때 하나의 컬럼에서 중복되는 값이
    있는 경우 중복 값을 제거한 후 결과를 출력할 수 있다.
*/
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;

/*
like 연산자 : 특정 키워드를 통한 문자열 검색하기
    형식] 컬럼명 like '%검색어%'
    와일드카드 사용법
        % : 모든 문자 혹은 문자열을 대체한다.
        ex) D로 시작하는 단어 : %D -> Da, Dae, Daewoo
            Z로 끝나는 단어 : %Z -> aZ, abcZ
            C가 포함되는 단어 : %C% -> aCb, abCde, Vitamin-C
        _ : 언더바는 하나의 문자를 대체한다.
        ex) D로 시작하는 3글자의 단어 : D__ -> Dab, Ddd, Dxy
            A가 중간에 들어가는 3글자의 단어 : _A_ -> aAa, xAy
*/
-- first_name이 'D'로 시작하는 직원을 검색하시오
SELECT * FROM employees WHERE first_name LIKE 'D%';
-- first_name의 세 번째 문자가 'a'인 직원을 추출하시오
SELECT * FROM employees WHERE first_name LIKE '__a%';
-- last_name에서 'y'로 끝나는 직원을 추출하시오
SELECT * FROM employees WHERE last_name LIKE '%y';
-- 전화번호에 1344가 포함된 직원 전체를 검색하시오
SELECT * FROM employees WHERE phone_number LIKE '%1344%';

/*
레코드 정렬하기(sorting)
    오름차순 정렬 : order by 컬럼명 asc (혹은 생략가능)
    내림차순 정렬 : order by 컬럼명 desc
    
    2개 이상의 컬럼으로 정렬해야 할 경우 콤마로 구분해서 정렬한다.
    단, 이 때 먼저 입력한 컬럼으로 정렬된 상태에서 두 번째 컬럼이 정렬된다.
*/
/*
사원정보 테이블에서 급여가 낮은순서에서 높은순서로 나오도록 정렬하여 조회하시오
출력할 컬럼 : first_name, salary, email, phone_number
*/
SELECT first_name, salary, email, phone_number FROM employees 
    ORDER BY salary ASC;
/*
부서번호를 내림차순으로 정렬한 후 해당 부서에서 낮은 급여를 받는 직원이
먼저 출력되도록 하는 SQL문을 작성하시오
출력항목 : 사원번호, 이름, 성, 급여, 부서번호
*/
SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    ORDER BY department_id desc, salary asc;

/*
is null 혹은 is not null
    : 값이 null이거나 null이 아닌 레코드 가져오기
    컬럼 중 null값을 허용하는 경우 값을 입력하지 않으면 null값이
    되는데 이를 대상으로 select할 때 사용한다.
*/
-- 보너스율이 없는 사원을 조회하시오
SELECT * FROM employees WHERE commission_pct IS NULL;
-- 보너스율이 있는 사원을 조회하시오
SELECT * FROM employees WHERE commission_pct IS NOT NULL;
-- 영업사원이면서 급여가 8000이상인 사원을 조회하시오
SELECT * FROM employees WHERE salary >= 8000 and commission_pct IS NOT NULL;

/************************************************************************/

/*
1. 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여인상을 계산한후 이름, 
급여, 인상된 급여를 출력하시오.

2. 사원의 이름, 급여, 연봉을 수입이 많은것부터 작은순으로 출력하시오. 
연봉은 월급에 12를 곱한후 $100을 더해서 계산하시오.

3. 급여가 2000을 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오

4. 사원번호가 7782인 사원의 이름과 부서번호를 출력하시오.

5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.

6. 입사일이 81년2월20일 부터 81년5월1일 사이인 사원의 이름, 담당업무, 
입사일을 출력하시오.

7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되 
이름을 기준(내림차순)으로 출력하시오

8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 
이름, 급여와 부서번호를 출력하되 이름순(오름차순)으로 출력하시오

9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. 
(like 연산자와 와일드카드 사용)

10. 관리자가 없는 사원의 이름과 담당업무를 출력하시오. 

11. 커미션을 받을수 있는 자격이 되는 사원의 이름, 급여, 
커미션을 출력하되 급여 및 커미션을 기준으로 내림차순으로 정렬하여 출력하시오.

12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.

13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.

14. 담당업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서 
급여가 $1600, $950, $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 

15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오. 
*/

select ename, sal, (sal + 300) as "인상된 급여" from emp;

-- 정렬시 물리적으로 존재하는 컬럼명을 사용하는게 기본이다.
select ename, sal, ((sal * 12) + 100) as "연봉" from emp 
    order by "연봉" desc;
    
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

-- 만약 끝에 %가 없으면 세 글자인 레코드만 검색한다.
select ename from emp where ename like '__R%';

select ename from emp where ename like '%A%' and ename like '%E%';
/* 아래와 같은 경우 A와 E가 포함되긴 하나 순서가 있으므로 E로 시작하고
A가 나오는 이름은 검색되지 않는다. */
-- select ename from emp where ename like '%A%E%';

select ename, job, sal from emp where (job in('CLERK', 'SALESMAN')) 
    and (sal not in(1600, 950, 1300));
    
select ename, sal, comm from emp where comm >= 500;