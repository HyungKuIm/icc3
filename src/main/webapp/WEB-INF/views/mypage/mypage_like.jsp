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
            <h5>나의 활동</h5>
            <ul>
                <li><a href="${ctx}/myGood.do">좋아요 누른 상품</a></li>
                <li><a href="${ctx}/goMyAnal.do">보장분석을 한 상품</a></li>
            </ul>
            
            <ul>
                <li><a href="${ctx}/deleteView.do">회원탈퇴</a></li>
            </ul>
        </aside>

        <div id="mypagelikediv">
            <header>
                <h4>좋아요 누른 상품</h4>
            </header>
            <article>
                <c:forEach var="prod" items="${prods}">
                    <div class="cafe-container">
                        <a href="detail.do?prodId=${prod.product_id }">

                            <img class="com_image" alt="" src="<c:url value="/resources${prod.image_url}" />" />
                            <span><strong>${prod.product_name}</strong></span>
                        </a>

                        <!-- 좋아요 상태에 따라 하트 색상 변경 -->
                        <i class="fas fa-heart" data-cafe-id="${prod.product_id}"><a></a></i>
                    </div>
                </c:forEach>

                <div class="pagination">
                    <nav class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${ctx}/myGood.do?page=${currentPage - 1}">이전</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <c:if test="${i == currentPage}">
                                <li class="active"><a href="#">${i}</a></li>
                            </c:if>
                            <c:if test="${i != currentPage}">
                                <a href="${ctx}/myGood.do?page=${i}">${i}</a>
                            </c:if>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="${ctx}/myGood.do?page=${currentPage + 1}">다음</a>
                        </c:if>
                    </nav>
                </div>
            </article>

        </div>


    </section>
</main>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
