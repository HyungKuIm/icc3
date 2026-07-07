<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>가입가능 상품</title>
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

<div class="container favorite">
    <p style="margin-bottom: 13px; padding: 0px; font-size: 25px;">가입가능 상품</p>
    <div class="kind_wrap">
        <div class="kind_slider">
            <ul class="slider" >
                <c:forEach var="likeProduct" items="${URArrPDTO}">
                    <li>
                        <div class="card" style="width: 18rem;" onclick= "move('${likeProduct.product_id}')">
                            
                            
                            <div class="card-body" style="height: 160px;">
                                <h5 class="card-title" style="margin-bottom: 10px;">${likeProduct.product_name}</h5>
                                <div class="card-image"><img src="${likeProduct.image_url}" 
	                                                			alt="${likeProduct.company_name}이미지" class="com_image"/></div>
                                <div class="card-text">보험사명:${likeProduct.company_name}</div>
                                <div class="card-text">보험료:<fmt:formatNumber value="${likeProduct.premium}"/>원</div>
                                <div class="card-text">가입가능연령:${likeProduct.min_age}세 
                                	~ ${likeProduct.max_age}세</div>

                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
