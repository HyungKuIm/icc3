<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<section data-bs-version="5.1" class="slider4 mbr-embla cid-ubxwyl8tSX" id="gallery-5-ubxwyl8tSX">
    <div class="container">
        <div class="row mb-5 " >
            <div class="col-12 content-head">
                <div style="display: flex; align-items: center; justify-content: center; flex: 1;max-width: 1225px">
                    <a id="a" href="${ctx}/"><img src="${ctx}/resources/images/image.webp" id="main_img" width="100px" height="100px" style="margin-right: 20px;margin-left: 120px;"></a>
                    <p id='main'><a id="a" href="${ctx}/" style="color:black">보험가입 보장분석 클리닉</a></p>
                </div>
                <sec:authentication property="principal" var="custInfo" />
                <c:set var="custId" value="${(custInfo != null && custInfo ne 'anonymousUser') ? custInfo.id : ''}" />
                <c:if test="${custInfo != null && custInfo ne 'anonymousUser'}">
                    <button class="button1" type="button" onclick="location.href='${ctx}/info.do'">마이페이지</button>
                    <button class="button1" type="button" onclick="location.href='${ctx}/logout'">로그아웃</button>
                </c:if>
                <c:if test="${custInfo == null || custInfo eq 'anonymousUser'}">
                    <button class="button1" type="button" onclick="location.href='${ctx}/login.do'">로그인</button>
                </c:if>

            </div>
            <div class="container-fluid" style=" padding: 10px; margin-top: 50px">
                <ul id="list">
                    <li><a id="a1" href="${ctx}/goRich.do">보장금액많은 상품 추천</a></li>
                    <li><a id="a1" href="${ctx}/goCheap.do?age=30&gender=M&unisex=false">나이/성별 저렴한 보험료 추천</a></li>
                    <li><a id="a1" href="#" onclick="goMyCoverage('${custId}')">가입가능상품 추천</a></li>
                </ul>
            </div>
            <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" action="${ctx}/search.do">
                <div class="input-group" style="margin-top: 35px;display: flex; align-items: center; justify-content: center;">
                    <input type="text" name="keyWord" class="form-control bg-light border-0 small"
                           placeholder="키워드를 입력해주세요"
                           value="${param.keyWord}"
                           aria-label="Search" aria-describedby="basic-addon2"
                           style="width: 400px; height: 50px; background: #F0F0F0">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit" style="height: 50px; width: 50px">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<script>
    function goMyCoverage(cust_id){
        if(!cust_id){
            alert("로그인이 필요합니다.");
            window.location.href = '${ctx}/login.do';
        }else{
            window.location.href = '${ctx}/goMy.do?custId='+cust_id;

        }
    }
</script>