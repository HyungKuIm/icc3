<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${ProdDetail.name} 상세정보</title>
    <!-- FontAwesome CDN 링크 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
  const ctx = "${ctx}";

  function clickheart(memberId,prodId, btn) {


	  $.ajax({
		  url:`${ctx}/addGood.do`,
		  type: 'POST',
		  data: {
			  custId:memberId,
			  prodId:prodId
		  },
		  success: function(response) {
			  if (response === "needlogin") {
				  alert("로그인이 필요합니다.");
				  window.location.href = `${ctx}/login.do`;
			  } else if (response === "already") {
				  alert("이미 좋아요 상태입니다.");
			  } else if (response === "done") {
				  var icon=$(btn).find("i");

				  icon.removeClass("far inactive");
				  icon.addClass("fas active");

				  alert("좋아요에 추가되었습니다.");
			  }
		  },
		  error: function (xhr, status, error) {
			  alert("서버 통신 중 오류가 발생했습니다.");
			  console.error("AJAX Error:", status, error);
		  }
	  });
  }



  function setLoading(isLoading){
    const btn = document.getElementById('btnAnalysis');
    if (!btn) return;
    btn.disabled = isLoading;
    btn.innerHTML = isLoading ? '분석 중…' : '보장분석 <i class="fas fa-bar-chart"></i>';
  }

  async function runAnalysis(productId, customerId){
    try {
      setLoading(true);
      // 서버 엔드포인트 예시: POST /analysis/runForProduct.do
      // 서버에서는:
      // - 로그인 사용자인지 재검증(Security)
      // - (옵션) 가입 가능 여부 검증
      // - coverage_analysis UPSERT 수행
      // - JSON 반환 { ok:true, data:{ totalCoverage, minPremium, avgPremium, maxPremium, message } }
      const res = await fetch(`${ctx}/runForProduct.do`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          productId: productId,
          customerId: customerId,
          includeUnisex: true // 필요 시 UI에서 전달
        })
      });
      
      const isJson = res.headers.get('content-type')?.includes('application/json');
      const payload = isJson ? await res.json() : null;

      if(!res.ok){
        //const text = await res.text();
        //throw new Error(text || '분석 요청 실패');
    	  const msg = payload?.message || `요청 실패 (${res.status})`;
          throw new Error(msg);
      }

      //const json = await res.json();
      //if(!json.ok){
      //  throw new Error(json.message || '분석 처리 중 오류');
      //}

      const d = payload?.data || {};
      const box = document.getElementById('analysisBox');
      const sum = document.getElementById('analysisSummary');
      sum.innerHTML =
    	    '<div>총 보장금액: <strong>' + numberWithCommas(d.totalCoverage || 0) + '</strong> 원</div>'
    	  + '<div>최저 보험료: <strong>' + numberWithCommas(d.minPremium || 0) + '</strong> 원</div>'
    	  + '<div>평균 보험료: <strong>' + numberWithCommas(d.avgPremium || 0) + '</strong> 원</div>'
    	  + '<div>최고 보험료: <strong>' + numberWithCommas(d.maxPremium || 0) + '</strong> 원</div>'
    	  + (d.message ? '<div style="margin-top:6px; color:#666;">' + d.message + '</div>' : '');

      box.style.display = 'block';
    } catch (e){
      alert(e.message || '보장분석 중 오류가 발생했습니다.');
    } finally {
      setLoading(false);
    }
  }

  function numberWithCommas(x){
    const n = Number(x||0);
    return n.toLocaleString('ko-KR');
  }

  // 버튼 바인딩
  $(document).on('click', '#btnAnalysis', function(){
    const productId  = $(this).data('product-id');
    const customerId = $(this).data('customer-id');
    if(!customerId){
      alert('로그인 후 이용해 주세요.');
      location.href = `${ctx}/login.do`;
      return;
    }
    // (옵션) 확인 모달
    if(confirm('이 상품에 대해 보장분석을 수행하시겠습니까?')){
      runAnalysis(productId, customerId);
    }
  });
