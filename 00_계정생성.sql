-- 직원 관리 계정 생성
-- 계정 생성(CREATE USER)
CREATE USER C##EMPLOYEE IDENTIFIED BY EMPLOYEE;
-- 권한 부여(GRANT)
GRANT CONNECT, RESOURCE TO C##EMPLOYEE;
-- 테이블 스페이스 부여
ALTER USER C##EMPLOYEE QUOTA 100M ON USERS;

-- 계정 생성 시 문제 있었을 경우 
-- 계정 삭제 후 다시 명령어 처음부터 실행
DROP USER C##EMPLOYEE CASCADE;

-------------------------------------------------------------------------------
-- 과제 계정 생성
-- 계정 생성(CREATE USER)
CREATE USER C##HOMEWORK IDENTIFIED BY HOMEWORK;
-- 권한 부여(GRANT)
GRANT CONNECT, RESOURCE TO C##HOMEWORK;
-- 테이블 스페이스 부여
ALTER USER C##HOMEWORK QUOTA 100M ON USERS;
-------------------------------------------------------------------------------
-- GREDDY 계정 생성
-- 계정 생성(CREATE USER)
CREATE USER C##GREEDY1 IDENTIFIED BY GREEDY1;
-- 권한 부여(GRANT)
GRANT CONNECT, RESOURCE TO C##GREEDY1;
-- 테이블 스페이스 부여
ALTER USER C##GREEDY1 QUOTA 100M ON USERS;

