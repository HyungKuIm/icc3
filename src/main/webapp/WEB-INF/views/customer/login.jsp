<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<main class="container">
    <section>
        <header>
            <div><h2>로그인</h2></div>
        </header>
        <article>
            <form id="" method="post">
                <table>
                    <tr>
                        <td>이메일</td>
                        <td><input id="username" type="text" name="username" placeholder="이메일" required value="sora@naver.com"></td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td><input id="password" type="password" name="password" placeholder="비밀번호" required value="1234"></td>
                    </tr>
                </table>
                <div class="error-message">
                    <c:if test="${param.error != null}">
                        <div class="message error">
                            로그인 실패: 사용자 이름 또는 비밀번호를 확인하세요.
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div class="message logout-success">
                            성공적으로 로그아웃되었습니다.
                        </div>
                    </c:if>
                </div>
                <button class="loginbt" type="submit">로그인</button>
            </form>
        </article>
        <nav style="display:flex;">
            <button id="logbt"><a href="${ctx}/addCustomer.do" style="color: black;">회원가입</a></button>
            <button id="logbt" style="margin-left: 10px;"><a href="${ctx}/findEmail.do" style="color: black;">아이디 찾기</a></button>
            <button id="logbt" style="margin-left: 10px;"><a href="${ctx}/findpw.do" style="color: black;">비밀번호 찾기</a></button>
        </nav>
    </section>
</main>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>
