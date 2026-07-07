<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../common/include.jspf" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/resources/css/clinic.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<main class="container">
    <section>
        <header>
            <div><h2>회원가입</h2></div>
        </header>
        <form action="${ctx}/addCustomer.do" method="post" id="registrationForm">
            <article>
                <table>
                    <tr><td>이메일</td>
                        <td><input type="email" class="regform" id="email" placeholder="aaa@aaa.com" name="email" oninput="checkEmail()">
                            <span class="email-status"></span></td></tr>
                    <tr><td>비밀번호</td><td><input class="regform" type="password" id="pw" name="pw"></td></tr>
                    <tr><td>이름</td>
                        <td><input class="regform" type="text" id="name" name="name"></td></tr>
                    <tr><td>직업</td> <td><input class="regform" type="text" id="occupation" name="occupation"></td></tr>
                    <tr><td>생년월일</td> <td><input class="regform" type="date" id="birth_date" name="birth_date"></td></tr>
                    <tr><td>성별</td>
                        <td><label for="gender01"><input type='radio' id="gender01" name='gender' value='F' />여성</label>&nbsp;
                            <label for="gender02"><input type='radio' id="gender02" name='gender' value='M' />남성</label></td></tr>
                </table><br><br>
                

            </article>
            <nav>
                <button id="regbt" type="submit" disabled>가입하기</button>
            </nav>
        </form>
    </section>
</main>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    const ctx = "${pageContext.request.contextPath}";

    let emailTimer;

    function checkEmail(){
        const email = $('#email').val().trim();

        // 1. 형식 검사
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            setEmailStatus("유효한 이메일 형식을 입력하세요.", "orange", "#fff");
            disableSubmit(true);
            return;
        }

        // 2. debounce(300ms 입력 멈춤 후 요청)
        clearTimeout(emailTimer);
        emailTimer = setTimeout(() => {
            $.ajax({
                url:`${ctx}/emailCheck`,
                type:"POST",
                data : {email: email},
                dataType : "json",
                success:function(data){
                    const result = data;
                    console.log(result.check)
                    if(result.check > 0){
                        setEmailStatus("이미 가입된 이메일입니다.", "rgb(255,120,203)", "#FFCECE");
                        disableSubmit(true);
                    }else{
                        setEmailStatus("사용 가능한 이메일입니다.", "gray", "#B0F6AC");
                        disableSubmit(false);
                    }

                },
                error: function () {
                    setEmailStatus("서버 통신 실패", "red", "#fff");
                    disableSubmit(true);
                }
            });
        }, 300);

    }

    function setEmailStatus(message, textColor, bgColor) {
        $("#email").css("background-color", bgColor);
        $(".email-status").text(message).css("color", textColor);
    }

    function disableSubmit(flag) {
        $("#regbt").prop("disabled", flag); // true/false
    }

    function validateForm() {
        var isValid = true;

        // Check if all text fields are filled
        $("#registrationForm input[type='text'], #registrationForm input[type='password'],  #registrationForm input[type='date']").each(function() {
            if ($(this).val() === "") {
                isValid = false;
            }
        });

        // Check if gender is selected
        if (!$("input[name='gender']").is(":checked")) {
            isValid = false;
        }

        

        // Enable or disable the button based on validation
        if (isValid) {
            $("button#regbt").removeAttr("disabled");
        } else {
            $("button#regbt").attr("disabled", "true");
        }
    }

    // Attach change event listeners to check all form fields
    $("#registrationForm input").on("input change", function() {
        validateForm();
    });
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>
