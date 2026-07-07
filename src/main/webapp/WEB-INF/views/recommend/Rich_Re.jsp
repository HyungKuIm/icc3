<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>보장금액 많은 보험상품 추천</title>
    <!-- FontAwesome CDN 링크 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">
        const ctx = "${pageContext.request.contextPath}";
        function move(prodId){
            window.open(`${ctx}/detail.do?prodId=`+prodId, '_self');
        }
        



    </script>
</head>

<body style="background-color: #F8F8FF">
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<div class="container gen">
    
    <div class="kind_wrap">
        <div class="kind_slider">
            <ul class="slider" >
                <c:forEach var="likeProduct" items="${CVArrRDTO}">
                    <li>
                        <div class="card" style="width: 18rem;" onclick= "move('${likeProduct.productId}')">
                            
                            
                            <div class="card-body" style="height: 180px;">
                                <h5 class="card-title" style="margin-bottom: 10px;">${likeProduct.productName}</h5>
                                <div class="card-image"><img src="${likeProduct.imageUrl}" 
	                                                			alt="${likeProduct.companyName}이미지" class="com_image"/></div>
                                <div class="card-text">총보장금액:
                                	<fmt:formatNumber value="${likeProduct.totalCoverageAmount}"/>원</div>
                                <div class="card-text">평균보험료:
                                	<fmt:formatNumber value="${likeProduct.avgPremium}"/>원</div>
                                

                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- 페이징 네비게이션 -->
    <c:if test="${totalPages > 1}">
	    <div class="pagination">
	        <c:if test="${currentPage > 1}">
	            <li class="prev">
	                <a href="${ctx}/goRich.do?page=${currentPage - 1}">&lt; Previous</a>
	            </li>
	        </c:if>
	        <c:forEach var="i" begin="1" end="${totalPages}">
	            <c:choose>
	                <c:when test="${i == currentPage}">
	                    <li class="active">
	                        <a href="javascript:void(0)">${i}</a>
	                    </li>
	                </c:when>
	                <c:otherwise>
	                    <li>
	                        <a href="${ctx}/goRich.do?page=${i}">${i}</a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
	        <c:if test="${currentPage < totalPages}">
	            <li class="next">
	                <a href="${ctx}/goRich.do?page=${currentPage + 1}">Next &gt;</a>
	            </li>
	        </c:if>
	    </div>
    </c:if>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
