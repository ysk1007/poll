# 🗳️ Poll System - 설문 투표 웹 애플리케이션

설문을 생성하고, 항목을 추가하며, 사용자들이 투표에 참여할 수 있는 웹 기반 투표 시스템입니다. 실시간으로 투표 결과를 확인할 수 있으며, 게시판 기능까지 포함되어 있습니다.

## 🌟 주요 기능
- 📝 **설문 생성**: 제목, 기간, 유형을 입력하여 설문 생성
- ➕ **항목 관리**: 설문 항목 추가 및 투표 수 집계
- ✅ **투표 기능**: 사용자 참여 가능 (중복 투표 제한 기능 포함)
- 📊 **결과 시각화**: 실시간 그래프/바 차트로 결과 확인
- 💬 **게시판**: 계층형 구조의 커뮤니티 기능

---

## 📷 미리보기

| 설문 메인 화면 | 결과 차트 | 게시판 리스트 |
|---|---|---|
| ![설문](https://github.com/user-attachments/assets/5b838012-69b6-49ef-b615-9c24480e5680) | ![결과](https://github.com/user-attachments/assets/09acf79b-cce1-43b6-b060-03f1b460ac81) | ![게시판](https://github.com/user-attachments/assets/da6a2c0d-6759-4190-82c4-caf3407c367f) |

---

## 🛠️ 기술 스택

| 구분 | 기술 |
|------|------|
| Back-End | Java (JSP & Servlet), JDBC |
| Front-End | HTML, CSS, JS, Bootstrap, SB-Admin 2 |
| Database | MySQL |
| Version Control | Git & GitHub |
| 환경 | Apache Tomcat 9, Eclipse/IntelliJ |

---

## 🚀 프로젝트 실행 방법

### 1️⃣ 프로젝트 클론
```bash
git clone https://github.com/ysk1007/poll.git
cd poll
```

### 2️⃣ 데이터베이스 설정
```sql
CREATE DATABASE poll_db;
USE poll_db;

-- 설문 테이블
CREATE TABLE question (
    num INT AUTO_INCREMENT PRIMARY KEY,
    title TEXT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    createdate DATE NOT NULL DEFAULT (CURDATE()),
    type INT NOT NULL
);

-- 항목 테이블
CREATE TABLE item (
    qnum INT NOT NULL,
    inum INT NOT NULL,
    content TEXT NOT NULL,
    count INT DEFAULT 0,
    PRIMARY KEY (qnum, inum),
    FOREIGN KEY (qnum) REFERENCES question(num)
);
```

> ⚠️ 추가로 게시판 기능을 위한 테이블도 필요하다면 아래 SQL을 참고하세요.

```sql
CREATE TABLE board (
	num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	subject VARCHAR(50) NOT NULL,
	content TEXT NOT NULL,
	pos SMALLINT DEFAULT 0,
	ref SMALLINT DEFAULT 0,
	depth SMALLINT DEFAULT 0,
	regdate DATE DEFAULT (CURDATE()),
	pass VARCHAR(15) NOT NULL,
	ip VARCHAR(15) NOT NULL,
	count SMALLINT DEFAULT 0
);
```

### 3️⃣ 톰캣에 배포 및 실행
- `Eclipse` 또는 `IntelliJ`에 프로젝트 import
- `Tomcat 9` 서버 연결 후 실행
- 브라우저에서 `http://localhost:8080/poll` 접속

---

## 🤝 기여 & 이슈
- 버그나 제안이 있다면 [Issues](https://github.com/ysk1007/poll/issues)를 통해 남겨주세요.
- 누구든지 Fork & PR 환영합니다!

---

## 👨‍💻 개발자
**윤성권 (Yun Sungkwon)**  
📫 [GitHub](https://github.com/ysk1007)
