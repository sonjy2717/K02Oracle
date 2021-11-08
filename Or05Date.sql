/*******************************
파일명 : Or05Date.sql
날짜함수
설명 : 년, 월, 일, 시, 분, 초의 포맷으로 날짜형식을 지정하거나
    날짜를 계산할 때 활용하는 함수들
*******************************/

/*
months_between() : 현재날짜와 기준날짜 사이의 개월수를 반환한다.
    형식] months_between(현재날짜, 기준날짜[과거날짜])
*/
-- 2020년 1월 1일부터 지금까지 지난 개월수는?
select
    months_between(sysdate, '2020-01-01') "결과1",
    months_between(sysdate, to_date('2020년01월01일', 'yyyy"년"mm"월"dd"일"')) "결과2",
    round(months_between(sysdate, to_date('2020년01월01일', 'yyyy"년"mm"월"dd"일"'))) "결과3"
from dual;

/*
시나리오] employees 테이블에 입력된 직원들의 근속개월수를 계산하여
    출력하시오. 결과를 근속개월수로 오름차순 정렬하시오.
*/
select first_name, hire_date,
    trunc(months_between(sysdate, hire_date)) "근속개월수"
from employees order by "근속개월수" asc;

/*
add_months() : 날짜에 개월수를 더한 결과를 반환한다.
    형식] add_months(현재날짜, 더할개월수)
*/
-- 현재를 기준으로 7개월 이후의 날짜를 구하시오.
select sysdate, add_months(sysdate, 7) "7개월 후" from dual;

/*
next_day() : 현재날짜를 기준으로 인자로 주어진 요일에 해당하는
    미래의 날짜를 반환하는 함수
    형식] next_day(현재날짜, '월요일')
        -> 다음주 월요일은 몇일인가요?
*/
select
    to_char(sysdate, 'yyyy-mm-dd') "오늘날짜",
    to_char(next_day(sysdate, '월요일'), 'yyyy-mm-dd') "다음 월요일",
    to_char(next_day(sysdate, '수요일'), 'yyyy-mm-dd') "다음 수요일",
    to_char(next_day(sysdate, '금요일'), 'yyyy-mm-dd') "다음 금요일"
from dual; -- 일주일 이후의 날짜는 조회할 수 없다.

/*
last_day() : 해당월의 마지막 날짜를 반환한다.
*/
select last_day('21/02/01') from dual;
select last_day('20/02/01') from dual;

-- 컬럼이 date형인 경우 간단한 날짜연산이 가능하다.
select sysdate "현재날짜",
    sysdate + 1 "내일날짜",
    sysdate - 1 "어제날짜",
    sysdate + 30 "한달 후 날짜"
from dual;