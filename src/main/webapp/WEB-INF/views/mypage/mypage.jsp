<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>MyPage</title>
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

            <form id="" action="${ctx}/update.do" method="post">
                <input type="hidden" name="id" value="${custInfo.id }">
                <header>
                    <h4>내 정보 수정</h4>
                </header>
                <article>
                    <table>
                        <tr><td>이메일 </td>

                            <td>
                                <input id="regform" class="regfromc" type="text" readonly="readonly" name="Email" value="${info.email}" required>
                            </td>
                        </tr>
                        <tr><td>비밀번호</td><td><input id="regform" type="password" name="pw" ></td></tr>

                        <tr><td>이름</td>
                            <td><input id="regform" class="regfromc" type="text" name="name" value="${info.name }" readonly="readonly"></td></tr>
                        <tr><td>직업</td> <td><input id="regform" type="text" name="occupation" value="${info.occupation }" required></td></tr>
                        <tr><td>생년월일</td> <td><input id="regform" type="date" name="birth_date" value="${info.birth_date }"></td></tr>
                        <tr><td>성별</td>

                            <td> <label for="gender01"><input type='radio' id="gender01" name='gender' value='F' <c:if test="${info.gender eq 'F' }"> checked </c:if>/>여성</label> &nbsp;
                                <label for="gender02"><input type='radio' id="gender02" name='gender' value='M' <c:if test="${info.gender eq 'M' }"> checked </c:if>/>남성</label></td></tr>
                    </table><br><br>


                    
                </article>
                <nav>
                    <button id="mypagebt" type="submit">수정</button>
                </nav>
            </form>
        </div>


    </section>
</main>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
