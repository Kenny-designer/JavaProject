<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <title>Farina Pizza</title>
  <link rel="icon" href="images/farina_pizza.png" type="img/png">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- m -->
  <script src="https://cdn.jsdelivr.net/npm/js-cookie@3.0.5/dist/js.cookie.min.js"></script> <!-- 使用 jquery cookie，需先載入的套件 -->
</head>
 <style>
	   /* 背景圖區塊樣式，使用 vw 和 vh 來設置大小 */
		.navbar-bg {
		  background-image: url('images/bg_7.jpg'); /* 替換成你的圖片路徑 */
		  background-size: cover;
		  background-position: center;
		  width: 100vw;
		  height: 100vh;
		  position: fixed;   /* <-- 加這一行才會蓋滿背景 */
		  top: 0;
		  left: 0;
		  z-index: 0;
		}

		  /* 加這段讓導覽列在最上層 */
		  nav.navbar {
		    position: relative;
		    z-index: 3;
		  }
	  .btn-outline-yellow {
	    border: 2px solid #ffc107;
	    color: white;
	    background-color: transparent;
	    min-width: 140px;        /* 固定寬度讓按鈕一致 */
	    padding: 10px 20px;      /* 固定 padding 避免跳動 */
	    transition: background-color 0.3s, color 0.3s;
	  }
	
	  .btn-outline-yellow:hover {
	    background-color: #ffc107;
	    color: black;
	  }
	
	  .btn-outline-yellow.active {
	    background-color: #ffc107 !important;
	    color: black !important;
	  }
	  
	#loadingSpinner {
	  display: none; /* 預設不顯示 */
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100vw;
	  height: 100vh;
	  background-color: rgba(0, 0, 0, 0.5);
	  z-index: 9999;
	
	  /* 讓它置中關鍵在這裡 */
	  display: flex;
	  justify-content: center;
	  align-items: center;
	}

 </style>

<body> <!-- m -->
<%
	String url = request.getContextPath();
	String url_checkemail = url +"/checkemail";
	String url_login = url +"/login";
	String url_signup = url +"/signup";
	String url_resend = url +"/resend";
	String url_send = url +"/send";
	String url_forgetpwd = url +"/forgetpwd";
	
	String email = (String) session.getAttribute("email");
    if ( email != null ) {
    	response.sendRedirect(url + "/index.jsp"); // 回到首頁
    }
%>

  <!-- 導覽列 -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="index.jsp">Farina Pizza 法里娜披薩</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="index.jsp">首頁</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="menu.jsp">各類披薩</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="store.jsp">門市資訊</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="member.jsp">加入會員</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="booking.jsp">餐廳訂位</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

<!-- 若還沒登入就點餐廳訂位，就會跳轉過來並顯示下列訊息 -->
<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
	<div class="alert alert-warning alert-dismissible fade show text-center"
	     role="alert"
	     style="position: fixed; top: 1rem; left: 50%; transform: translateX(-50%);
	            z-index: 9999; width: fit-content; max-width: 90%;">
	  <%= msg %>
	  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
<%
        session.removeAttribute("msg");
    }