</script>
	
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:choose>
<c:when test="${not empty ProdDetail}">
<div class="container">
    
    <sec:authentication property="principal" var="custInfo" />
    <c:set var="isAuth" value="${custInfo ne null and custInfo ne 'anonymousUser'}" />
	<c:set var="custId" value="${isAuth ? custInfo.id : ''}" />
    <div id="cafe_box">
        <div class="cafe_header">
            <h3>${ProdDetail.name}</h3>
			<button class="favorite" onclick="clickheart('${custId}','${ProdDetail.id}', this)">
				<i class="${ProdDetail.liked == 1 ? 'fas active' : 'far inactive'} fa-heart"></i>
			</button>


            <!-- 로그인 사용자만 보장분석 버튼 노출 -->
			  <sec:authorize access="isAuthenticated()">
			    <button class="favorite" id="btnAnalysis"
			            data-product-id="${ProdDetail.id}"
			            data-customer-id="${custId}">
			      보장분석 <i class="fas fa-bar-chart"></i>
			    </button>
			  </sec:authorize>
			
			  <!-- 비로그인 시: 로그인 유도 -->
			  <sec:authorize access="!isAuthenticated()">
			    <button class="favorite" onclick="location.href='${ctx}/login.do?redirect=${pageContext.request.requestURI}?prodId=${ProdDetail.id}'">
					보장분석 <i class="fas fa-sign-in-alt"></i>
			    </button>
			  </sec:authorize>
        </div>
        

        
        <div id="analysisBox" class="cafe_info" style="display:none; margin-top:12px;">
		  <h5><strong>보장분석 결과</strong></h5>
		  <div id="analysisSummary" style="margin-top:6px;"></div>
		</div>
        
        <section id="detail_section">
            <div class="flex-container">
                <h5>상품타입: ${ProdDetail.productType}</h5>
                <h5>판매기간:${ProdDetail.startDate} 
                    ~ ${ProdDetail.endDate == null ? '판매중' : ProdDetail.endDate}</h5>
            </div>
            <div class="cafe_info">
                <ul>
                    <li><h5><strong>보험사 정보</strong></h5></li>
                    <li><img src="<c:url value="/resources${ProdDetail.company.imageUrl}"/>" alt="${ProdDetail.company.name}이미지" class="com_image"/></li>
                    <li><strong>보험사명 :</strong> ${ProdDetail.company.name}</li>
                    <li><strong>전화번호 :</strong> ${ProdDetail.company.phone}</li>
                    <li><strong>웹사이트 :</strong> <a href="${ProdDetail.company.website}" target="_blank">${ProdDetail.company.website}</a></li>
                </ul>
            </div>
            
            <div class="cafe_info">
			  <ul>
			    <li><h5><strong>보장항목</strong></h5></li>
			    <c:choose>
			      <c:when test="${not empty ProdDetail.coverageItems}">
			        <table class="tbl">
			          <thead>
			            <tr>
			              <th>담보명</th>
			              <th>설명</th>
			              <th>보장금액</th>
			              <th>면책기간</th>
			              <th>보장조건</th>
			            </tr>
			          </thead>
			          <tbody>
			            <c:forEach var="cov" items="${ProdDetail.coverageItems}">
			              <tr>
			                <td>${cov.name}</td>
			                <td>${cov.description}</td>
			                <td>
			                  <c:choose>
			                    <c:when test="${cov.coverageAmount != null && cov.coverageAmount > 0}">
			                      <fmt:formatNumber value="${cov.coverageAmount}" type="number"/> 원
			                    </c:when>
			                    <c:otherwise>실비/해당없음</c:otherwise>
			                  </c:choose>
			                </td>
			                <td>
			                  <c:choose>
			                    <c:when test="${cov.waitingPeriodDays != null}">${cov.waitingPeriodDays}일</c:when>
			                    <c:otherwise>없음</c:otherwise>
			                  </c:choose>
			                </td>
			                <td>${cov.benefitLimit}</td>
			              </tr>
			            </c:forEach>
			          </tbody>
			        </table>
			      </c:when>
			      <c:otherwise>
			        <li>등록된 보장항목이 없습니다.</li>
			      </c:otherwise>
			    </c:choose>
			  </ul>
			</div>

            
            <div class="cafe_info">
			  <ul>
			    <li><h5><strong>보험료 조건</strong></h5></li>
			    <c:choose>
			      <c:when test="${not empty ProdDetail.premiumConditions}">
			        <table class="tbl">
			          <thead>
			            <tr>
			              <th>성별</th>
			              <th>가입연령</th>
			              <th>보험료</th>
			              <th>납입기간</th>
			              <th>보험기간</th>
			            </tr>
			          </thead>
			          <tbody>
			            <c:forEach var="pr" items="${ProdDetail.premiumConditions}">
			              <tr>
			                <td>
			                  <c:choose>
			                    <c:when test="${pr.gender == 'M' || pr.gender.name() == 'M'}">남</c:when>
			                    <c:when test="${pr.gender == 'F' || pr.gender.name() == 'F'}">여</c:when>
			                    <c:otherwise>-</c:otherwise>
			                  </c:choose>
			                </td>
			                <td>
			                  <c:if test="${pr.minAge != null}">${pr.minAge}</c:if>
			                  ~
			                  <c:if test="${pr.maxAge != null}">${pr.maxAge}</c:if> 세
			                </td>
			                <td><fmt:formatNumber value="${pr.premium}" type="number"/> 원</td>
			                <td>
			                  <c:choose>
			                    <c:when test="${pr.paymentPeriodYears != null}">${pr.paymentPeriodYears}년납</c:when>
			                    <c:otherwise>-</c:otherwise>
			                  </c:choose>
			                </td>
			                <td>
			                  <c:choose>
			                    <c:when test="${pr.insurancePeriodYears != null}">${pr.insurancePeriodYears}년</c:when>
			                    <c:otherwise>종신/기타</c:otherwise>
			                  </c:choose>
			                </td>
			              </tr>
			            </c:forEach>
			          </tbody>
			        </table>
			      </c:when>
			      <c:otherwise>
			        <li>등록된 보험료 조건이 없습니다.</li>
			      </c:otherwise>
			    </c:choose>
			  </ul>
			</div>

            
            
        </section>
    </div>
</div>
</c:when>
<c:when test="${empty ProdDetail}">
<script type="text/javascript">
    alert("보험상품이 존재하지 않습니다.");
    window.location.href = '/';
</script>
</c:when>
</c:choose>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>