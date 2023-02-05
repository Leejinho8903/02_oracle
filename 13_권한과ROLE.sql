-- 권한과 ROLED

-- 사용자 관리 : 사용자의 계정과 암호 설정, 권한 부여
-- 보안을 위한 데이터 베이스 관리자 : 사용자가 데이터 베이스의 객체(테이블, 뷰 등)에
-- 대해 특정 권한을 가질 수 있기 하는 권한이 있다. 다수의 사용자가 공유하는 데이터베이스
-- 정보에 대해 보안 설정을 한다.

-- 1. 시스템 권한 : 데이터베이스 관리자가 가지고 있는 권한으로 오라클 접속, 테이블, 뷰, 인덱스 등의 생성 권한.
-- CREATE USER(사용자 계정 만들기), DROP USER(사용자 계정 삭제) 등등
-- CREATE SESSION(데이터베이스에 접속), CREATE TABLE(테이블 생성), CREATE VIEW(뷰 생성) 등등

-- <시스템 계정으로 실행>
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- 생성한 SAMPLE 계정으로 접속 시도 시 접속 권한(CREATE SESSION)이 없어서 접속 불가
-- <시스템 계정으로 실행>
GRANT CREATE SESSION TO C##SAMPLE;

--<샘플 계정으로 실행>
CREATE TABLE TEST_TABLE(
 COL1 VARCHAR2(20),
 COL2 NUMBER
);

-- 테이블 생성 권한이 없어 생성 불가하므로 권한을 부여한다
-- <시스템 계정으로 실행>
GRANT CREATE TABLE TO C##SAMPLE;

-- WITH ADMIN OPTION
-- : 사용자에게 시스템 권한을 부여할 때 사용한다.
--   권한을 부여받은 사용자는 다른 사용자에게 권한을 지정할 수 있다.

-- <시스템 계정으로 실행> 시스템계정이 C##SAMPLE계정에게 접속권한을 부여한 것
GRANT CREATE SESSION TO C##SAMPLE
WITH ADMIN OPTION;

-- C##SAMPLE2 계정 생성 (시스템 계정으로)
CREATE USER C##SAMPLE2 IDENTIFIED BY SAMPLE2;

-- <샘플 계정으로 실행>
-- WITH ADMIN OPTION으로 부여 받은 CREATE SESSION은 다른 사용자에게 부여 가능하나
-- 그 외의 권한은 부여할 수 있는 권한이 없다.
GRANT CREATE SESSION TO C##SAMPLE2;
GRANT CREATE TABLE TO C##SAMPLE2;

-- 2. 객체 권한 : 사용자가 특정 객체(테이블, 뷰, 시퀀스, ...)를 조작하거나 접근할 수 있는 권한
/*
    DML(SELECT/INSERT/DELETE)
    GRANT 권한 종류 [(컬럼명)] | ALL
    ON 객체명 | ROLE 이름 
    TO 사용자명 | PUBLIC
*/

-- WITH GRANT OPTION
-- : 사용자가 특정 객체를 조작하거나 접근할 수 있는 권한을 부여 받으면서
--   그 권한을 다른 사용자에게 다시 부여할 수 있는 권한 옵션

GRANT SELECT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE
WITH GRANT OPTION;

-- <샘플 계정으로 실행>
-- 조회 권한을 부여 받았기 때문에 SAMPLE 계정에서도 EMPLOYEE 테이블 조회가 가능하다.
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;

-- WITH GRANT OPTION으로 부여 받은 SELECT 권한은 다른 계정에게 부여 가능하나
-- 그 외의 권한은 부여할 수 없다.
GRANT SELECT ON C##EMPLOYEE.EMPLOYEE  TO C##SAMPLE2;
GRANT INSERT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE2;

-- REVOKE : 권한 철회
REVOKE SELECT ON C##EMPLOYEE.EMPLOYEE FROM C##SAMPLE;

-- <샘플 계정으로 실행>
-- 권한을 회수 했기 때문에 테이블 조회가 불가능하다.
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;

-- 참고
-- WITH GRANT OPTION은 REVOKE시 다른 사용자에게도 부여한 권한을 같이 회수한다.
-- WITH ADMIN OPTION은 특정 사용자의 권한만 회수되고 나머지 다른 사용자에게 부여한
-- 권한은 회수 되지 않는다.

-- 데이터 베이스 ROLE
-- : 사용자마다 일일히 권한을 부여하는 것은 번거롭기 때문에 간편하게 권한을 부여할 수 있는 방법으로 ROLE 제공
-- ROLE
-- : 여러 개의 권한을 묶어 놓는 것
--   사용자에게 부여한 권한을 수정하고자 할 때도 그 롤만 수정하면 해당 롤의 권한을 부여 받은
--   사용자들의 권한이 자동으로 수정된다.

SELECT
        GRANTEE
      , PRIVILEGE
  FROM DBA_SYS_PRIVS
-- WHERE GRANTEE = 'RESOURCE';
 WHERE GRANTEE = 'CONNECT';

-- 롤의 종류
-- 1. 사전 정의 된 롤 : 오라클 설치 시 시스템에서 기본적으로 제공 됨
-- EX) CONNECT, RESOURCE

-- 2. 사용자가 정의하는 롤
-- : CREATE ROLE 명령으로 롤을 생성한다.
--   롤 생성은 반드시 DBA 권한이 있는 사용자만 할 수 있다.
-- CREATE ROLE 롤이름; -- 1. 롤생성
-- GRANT 권한종류 TO 롤이름; --2. 생성 된 롤에 권한 추가
-- RANT 롤이름 TO 사용자명; --3. 사용자에게 롤 부여

CREATE ROLE C##MYROLE;
GRANT CREATE VIEW, CREATE SEQUENCE TO C##MYROLE;
GRANT C##MYROLE TO C##SAMPLE;

-- C##MYROLE의 권한 확인
SELECT
        GRANTEE
      , PRIVILEGE
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE = 'C##MYROLE';
 
-- C##SAMPLE 계정으로 롤 권한 확인
SELECT
        DRP.*
  FROM DBA_ROLE_PRIVS DRP
 WHERE GRANTEE = 'C##SAMPLE';
 
-- <샘플 계정으로 실행> : 접속 해제 후 재접속하여 테스트하면 객체 생성 가능함
CREATE SEQUENCE SEQ_TEST;
