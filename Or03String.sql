/*******************
파일명 : Or03String.sql
문자열 처리함수
설명 : 문자열에 대해 대소문자를 변환하거나 문자열의 길이를 반환하는 등 문자열을
    조작하는 함수
*******************/

/*
concat(문자열1, 문자열2)
    : 문자열 1과 2를 서로 연결해서 출력하는 함수
    사용법1 : concat(문자열1, 문자열2)
    사용법2 : '문자열1' || '문자열2'
*/
select concat('Good ', 'morning') as "아침인사" from dual;
select 'Oracle' || ' 11g' || ' Good' from dual;
-- => 위의 SQL문을 concat()으로 변경하면 아래와 같다.
    select concat(concat('Oracle', ' 11g'), ' Good') from dual;
    
/*
시나리오] 사원 테이블에서 사원의 이름을 연결해서 아래와 같이 출력하시오
    출력내용 : first+last name, 급여, 부서번호
*/
-- 이름을 연결했지만 띄어쓰기가 안 돼서 읽기 불편함
select concat(first_name, last_name) as fullname, salary, department_id 
    from employees;
-- 띄어쓰기가 됐지만 두 개의 함수를 연결해야 하므로 사용이 불편함.
select concat(concat(first_name, ' '), last_name) as fullname, salary, department_id 
    from employees;
-- concat 연산자를 통해 좀 더 편리하게 사용할 수 있다.
select first_name || ' ' || last_name as fullname, salary, department_id 
    from employees;
    
/*
initcap(문자열)
    : 문자열의 첫 문자만 대문자로 변환하는 함수
    단, 첫 문자를 인식하는 기준은 다음과 같다.
    - 공백문자 다음에 나오는 첫 문자를 대문자로 변환한다.
    - 알파벳과 숫자를 제외한 나머지 문자 다음에 나오는 첫 번째 문자를
        대문자로 변환한다.
*/
select initcap('hi hello 안녕') from dual; -- 이 경우 h가 대문자로 변경됨
select initcap('good/bad morning') from dual; -- g, b, m이 대문자로 변경됨
select initcap('never6say*good가bye') from dual; -- n, g, b가 대문자로 변경됨

/*
시나리오] 사원 테이블에서 first_name이 john이 사원을 찾아 인출하시오.
*/
select * from employees where first_name = 'john'; -- 결과 없음
select * from employees where first_name = 'John'; -- 3개
select * from employees where first_name = initcap('john'); -- 3개

/*
대소문자 변경하기
lower() : 소문자로 변경함
upper() : 대문자로 변경함
*/
select lower('GOOD'), upper('bad') from dual;
-- 위에서와 같이 john을 검색하려면
select lower(first_name), upper(first_name), first_name, last_name 
    from employees where lower(first_name) = 'john';
select first_name, last_name from employees where upper(first_name) = 'JOHN';

/*
lpad(), rpad()
    : 문자열의 왼쪽, 오른쪽을 특정한 기호로 채울 때 사용한다.
    형식] lpad('문자열', '전체 자리수', '채울 문자열')
        -> 전체 자리수에서 문자열의 길이만큼을 제외한 나머지
        좌측부분을 주어진 문자열로 채워주는 함수
        rpad()는 오른쪽을 채워줌
*/
select
    'good',
    lpad('good', 7, '#'), rpad('good', 7, '#'),
    lpad('good', 7)
from dual; -- 인자를 2개만 주는 경우 빈자리는 공백으로 채워진다.

/*
trim() : 공백을 제거할 때 사용한다.
    형식] trim([leading | trailing | both] 제거할 문자 from 컬럼) 
        - leading : 왼쪽에서 제거함
        - trailing : 오른쪽에서 제거함
        - both : 양쪽에서 제거함. 설정 값이 없으면 both가 디폴트임
        [주의1] 양쪽끝의 문자만 제거되고 중간에 있는 문자는 제거되지 않음
        [주의2] '문자'만 제거할 수 있고 '문자열'은 제거할 수 없다.
*/
select
    ' 공백제거테스트 ' as trim1,
    trim(' 공백제거테스트 ')as trim2,
    trim('다' from '다람쥐가 나무를 탑니다') trim3, /* 옵션이 없는 경우 both가 디폴트 */
    trim(both '다' from '다람쥐가 나무를 탑니다') trim4,
    trim(leading '다' from '다람쥐가 나무를 탑니다') trim5,
    trim(trailing '다' from '다람쥐가 나무를 탑니다') trim6,
    trim('다' from '다람쥐가 다리위의 나무를 탑니다') trim7 /* 문자열 중간의 '다'는 제거되지 않음 */
from dual;
-- 아래 쿼리문은 에러가 발생한다. 문자열은 제거할 수 없다.
select
    trim('다람쥐' from '다람쥐가 나무를 타다가 떨어졌습니다') as trimError
