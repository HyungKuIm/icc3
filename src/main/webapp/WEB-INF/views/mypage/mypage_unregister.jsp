<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<main>
    <%@ include file="/WEB-INF/views/include/header.jsp" %>
    <section class="container my-page">
        <sec:authentication property="principal" var="custInfo" />
        <aside>
            <ul>
                <li><a href="${ctx}/info.do">내 정보 수정</a></li>
            </ul>
            
            <ul>
                <li><a href="${ctx}/deleteView.do">회원탈퇴</a></li>
            </ul>
        </aside>

        <div id="mypagediv">
			
            <form id="" action="${ctx}/deleteAccount.do" method="post">
                <input type="hidden" name="id" value="'${memberInfo.id }'">
                <header>
                    <h4>회원탈퇴</h4>
                </header><br><br>
                <article>
                    비밀번호 입력시 회원탈퇴가 완료됩니다.<br><br>
                    <input id="unregister" type="password" name="pw" placeholder="비밀번호를 입력하세요" >
                </article>
                <nav>
                    <button id="unregisterbt">탈퇴</button>
                </nav>
                <h3>${errorMessage }</h3>
            </form>
        </div>


    </section>
</main>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
