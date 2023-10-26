-- JOIN
--	하나의 명령문에 의해 여러 테이블에 저장된 데이터를 한번에 조회할 수 있는 기능
--	마치 하나의 테이블인 것처럼 보여짐

CREATE TABLE tb1(name varchar2(10 char), age number(3));
CREATE TABLE tb2(name varchar2(10 char), age number(3));

INSERT INTO tb1 values('김길동',30);
INSERT INTO tb1 values('박길동',35);
INSERT INTO tb1 values('최길동',40);
INSERT INTO tb1 values('오길동',40);

INSERT INTO tb2 values('김길동',30);
INSERT INTO tb2 values('정길동',50);
INSERT INTO tb2 values('이길동',55);

-- cross join : 별도의 조건 없이 두 테이블 간의 가능한 모든 결과를 조회(모든 경우의 수) / 사실상 사용할 일이 없음.
SELECT * FROM tb1,tb2;
SELECT * FROM tb1 cross join tb2;

-- inner join : 조건에 해당하는 값만 나옴
SELECT * FROM tb1 INNER JOIN tb2 ON tb1.name = tb2.name;
SELECT * FROM tb1 A, tb2 B WHERE A.name = B.name; -- 동등조인(EQUI 조인)
SELECT * FROM tb1 join tb2 using(name);
SELECT * FROM tb1 NATURAL JOIN tb2; -- 자연조인(NATURAL JOIN) : 조건절 없이 양 테이블의 같은 이름을 가진 동일한 컬럼만 조회함.

-- outer join : 기준 테이블의 데이터가 모두 조회(누락 없음), 대상 테이블에 데이터가 있는 경우 해당 컬럼의 값을 가져오기 위해 사용.
--	*left outer join : 왼쪽 테이블에 값이 있을 때 오른쪽 테이블이 조건에 맞지 않아도 나옴
--		(조건에 맞지 않는 부분은 NULL)
SELECT * FROM tb1 LEFT OUTER JOIN tb2 on tb1.name = tb2.name;
SELECT * FROM tb1, tb2 WHERE tb1.name = tb2.name(+);

--	right outer join : 오른쪽 테이블에 값이 있을 때 왼쪽 테이블이 조건에 맞지 않아도 나옴
SELECT * FROM tb1 RIGHT OUTER JOIN tb2 ON tb1.name = tb2.name;
SELECT * FROM tb1, tb2 WHERE tb1.name(+) = tb2.name;

-- full outer join : 한쪽 테이블에 값이 있으면, 다른쪽 테이블이 조건에 맞지 않아도 나옴
SELECT * FROM tb1 FULL OUTER JOIN tb2 ON tb1.name = tb2.name;

-- self join : 하나의 테이블 안에 있는 컬럼끼리 연결하는 조인이 필요한 경우
-- 			단어 뜻 그대로 스스로 JOIN 한다는 뜻.

DROP TABLE oct26_member;

CREATE TABLE oct26_member(
	m_id VARCHAR2(15 char) primary key,
	m_name VARCHAR2(10 char) not null,
	m_manager VARCHAR2(15 char)
);

INSERT INTO oct26_member VALUES('member1','회원1','manager1');
INSERT INTO oct26_member VALUES('member2','회원2','manager1');
INSERT INTO oct26_member VALUES('member3','회원3','manager1');
INSERT INTO oct26_member VALUES('member4','회원4','manager2');
INSERT INTO oct26_member VALUES('member5','회원5','manager2');

INSERT INTO oct26_member VALUES('manager1','관리자1',null);
INSERT INTO oct26_member VALUES('manager2','관리자2',null);

SELECT * FROM oct26_member A JOIN oct26_member B ON A.m_id = B.m_id;

-- 똑같은 테이블에 별칭 부여해서 self join. 계정 ID와 관리자 계정이 같은 값을 연결해서 관리하는 회원의 ID를 가져옴.
SELECT A.m_id, A.m_name, B.m_id FROM oct26_member A JOIN oct26_member B ON A.m_id = B.m_manager;


CREATE TABLE oct26_item(
	i_num number(5) PRIMARY KEY,
	i_m_num number(5) not null,
	i_name VARCHAR2(10 char) not null,
	i_weight number(5) not null,
	i_price number(7) not null,
	CONSTRAINT market_num FOREIGN KEY(i_m_num) REFERENCES oct26_market(m_num) ON DELETE CASCADE
);