%>

  <div class="navbar-bg"></div> <!-- 背景層 -->

	<div class="d-flex justify-content-center mt-5" style="z-index: 2; position: relative; margin-left: 5vw;">
	  <div class="container" style="max-width: 500px;">
	  
		<!-- 登入功能區塊 -->
		<div class="container my-5">
		
		  <!-- 分類按鈕（自訂切換） -->
		  <div class="row mb-4">
		    <div class="col-auto">
		      <button class="btn btn-outline-yellow me-2 text-white active" data-type="login" onclick="showAuthForm(this)">登入</button>
		      <button class="btn btn-outline-yellow me-2 text-white" data-type="register" onclick="showAuthForm(this)">註冊</button>
		      <button class="btn btn-outline-yellow me-2 text-white" data-type="forgot" onclick="showAuthForm(this)">忘記密碼</button>
		    </div>
		  </div>
		
		  <!-- 表單內容區塊 -->
		  <div class="bg-transparent text-white p-4 rounded shadow">
		    <!-- 登入 -->
		    <div class="auth-form" data-type="login">
		      <form id="login" method="post"> <!-- m -->
		        <div class="mb-3">
		          <label for="loginEmail" class="form-label">電子郵件</label>
					<input type="email" class="form-control" id="loginEmail" name="email" required>
					 <span id="loginEmail_error" style="color: red; font-size:18px; font-family:Arial;"></span> <!-- m -->
					<div class="invalid-feedback" id="loginEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        <div class="mb-3">
		          <label for="loginPassword" class="form-label">密碼</label>
		          <div class="input-group">
		            <input type="password" class="form-control" id="loginPassword" name="password" required>
		            <button type="button" class="btn btn-outline-light" onclick="togglePassword('loginPassword', this)">顯示</button>
		          </div>
		          <span id="loginPassword_error" style="color: red; font-size:18px; font-family:Arial;"></span> <!-- m -->
		        </div>
		        <button id="login_button" type="submit" class="btn btn-warning w-100">登入</button> <!-- m -->
		      </form>
		    </div>
		
		    <!-- 註冊 -->
		    <div class="auth-form d-none" data-type="register">
		      <form id="signup" method="post"> <!-- m -->
		        <div class="mb-3">
		          <label for="registerUsername" class="form-label">使用者名稱</label>
		          <input type="text" class="form-control" id="registerUsername" name="username" required>
		        </div>
		        <div class="mb-3">
		          <label for="registerEmail" class="form-label">電子郵件</label>
		            <input type="email" class="form-control" id="registerEmail" name="email" required>
					<div class="invalid-feedback" id="registerEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        <span id="check_ok" style="color: green; font-size:18px; font-family:Arial;"></span> <!-- m -->
		        <span id="check_error" style="color: red; font-size:18px; font-family:Arial;"></span> <!-- m -->
		        <button id="checkemail" type="button" class="btn btn-warning w-100">檢查是否為已註冊帳號</button> <!-- m -->
		        
				<!-- 註冊密碼欄位 -->
				<div class="mb-3">
				  <label for="registerPassword" class="form-label">密碼</label>
				  <div class="input-group">
				    <input type="password" class="form-control" id="registerPassword" name="password" required>
				    <button type="button" class="btn btn-outline-light" onclick="togglePassword('registerPassword', this)">顯示</button>
				  </div>
				  <div class="form-text text-danger" id="passwordError" style="display: none;"></div>
				</div>
				
				<!-- 確認密碼欄位 -->
				<div class="mb-3">
				  <label for="confirmPassword" class="form-label">確認密碼</label>
				  <div class="input-group">
				    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
				    <button type="button" class="btn btn-outline-light" onclick="togglePassword('confirmPassword', this)">顯示</button>
				  </div>
				</div>
		        <button id="register_button" type="submit" class="btn btn-warning w-100">註冊</button>
		      </form>
		    </div>
		
		    <!-- 忘記密碼 -->
		    <div class="auth-form d-none" data-type="forgot">
		      <form id="forgotpwd" method="post">
		        <div class="mb-3">
		          <label for="forgotEmail" class="form-label">電子郵件</label>
		            <input type="email" class="form-control" id="forgotEmail" name="email" required>
					<div class="invalid-feedback" id="forgotEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        <span id="forgetpwd_error" style="color: red; font-size:18px; font-family:Arial; font-weight: bold;"></span> <!-- m -->
		        <button id="forgotpwd_button" type="submit" class="btn btn-warning w-100">重設密碼連結</button>
		      </form>
		    </div>
		  </div>
		</div>	  
	  
	  
	  </div>
	</div>  

	<!-- Loading Spinner --> <!-- m -->
	<div id="loadingSpinner" style="display: none; position:fixed; top:0; left:0; width:100vw; height:100vh; background-color: rgba(0,0,0,0.5); z-index:9999; justify-content:center; align-items:center;">
	  <div class="spinner-border text-warning" role="status" style="width: 3rem; height: 3rem;">
	    <span class="visually-hidden">Loading...</span>
	  </div>
	</div>

