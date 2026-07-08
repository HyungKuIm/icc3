CREATE TABLE IF NOT EXISTS insurance_company (
    id INT(11) unsigned not null AUTO_INCREMENT COMMENT '보험회사고유번호',
    name VARCHAR(100) NOT NULL COMMENT '보험회사명',
    company_type ENUM('생명보험', '손해보험') NOT NULL COMMENT '보험회사구분',
    tel VARCHAR(30) DEFAULT NULL COMMENT '대표전화',
    homepage VARCHAR(200) DEFAULT NULL COMMENT '홈페이지',
    address VARCHAR(255) DEFAULT NULL COMMENT '주소',
    is_active TINYINT(1) DEFAULT 1 COMMENT '사용여부',
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
    mod_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
    primary key(id)
) COMMENT '보험회사';

CREATE TABLE IF NOT EXISTS insurance_product (
   id INT(11) unsigned not null AUTO_INCREMENT COMMENT '보험상품고유번호',
   company_id INT NOT NULL COMMENT '보험회사외래키',
   name VARCHAR(100) NOT NULL COMMENT '보험상품명',
   product_type VARCHAR(50) DEFAULT NULL COMMENT '상품유형',
   start_date DATE DEFAULT NULL COMMENT '판매시작일',
   end_date DATE DEFAULT NULL COMMENT '판매종료일',
   is_active TINYINT(1) DEFAULT 1 COMMENT '판매여부',
   reg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
   mod_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
   primary key(id)
) COMMENT '보험상품';


CREATE TABLE coverage_master (
 id int unsigned auto_increment primary key,
 name varchar(100) not null,
 description text null
) COMMENT '보장항목마스터';

CREATE TABLE product_coverage (
  id int unsigned auto_increment primary key,
  product_id int not null,
  coverage_id int unsigned not null,
  coverage_amount int null,
  waiting_period_days int null,
  benefit_limit text null
) COMMENT '상품별보장내역';


CREATE TABLE IF NOT EXISTS premium_condition (
    id INT(11) unsigned not null AUTO_INCREMENT COMMENT '보험료조건고유번호',
    product_id INT NOT NULL COMMENT '상품외래키',
    min_age INT DEFAULT NULL COMMENT '최소나이',
    max_age INT DEFAULT NULL COMMENT '최대나이',
    gender ENUM('M', 'F') DEFAULT NULL COMMENT '성별',
    premium INT DEFAULT NULL COMMENT '보험료',
    payment_period_years INT DEFAULT NULL COMMENT '납입기간',
    insurance_period_years INT DEFAULT NULL COMMENT '보장기간',
    PRIMARY KEY(ID)
)  COMMENT '보험료조건';

CREATE TABLE IF NOT EXISTS customer (
    id INT(11) unsigned not null AUTO_INCREMENT COMMENT '고객번호',
    name VARCHAR(100) NOT NULL COMMENT '성명',
    birth_date DATE DEFAULT NULL COMMENT '생년월일',
    gender ENUM('M','F') DEFAULT NULL COMMENT '성별',
    occupation VARCHAR(100) DEFAULT NULL COMMENT '직업',
    email VARCHAR(100) DEFAULT NULL COMMENT '이메일',
    pw VARCHAR(500) DEFAULT NULL COMMENT '비밀번호',
    tel VARCHAR(30) DEFAULT NULL COMMENT '연락처',
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
    mod_date DATETIME DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
    PRIMARY KEY(ID)
) COMMENT '고객';

CREATE TABLE IF NOT EXISTS customer_act (
    id INT(11) unsigned not null AUTO_INCREMENT COMMENT '고객활동번호',
    customer_id INT NOT NULL COMMENT '고객외래키',
    product_id INT NOT NULL COMMENT '상품외래키',
    good ENUM('Y', 'N') DEFAULT 'N' COMMENT '좋아요',
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
    mod_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    primary key(id)
) COMMENT '고객활동';

CREATE TABLE IF NOT EXISTS coverage_analysis (

   id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '보장분석고유번호',

    customer_id INT NOT NULL COMMENT '고객외래키',

    product_id INT NOT NULL COMMENT '상품외래키',

    total_coverage INT DEFAULT NULL COMMENT '총보장금액',

    total_premium INT DEFAULT NULL COMMENT '총보험료',

    analysis_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '분석일',

    PRIMARY KEY(ID)

) COMMENT '보장분석';



CREATE TABLE churn_prediction (
  id int(11) unsigned AUTO_INCREMENT NOT NULL,
  customer_id INT NOT NULL,
  churn_score DECIMAL(5,2) NOT NULL COMMENT '이탈가능점수',
  churn_level ENUM('LOW','MEDIUM','HIGH') NOT NULL COMMENT '이탈위험등급',
  prediction_reason VARCHAR(500) NULL COMMENT '예측사유',
  last_analysis_date DATETIME NULL COMMENT '최근보장분석일',
  status ENUM('예측','관리중','유지','이탈') DEFAULT '예측' COMMENT '관리상태',
  prediction_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '예측일자',
  mod_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  primary key(id)
) COMMENT '고객이탈예측';

CREATE TABLE churn_activity (
    id int(11) unsigned AUTO_INCREMENT NOT NULL,
    churn_prediction_id INT(11) unsigned NOT NULL,
    customer_id INT NOT NULL,
    activity_type ENUM('전화','문자','이메일','상담','혜택제안','기타') NOT NULL COMMENT '활동유형',
    activity_content TEXT NULL COMMENT '활동내용',
    result_status ENUM('미응답','관심있음','상담예약','유지확정','이탈확정') DEFAULT '미응답' COMMENT '활동결과',
    next_action_date DATETIME NULL COMMENT '다음조치일',
    manager_name VARCHAR(50) NULL COMMENT '담당자',
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
    mod_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    primary key(id)

) COMMENT '이탈고객 활동관리';
