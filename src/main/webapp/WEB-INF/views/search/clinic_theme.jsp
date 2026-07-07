<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=548328d0caa98e140a092e8c58911c95"></script>
<html>
<head>
    <title>보험상품 검색 결과</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">
        const ctx = "${pageContext.request.contextPath}";
        function move(prodId) {
            window.open(`${ctx}/detail.do?prodId=` + prodId, '_self');
        }
    </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<input id="nowKeyWord" type="hidden" value="${keyWord}">
<div class="cafe-search-result">

    <div>
        
        <div style=" margin-left: 50px;">
            
            <div class="kind_wrap">
                <c:choose>
                    <c:when test="${not empty SRArrSDTO}">
                        <div class='kind_slider'>
                            <ul class="slider">
                                <c:forEach var="likeProduct" items="${SRArrSDTO}">
                                    <li>
                                        <div class="card" style="width: 330px;" onclick="move('${likeProduct.product_id}')">
                                            
                                            <div class="card-body" style="height: 180px;">
                                                <h5 class="card-title" style="margin-bottom: 10px;">${likeProduct.product_name}</h5>
                                                <div class="card-group">
	                                                <div class="card-image"><img src="${likeProduct.image_url}" 
	                                                			alt="${likeProduct.company_name}이미지" class="com_image"/></div>
	                                                <div class="card-text-group">		
		                                                <div class="card-text">보험사명:${likeProduct.company_name}</div>
		                                                <div class="card-text">보험유형:${likeProduct.product_type}</div>
		                                                <div class="card-text">판매기간:${likeProduct.start_date} 
		                                                	~ ${likeProduct.end_date == null ? '판매중' : likeProduct.end_date}</div>
		                                                <div class="card-text">보장항목:${likeProduct.coverage_items}</div>
		                                                <div class="card-text">보험료:<fmt:formatNumber value="${likeProduct.min_premium}"/>원 
		                                                	~ <fmt:formatNumber value="${likeProduct.max_premium}" />원</div>
		                                                <div class="stars">
						                                    <!-- POINT 수만큼 별을 보여줌 -->
						                                    <c:forEach begin="1" end="${likeProduct.rating}" var="i">
						                                        <i class="fas fa-star" style="color: gold;"></i>
						                                    </c:forEach>
						                                    <c:forEach begin="1" end="${5 - likeProduct.rating}" var="i">
															    <i class="far fa-star" style="color: gold;"></i>
															</c:forEach>
						                                </div>	
	                                                </div>
                                                </div>	
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:when>
                    
                </c:choose>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>
