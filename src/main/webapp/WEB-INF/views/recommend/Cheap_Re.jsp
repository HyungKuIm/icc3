<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>나이/성별 저렴한 보험료 추천</title>
    <!-- FontAwesome CDN 링크 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">
        const ctx = "${pageContext.request.contextPath}";
        
        function buildUrl(params) {
            const url = new URL(ctx + "/goCheap.do", window.location.origin);
            const current = new URLSearchParams(window.location.search);
            // 현재 쿼리 유지
            for (const [k, v] of current.entries()) url.searchParams.set(k, v);
            // 변경될 값 덮어쓰기
            for (const k in params) url.searchParams.set(k, params[k]);
            // 페이지는 값 변경 시 1로 초기화
            url.searchParams.set('page', '1');
            return url.toString().replace(window.location.origin, '');
          }

          function setAge(age){ window.location.href = buildUrl({age}); }
          function setGender(gender){ window.location.href = buildUrl({gender}); }
          function toggleUnisex(){
            const current = new URLSearchParams(window.location.search);
            const val = current.get('unisex') === 'true' ? 'false' : 'true';
            window.location.href = buildUrl({unisex: val});
          }
        
        function move(prodId){
            window.open(`${ctx}/detail.do?prodId=`+prodId, '_self');
        }
        

    </script>
</head>
<body style="background-color: #F8F8FF">
<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<div class="container gen">
	    <div style="display:flex; gap:10px; margin-bottom:8px;">
	  <button class="button2 ${param.age=='10'?'active':''}" onclick="setAge('10')">10대</button>
	  <button class="button2 ${param.age=='20'?'active':''}" onclick="setAge('20')">20대</button>
	  <button class="button2 ${param.age=='30'?'active':''}" onclick="setAge('30')">30대</button>
	  <button class="button2 ${param.age=='40'?'active':''}" onclick="setAge('40')">40대</button>
	  <button class="button2 ${param.age=='50'?'active':''}" onclick="setAge('50')">50대</button>
	  <button class="button2 ${param.age=='60'?'active':''}" onclick="setAge('60')">60대</button>
	</div>
	
	<div style="display:flex; gap:10px; margin-bottom:12px;">
	  <button class="button2 ${param.gender=='M'?'active':''}" onclick="setGender('M')">남성</button>
	  <button class="button2 ${param.gender=='F'?'active':''}" onclick="setGender('F')">여성</button>
	  <button class="button2 ${param.unisex=='true'?'active':''}" onclick="toggleUnisex()">성별 무관</button>
	</div>

    <div class="kind_wrap">
        <div class="kind_slider">
        <c:choose>
      		<c:when test="${not empty AGArrRDTO}">
            <ul class="slider" >
                <c:forEach var="likeProduct" items="${AGArrRDTO}">
                    <li>
                        <div class="card" style="width: 18rem;" onclick= "move('${likeProduct.productId}')">
                            
                            
                            <div class="card-body" style="height: 180px;">
                                <h5 class="card-title" style="margin-bottom: 10px;">${likeProduct.productName}</h5>
                                <div class="card-image"><img src="${likeProduct.imageUrl}" 
	                                                			alt="${likeProduct.companyName}이미지" class="com_image"/></div>
                                <div class="card-text">보험회사명:${likeProduct.companyName}</div>
                                
                                <div class="card-text">보험료:
                                	<fmt:formatNumber value="${likeProduct.premium}"/>원</div>
                                

                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            </c:when>
	      <c:otherwise>
	        <div style="padding:16px;">조건에 맞는 상품이 없습니다.</div>
	      </c:otherwise>
	    </c:choose>
        </div>
    </div>
    <!-- 페이징 네비게이션 -->
    <c:if test="${totalPages > 1}">
	  <nav class="pagination" style="margin-top:16px; display:flex; gap:6px; align-items:center;">
	    <c:set var="age" value="${param.age}" />
	    <c:set var="gender" value="${param.gender}" />
	    <c:set var="unisex" value="${param.unisex}" />
	
	    <!-- 이전 -->
	    <c:if test="${currentPage > 1}">
	      <c:url var="prevUrl" value="${ctx}/goCheap.do">
	        <c:param name="page" value="${currentPage - 1}" />
	        <c:param name="age" value="${age}" />
	        <c:param name="gender" value="${gender}" />
	        <c:param name="unisex" value="${unisex}" />
	      </c:url>
	      <a class="page-btn" href="${prevUrl}">&laquo;</a>
	    </c:if>
	
	    <!-- 페이지 번호 -->
	    <c:forEach var="p" begin="1" end="${totalPages}">
	      <c:url var="pageUrl" value="${ctx}/goCheap.do">
	        <c:param name="page" value="${p}" />
	        <c:param name="age" value="${age}" />
	        <c:param name="gender" value="${gender}" />
	        <c:param name="unisex" value="${unisex}" />
	      </c:url>
	      <a class="page-btn ${p==currentPage?'active':''}" href="${pageUrl}">${p}</a>
	    </c:forEach>
	
	    <!-- 다음 -->
	    <c:if test="${currentPage < totalPages}">
	      <c:url var="nextUrl" value="${ctx}/goCheap.do">
	        <c:param name="page" value="${currentPage + 1}" />
	        <c:param name="age" value="${age}" />
	        <c:param name="gender" value="${gender}" />
	        <c:param name="unisex" value="${unisex}" />
	      </c:url>
	      <a class="page-btn" href="${nextUrl}">&raquo;</a>
	    </c:if>
	  </nav>
	</c:if>

</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>
