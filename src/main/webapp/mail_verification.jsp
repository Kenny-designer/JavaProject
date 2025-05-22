<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <title>Farina Pizza</title>
  <link rel="icon" href="images/farina_pizza.png" type="img/png">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

<body>
<%
	String email =  request.getParameter("email");
	String encoded = URLEncoder.encode(email, "UTF-8");
	
	String url = request.getContextPath();
	String url_verification = url +"/verification";
	String url_resend = url +"/resend"+"?email="+encoded;
%>
  <div class="navbar-bg"></div> <!-- 背景層 -->
	<div class="d-flex justify-content-center mt-5" style="z-index: 2; position: relative; margin-left: 5vw;">
	  <div class="container" style="max-width: 500px;">
	  
		<!-- 登入功能區塊 -->
		<div class="container my-5">
		
		  <!-- 分類按鈕（自訂切換） -->
		  <div class="row mb-4">
		    <div class="col-auto">
		      <button class="btn btn-outline-yellow me-2 text-white active" onclick="showAuthForm(this)">驗證信</button>
		    </div>
		  </div>
		  
		  <!-- 表單內容區塊 -->
		  <div class="bg-transparent text-white p-4 rounded shadow">
		    <!-- 驗證碼 -->
		    <div class="auth-form">
		      <form id="verification" method="post">
		        <div class="mb-3">
		          <label for="mailverification" class="form-label">請至您的E-mail收取驗證碼</label>
					<input type="text" class="form-control" id="mailverification" name="mailverification" required>
					<div id="verificationError" style="color: red;"></div>
					<input type="hidden" class="form-control" id="email" name="email">
		        </div>
		        
		        <button id="mailverification_button" type="submit" class="btn btn-warning w-100">確認</button>
		        <div>
		        	<a id="resendLink" href="<%= url_resend %>">沒有收到驗證信?重新發送驗證碼</a>
		        </div>
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
	// (AJAX回傳)驗證結果
	function verification_result(data) {	    
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
	        case "fail":
	          	$('#verificationError').html(`請輸入正確驗證碼`);
	          	break;
	        case "systemerror":
	        	alert(`伺服器錯誤，請點擊重新發送驗證信`);
	          	break;
	        default:
	        	alert(data.trim());
	    }
	}
	  
	// (AJAX傳送)驗證
	function verification() {
	    $.ajax({
	        url: "<%= url_verification %>", // 欲請求的API或網址
	        type: 'POST',
	        data: { // 欲傳遞的資料，使用JSON格式(鍵值對)
	            mailverification: $('#mailverification').val(),
	            email: $('#email').val()
	        },
	        success: data => verification_result(data), // success 代表請求成功(status:200)，data為回傳回來的資料，並送到自定義的function
	        error: err => console.log(err) // 若發生請求失敗，會執行console.log(err)
	    })
	}

	$('#email').val("<%= email %>");
	
	$('#verification').on("submit", (event) => {
		event.preventDefault();
		$('#verificationError').html(``);
		if ( $('#mailverification').val() == "" ) {			
			$('#verificationError').html("請輸入驗證碼");
		}
		else {
			verification();
		}
	});

	function showLoading() {
		$('#loadingSpinner').fadeIn(); // 顯示 loading 遮罩
		$('#mailverification_button').prop('disabled', true);  // 禁用按鈕避免連點
	}

	function hideLoading() {
		$('#loadingSpinner').fadeOut(); // 隱藏 loading 遮罩
		$('#mailverification_button').prop('disabled', false); // 啟用按鈕
	}
	
	$(document).ajaxStart(function () { // 所有ajax請求都執行
		showLoading();
	}).ajaxStop(function () {
		hideLoading();
	});
	
	$('#resendLink').on("click", function () {
		$('#loadingSpinner').css("display", "flex");
	});
	
	// 當按下鍵盤任意鍵，清空錯誤訊息
	function key_down(e) {
		$('#verificationError').html(``);
    }
	
	// 將key_down(e)綁定以下事件中(輸入框)
	$(document).ready( function () {		
	    $('#mailverification').on('keydown', key_down);
	});
</script>
</html>