</body>
<script>
  function showAuthForm(button) {
    const type = button.getAttribute('data-type');

    // 切換按鈕樣式
    document.querySelectorAll('[onclick="showAuthForm(this)"]').forEach(btn => {
      btn.classList.remove('active');
    });
    button.classList.add('active');

    // 顯示對應表單
    document.querySelectorAll('.auth-form').forEach(form => {
      form.classList.add('d-none');
      if (form.getAttribute('data-type') === type) {
        form.classList.remove('d-none');
      }
    });
  }

  // 即時 email 驗證
	['loginEmail', 'registerEmail', 'forgotEmail'].forEach(id => {
	  const input = document.getElementById(id);
	  const errorMsg = document.getElementById(id + 'Error');
	
	  input.addEventListener('input', function () {
	    const pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
	    if (pattern.test(this.value)) {
	      this.classList.remove('is-invalid');
	      errorMsg.style.display = 'none';
	    } else {
	      this.classList.add('is-invalid');
	      errorMsg.style.display = 'block';
	    }
	  });
	});

	// 密碼一致性檢查
	const registerPassword = document.getElementById('registerPassword');
	const confirmPassword = document.getElementById('confirmPassword');

	confirmPassword.addEventListener('input', function () {
	  if (registerPassword.value !== confirmPassword.value) {
	    confirmPassword.setCustomValidity('密碼不一致');
	  } else {
	    confirmPassword.setCustomValidity('');
	  }
	});

	// 密碼顯示/隱藏切換（按鈕文字同步）
	function togglePassword(inputId, btn) {
	  const input = document.getElementById(inputId);
	  const isVisible = input.type === 'text';
	  input.type = isVisible ? 'password' : 'text';
	  btn.textContent = isVisible ? '顯示' : '隱藏';
	}
	
	// 密碼複雜度檢查
	const passwordInput = document.getElementById('registerPassword');
	const passwordError = document.getElementById('passwordError');

	passwordInput.addEventListener('input', function () {
	    const value = this.value;

	    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

	    if (!pattern.test(value)) {
	    	passwordInput.classList.add('is-invalid');
		    passwordError.style.display = 'block';
		    passwordError.textContent = '密碼需包含：至少1個大寫、1個小寫、1個數字、1個特殊符號，且長度至少8位';
	  	}
	    else {
		    passwordInput.classList.remove('is-invalid');
		    passwordError.style.display = 'none';
	  	}
	});
	
	//提交時再次驗證密碼複雜度
	document.getElementById('signup').addEventListener('submit', function (e) {
	    const value = passwordInput.value;
	    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
	
	  	if (!pattern.test(value)) {
		    e.preventDefault(); // 阻止表單送出
		    passwordInput.classList.add('is-invalid');
		    passwordError.style.display = 'block';
		    passwordError.textContent = '密碼不符合複雜度規範，請重新輸入';
	  	}
	});
	
	/* m */		
	// (AJAX回傳)檢查Email是否已被註冊結果
	function check_result(data) {
		$('#check_ok').html(``);
		$('#check_error').html(``);
		switch (data.trim()) {
			case "success":
				$('#check_ok').html(`ok!`);
				break;
			case "false":
				$('#check_error').html(`此帳號已被註冊。`);
				break;
			default:
				alert(data.trim());
		}		
	}
	
	// (AJAX傳送)檢查Email是否已被註冊
	function check_bnd() {
	    $.ajax({	    	
	        url: "<%= url_checkemail %>", // 欲請求的API或網址
	        type: 'POST',
	        data: { // 欲傳遞的資料，使用JSON格式(鍵值對)
	            email: $('#registerEmail').val()
	        },
	        success: data => check_result(data), // success 代表請求成功(status:200)，data為回傳回來的資料，並送到自定義的function
	        error: err => console.log(err) // 若發生請求失敗，會執行console.log(err)
	    })
	}

	// (AJAX回傳)登入結果
	function login_result(data) {	    
	    switch (data.trim()) {
	        case "success":
	        	let branch = Cookies.get('branch');
	    		if ( branch !== undefined ) {
	        		window.location.href = "transition.jsp?meg=nonfinishedbooking";
	        	}
	        	else {
	        		window.location.href = "transition.jsp?meg=newlogin"; // 轉跳至過場頁面顯示alert
	        	}	    	    
	    	    break;
	        case "resend":
	            alert("您的E-mail尚未完成驗證");
	            let email = $('#loginEmail').val();
	            encoded = encodeURIComponent(email);
	            window.location.href = "transition.jsp?meg=resend&email="+encoded; // 轉跳至過場頁面顯示alert
	            break;
	        case "The password is incorrect.":
	            $('#loginPassword_error').html(`密碼錯誤`);
	            break;
	        case "The email does not exist.":
	            $('#loginEmail_error').html(`此E-mail尚未註冊`);
	            break;
	        default:
	        	alert(data.trim());
	      }	      
	}
	  
	// (AJAX傳送)登入
	function login_bnd() {    
	    $.ajax({
	        url: "<%= url_login %>", // 欲請求的API或網址
	        type: 'POST',
	        data: { // 欲傳遞的資料，使用JSON格式(鍵值對)
	                email: $('#loginEmail').val(),
	                password: $('#loginPassword').val()
	        },
	        success: data => login_result(data), // success 代表請求成功(status:200)，data為回傳回來的資料，並送到自定義的function
	        error: err => console.log(err) // 若發生請求失敗，會執行console.log(err)
	    })    
	}
	  
	// (AJAX回傳)註冊結果
	function signup_result(data) {	    
	    switch (data.trim()) {
	    	case "success":
	        	let email = $('#registerEmail').val();
	          	encoded = encodeURIComponent(email);
	          	window.location.href = "transition.jsp?meg=send&email="+encoded;  // 轉跳至過場頁面顯示alert
	          	break;
	        case "false":
	          	$('#check_error').html(`此帳號已被註冊。`);
	          	break;
	        default:
	        	alert(data.trim());
	    }
	}
	  
	// (AJAX傳送)註冊
	function signup_bnd() {
	    $.ajax({
	        url: "<%= url_signup %>", // 欲請求的API或網址
	        type: 'POST',
	        data: { // 欲傳遞的資料，使用JSON格式(鍵值對)
	            name: $('#registerUsername').val(),
	            email: $('#registerEmail').val(),
	            password: $('#registerPassword').val()
	        },
	        success: data => signup_result(data), // success 代表請求成功(status:200)，data為回傳回來的資料，並送到自定義的function
	        error: err => console.log(err) // 若發生請求失敗，會執行console.log(err)
	    })
	}
	
	// (AJAX回傳)忘記密碼
	function forgotpwd_result(data) {	    
	    switch (data.trim()) {
	    	case "false":
	        	let email = $('#forgotEmail').val();
	          	encoded = encodeURIComponent(email);
	          	window.location.href = "forgetpwd.jsp?email="+encoded;
	          	break;
	    	case "success":
	    		$('#forgetpwd_error').html(`此E-mail尚未註冊`);
	    		break;
	        default:
	        	alert(data.trim());
	    }
	}
	  
	// (AJAX傳送)忘記密碼
	function forgotpwd_bnd() {
	    $.ajax({
	        url: "<%= url_forgetpwd %>", // 欲請求的API或網址
	        type: 'POST',
	        data: { // 欲傳遞的資料，使用JSON格式(鍵值對)
	            email: $('#forgotEmail').val()
	        },
	        success: data => forgotpwd_result(data), // success 代表請求成功(status:200)，data為回傳回來的資料，並送到自定義的function
	        error: err => console.log(err) // 若發生請求失敗，會執行console.log(err)
	    })
	}	
	
	function showLoading() {
		$('#loadingSpinner').fadeIn(); // 顯示 loading 遮罩
		$('#login_button, #forgotpwd_button, #register_button, #checkemail').prop('disabled', true);  // 禁用按鈕避免連點
	}

	function hideLoading() {
		$('#loadingSpinner').fadeOut(); // 隱藏 loading 遮罩
		$('#login_button, #forgotpwd_button, #register_button, #checkemail').prop('disabled', false); // 啟用按鈕
	}
	
	$(document).ajaxStart(function () { // 所有ajax請求都執行
		showLoading();
	}).ajaxStop(function () {
		hideLoading();
	});
	
	// 當按下鍵盤任意鍵，清空錯誤訊息
	function key_down(e) {
		$('#loginPassword_error').html(``);
        $('#loginEmail_error').html(``);
        $('#check_error').html(``);
        $('#check_ok').html(``);
        $('#forgetpwd_error').html(``);
    }
	
	// 將key_down(e)綁定以下事件中(輸入框)
	$(document).ready( function () {		
	    $('#loginEmail, #loginPassword, #registerEmail, #forgotEmail').on('keydown', key_down);
	});
	
	// AJAX與後端溝通
	$('#checkemail').on("click", (event) => {
		
		const input = document.getElementById('registerEmail');
		const errorMsg = document.getElementById('registerEmailError');		
		
	    const pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
	    if (!pattern.test(input.value)) {
	    	input.classList.add('is-invalid');
	        errorMsg.style.display = 'block';
	        return;
	    }
	    else {
	    	input.classList.remove('is-invalid');
	        errorMsg.style.display = 'none';
	    }

		//  檢查通過，呼叫 AJAX 發送
		check_bnd();
				
	});
	
	// AJAX與後端溝通
	$('#login').on("submit", (event) => {
		event.preventDefault();
	
		const emailInput = document.getElementById('loginEmail');
		const emailError = document.getElementById('loginEmailError');
		const emailPattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
	
		if (!emailPattern.test(emailInput.value)) {
			emailInput.classList.add('is-invalid');
			emailError.style.display = 'block';
			return;
		} else {
			emailInput.classList.remove('is-invalid');
			emailError.style.display = 'none';
		}
		
		//  檢查通過，呼叫 AJAX 發送
		login_bnd();
	});
	
	// AJAX與後端溝通
	$('#signup').on("submit", (event) => {
		event.preventDefault();
	
		const emailInput = document.getElementById('registerEmail');
		const emailError = document.getElementById('registerEmailError');
		const emailPattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
		
		const passwordInput = document.getElementById('registerPassword');
		const passwordError = document.getElementById('passwordError');
		const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
		
		const registerPassword = document.getElementById('registerPassword');
		const confirmPassword = document.getElementById('confirmPassword');
	
		if ( !emailPattern.test(emailInput.value) ) {
			emailInput.classList.add('is-invalid');
			emailError.style.display = 'block';
			return;
		}
		else {
			emailInput.classList.remove('is-invalid');
			emailError.style.display = 'none';
		}
		
		if ( !pattern.test(passwordInput.value) ) {
	    	passwordInput.classList.add('is-invalid');
		    passwordError.style.display = 'block';
		    passwordError.textContent = '密碼需包含：至少1個大寫、1個小寫、1個數字、1個特殊符號，且長度至少8位';
		    return;
		}
		else {
		    passwordInput.classList.remove('is-invalid');
		    passwordError.style.display = 'none';			
		}
			
	    if (registerPassword.value !== confirmPassword.value) {
		    confirmPassword.setCustomValidity('密碼不一致');
		    return;
		}
	    else {
		    confirmPassword.setCustomValidity('');
		}
	    
		//  所有檢查通過，呼叫 AJAX 發送
		signup_bnd();
	});
	
	// AJAX與後端溝通
	$('#forgotpwd').on("submit", (event) => {
		event.preventDefault();
	
		const emailInput = document.getElementById('forgotEmail');
		const emailError = document.getElementById('forgotEmailError');
		const emailPattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
	
		if (!emailPattern.test(emailInput.value)) {
			emailInput.classList.add('is-invalid');
			emailError.style.display = 'block';
			return;
		} else {
			emailInput.classList.remove('is-invalid');
			emailError.style.display = 'none';
		}
		
		//  檢查通過，呼叫 AJAX 發送
		forgotpwd_bnd();
	});
</script>
</html>