from dual;

/*
ltrim(), rtrim()
    : 좌측, 우측 '문자' 혹은 '문자열'을 제거할 때 사용한다.
    ※ TRIM은 문자열을 제거할 수 없지만 LTRIM과 RTRIM은 문자열까지
    제거할 수 있다.
*/
select
    ltrim(' 좌측공백제거 ') ltrim1,
    ltrim(' 좌측문자열제거 ', '좌측') ltrim2, /* 이 경우 스페이스가 포함된 문자열이므로 삭제안됨 */
    ltrim('좌측문자열제거', '좌측') ltrim3, /* '좌측' 문자열이 삭제됨 */
    rtrim('우측문자열제거', '제거') rtrim4,
    rtrim('우측문자열제거', '문자열') rtrim5 /* 중간에 있는 문자열은 삭제안됨 */
from dual;

/*
substr() : 문자열에서 시작 인덱스부터 길이만큼 잘라서 문자열을 출력한다.
    형식] substr(컬럼, 시작 인덱스, 길이)
    
    참고1) 오라클의 인덱스는 1부터 시작한다. (0부터 아님)
    참고2) '길이'에 해당하는 인자가 없으면 문자열의 끝까지를 의미한다.
    참고3) 시작 인덱스가 음수면 우측끝부터 좌로 인덱스를 적용한다.
*/
select substr('good morning john', 8, 4) from dual; -- rnin
select substr('good morning john', 8) from dual; -- rning john
-- 인덱스 2부터 끝까지를 잘라내지만 한글이므로 영문과는 결과가 조금 다르다.
select substr('안녕하세요 존', 2) from dual; -- 녕하세요 존

/*
substrb() : 바이트(byte)단위로 잘라낸다.
    통상적으로 한글과 같은 유니코드는 한 글자에 3byte로 표현되나
    조금씩 어긋나는 경우가 생기므로 테스트가 필요하다.
*/
select substrb('안녕하세요 존', 1) from dual;
select substrb('안녕하세요 존', 2) from dual;
select substrb('안녕하세요 존', 3) from dual;
select substrb('안녕하세요 존', 4) from dual;
select substrb('안녕하세요 존', 5) from dual;
select substrb('안녕하세요 존', 6) from dual;
select substrb('안녕하세요 존', 7) from dual;

/*
replace() : 문자열을 다른 문자열로 대체할 때 사용한다.
    만약 공백으로 문자열을 대체한다면 문자열이 삭제되는 결과가 나온다.
    
    ※trim(), ltrim(), rtrim()함수의 기능을 replace()함수 하나로 대체할 수
    있으므로 trim()에 비해 replace()가 훨씬 더 사용빈도가 높다.
*/
select replace('good morning john', 'morning', 'evening') from dual; -- 문자열 변경
select replace('good morning john', 'john', '') from dual; -- 문자열 삭제
-- trim은 좌우측의 공백은 제거되지만 중간의 공백은 제거할 수 없다.
select trim(' 공백1 공백2 ') blank1 from dual;
-- replace는 좌우측 뿐만 아니라 중간의 공백도 제거할 수 있다.
select replace(' 공백1 공백2 ', ' ', '') as blank2 from dual;

/*
사원 테이블의 레코드를 대상으로 문자열 변경을 적용해보자
102	Lex	De Haan	LDEHAAN
*/
-- 102번 사원의 전체 정보를 인출한다.
select * from employees where employee_id = 102;
-- 위 함수를 통해 문자열 변경 몇 가지를 해본다
select first_name, last_name,
    ltrim(first_name, 'L') "좌측 L제거",
    rtrim(first_name, 'ex') "우측 ex제거",
    replace(last_name, ' ', '') "중간 공백제거",
    replace(first_name, 'Lex', 'Joy') "이름 변경"
from employees where employee_id = 102;

/*
instr() : 해당 문자열에서 특정 문자가 위치한 인덱스 값을 반환한다.
    형식1] instr(컬럼명, '찾을문자')
        => 문자열의 처음부터 문자를 찾는다.
    형식2] instr(컬럼명, '찾을문자', '탐색을 시작할 인덱스', '몇 번째 문자')
        => 탐색할 인덱스부터 문자를 찾는다. 단, 찾는 문자 중 몇 번째에
        있는 문자인지 지정할 수 있다.
*/
-- n이 발견된 첫 번째 인덱스 반환
select instr('good morning tom', 'n') from dual; -- 9
-- 인덱스 1부터 탐색해서 n이 두 번째로 발견된 인덱스 반환
select instr('good morning tom', 'n', 1, 2) from dual; -- 11
-- 인덱스 8부터 탐색해서 m이 첫 번째로 발견된 인덱스 반환
select instr('good morning tom', 'm', 8, 1) from dual; -- 16