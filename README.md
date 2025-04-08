# 🗳️ Poll System


## 📊 주요 기능
- 📌 **설문 추가**: 사용자가 직접 질문과 항목을 추가 가능
- ✅ **투표 참여**: 사용자들이 설문에 참여할 수 있음
- 📈 **결과 확인**: 실시간으로 투표 결과를 시각적으로 확인 가능

![Image](https://github.com/user-attachments/assets/5b838012-69b6-49ef-b615-9c24480e5680)

![Image](https://github.com/user-attachments/assets/2343f6d2-5788-4feb-95db-f587a582c0eb)

![Image](https://github.com/user-attachments/assets/09acf79b-cce1-43b6-b060-03f1b460ac81)

![Image](https://github.com/user-attachments/assets/da6a2c0d-6759-4190-82c4-caf3407c367f)


설문 투표를 생성하고 관리할 수 있는 웹 애플리케이션입니다. 사용자는 다양한 질문을 생성하고, 투표 결과를 실시간으로 확인할 수 있습니다.

## 📌 프로젝트 개요
이 프로젝트는 설문 투표 기능을 제공하는 웹 애플리케이션으로, 사용자는 다음과 같은 작업을 수행할 수 있습니다:
- 설문(Question) 생성
- 설문 항목(Item) 추가 및 수정
- 사용자 투표 기능
- 실시간 투표 결과 확인

## 🚀 기술 스택
- **Back-End**: Java (JSP & Servlet), JDBC
- **Front-End**: HTML, CSS, JavaScript, Bootstrap
- **Database**: MySQL
- **Version Control**: Git, GitHub

## 🔧 프로젝트 실행 방법
### 1️⃣ **프로젝트 클론**
```sh
git clone https://github.com/ysk1007/poll.git
cd poll
```

### 2️⃣ **데이터베이스 설정**
MySQL에서 데이터베이스와 테이블을 생성합니다.
```sql
CREATE DATABASE poll_db;
USE poll_db;

-- Question 테이블
CREATE TABLE question (
    num INT NOT NULL AUTO_INCREMENT,
    title TEXT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    createdate DATE NOT NULL DEFAULT (CURDATE()),
    type INT NOT NULL,
    PRIMARY KEY (num)
);

-- Item 테이블
CREATE TABLE item (
    qnum INT NOT NULL,
    inum INT NOT NULL,
    content TEXT NOT NULL,
    count INT NOT NULL DEFAULT 0,
    PRIMARY KEY (qnum, inum),
    FOREIGN KEY (qnum) REFERENCES question(num)
);
```

### 3️⃣ **Tomcat 실행 및 배포**
- Eclipse 또는 IntelliJ에서 프로젝트를 `Tomcat`에 배포
- `http://localhost:8080/poll` 접속하여 확인

---

🔥 **문의 및 기여**
이 프로젝트에 대한 기여를 환영합니다! 🛠
궁금한 점이 있다면 [GitHub Issues](https://github.com/ysk1007/poll/issues)에 남겨주세요.