CREATE TABLE oct26_market(
	m_num number(5) PRIMARY KEY,
	m_name VARCHAR2(20 char) not null,
	m_locale VARCHAR2(20 char) not null,
	m_capacity NUMBER(4) not null,
	m_parking NUMBER(4) not null
);

DROP TABLE oct26_item;
DROP TABLE oct26_market;

DROP SEQUENCE oct26_item_seq;
DROP SEQUENCE oct26_market_seq;

CREATE SEQUENCE oct26_item_seq;
CREATE SEQUENCE oct26_market_seq;

INSERT INTO oct26_market VALUES(oct26_market_seq.nextval,'홈플러스','강남점',1000,500);
INSERT INTO oct26_market VALUES(oct26_market_seq.nextval,'홈플러스','강서점',500,300);
INSERT INTO oct26_market VALUES(oct26_market_seq.nextval,'이마트','서초점',800,800);

INSERT INTO oct26_item VALUES(oct26_item_seq.nextval,1,'배추',3000,10000);
INSERT INTO oct26_item VALUES(oct26_item_seq.nextval,2,'무',500,5000);
INSERT INTO oct26_item VALUES(oct26_item_seq.nextval,3,'배추',2000,5000);

SELECT * FROM oct26_item;
SELECT * FROM oct26_market;

-- CRUD
--	C(create) : INSERT
--				SEQUENCE 사용, 정보 입력 등~
--	R(Read) : READ
--				거의 대부분의 시간 사용
--	U(Update) : UPDATE
--				값의 수정

UPDATE [테이블명] SET [컬럼명] = 값, [컬럼명] = 값 WHERE 조건문~

UPDATE oct26_item SET i_price = 5000 WHERE i_name = '무';

UPDATE oct26_item SET i_name = '김장용배추' WHERE i_name = '%배추';

UPDATE oct26_market SET m_parking = m_parking * 0.7;

UPDATE oct26_item SET i_price = i_price * 0.9 WHERE i_m_num = (SELECT m_num FROM oct26_market WHERE m_locale = '강서점' AND m_name = '홈플러스');

UPDATE oct26_item SET i_price = i_price * 0.9 WHERE i_price = (SELECT max(i_price) FROM oct26_item);

-- D(Delete) : DELETE

DELETE FROM [테이블] WHERE 조건;

DELETE FROM oct26_item WHERE i_name ='무';

DELETE FROM oct26_item WHERE i_m_num = (SELECT m_num FROM oct26_market WHERE m_capacity = (SELECT min(m_capacity) FROM oct26_market));

SELECT * FROM oct26_item ORDER BY i_name;

-- 1 --

CREATE TABLE oct26_comp(
	c_num number(5) primary key,
	c_name varchar2(10 char) not null,
	c_os varchar2(20 char) not null,
	c_date date not null,
	c_weight NUMBER(4,2) not null,
	c_cpu varchar2(10 char) not null
);

CREATE SEQUENCE oct26_comp_seq;

TRUNCATE TABLE oct26_comp;

SELECT * FROM oct26_comp;

INSERT INTO oct26_comp VALUES(oct26_comp_seq.nextval,'컴퓨터1','Windows 10 Pro',to_date('2023-10-26','YYYY-MM-DD'),5.12,'i5-1234');
INSERT INTO oct26_comp VALUES(oct26_comp_seq.nextval,'컴퓨터2','Windows 11 Pro',to_date('2023-09-06','YYYY-MM-DD'),5.23,'i7-5678');

-- 2 --
INSERT INTO oct26_comp VALUES(oct26_comp_seq.nextval,'컴퓨터3','Windows 10 Pro',to_date('2023-07-11','YYYY-MM-DD'),3.22,'i7-1234');

-- 3 --
SELECT c_date,count(c_num) FROM oct26_comp WHERE c_date = (SELECT min(c_date) FROM oct26_comp) GROUP BY c_date;

-- 3-2 --
SELECT min(c_date),count(*) FROM oct26_comp;

-- 4 --
SELECT c_date FROM oct26_comp WHERE c_date = (SELECT max(c_date) FROM oct26_comp);

-- 5 --
SELECT * FROM (SELECT c_name,c_os,c_date,c_weight,c_cpu,rownum as rn FROM (SELECT * FROM oct26_comp ORDER BY c_weight)) WHERE rn BETWEEN 2 AND 3;