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
	  background-image: url('images/bg_1.jpg'); /* 替換成你的圖片路徑 */
	  background-size: cover;
	  background-position: center;
	  width: 100vw;
	  height: 100vh;
	  position: fixed;   /* <-- 加這一行才會蓋滿背景 */
	  top: 0;
	  left: 0;
	  z-index: 0
	}
	/* 加這段讓導覽列在最上層 */
	  nav.navbar {
	    position: relative;
	    z-index: 3;
	  }
	/* 新增這段，讓 container 在背景圖上層 */
	.container {
	  position: relative;
	  z-index: 2;
	}
	.semi-black-bg {
	  background-color: rgba(0, 0, 0, 0.6); /* 半透明黑色 */
	  border-radius: 1rem;
	  padding: 1.5rem;
	}
</style>
<body>
<%
	String url = request.getContextPath();
	String url_booking = url +"/booking";
	
	String email = (String)(session.getAttribute("email"));
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
		<%
		    String username = (String) session.getAttribute("name");
		    if (username != null) {
		%>
		    <li class="nav-item">
		        <a class="nav-link" href="<%= request.getContextPath() %>/logout">登出</a>
		    </li>
		<%
		    } else {
		%>
		    <li class="nav-item">
		        <a class="nav-link" href="member.jsp">加入會員</a>
		    </li>
		<%
		    }
		%>
          <li class="nav-item">
            <a class="nav-link" href="booking.jsp">餐廳訂位</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- 背景圖區塊 -->
  <div class="navbar-bg"></div>
  
	<div class="container py-5 text-white" style="max-width: 500px;">
	  <h2 class="mb-4">線上訂位</h2>
	
	  <form action="<%= url_booking %>" method="post" class="semi-black-bg text-white shadow">
	    <div class="mb-3">
	      <p class="text-warning fs-5 mb-0">※ 當天請電話訂位，線上僅提供隔日及之後訂位。</p>
	    </div>
	    <!-- 分店選擇 -->
	    <div class="mb-3">
	      <label for="branch" class="form-label">選擇分店</label>
	      <select class="form-select" id="branch" name="branch" required>
	        <option value="" disabled selected>請選擇分店</option>
	        <option value="永和仁愛店">永和仁愛店</option>
	        <option value="四號公園店">四號公園店</option>
	      </select>
	    </div>
	
	    <!-- 日期與時間 -->
	    <div class="mb-3">
	      <label for="datet" class="form-label">訂位時間</label>
	      <input type="date" class="form-control" id="date" name="date" required>
	    </div>

	    <!-- 時間選擇 -->
	    <div class="mb-3">
	      <label for="time" class="form-label">選擇時間</label>
	      <select class="form-select" id="time" name="time" required>
	        <option value="" disabled selected>請選擇時間</option>
	        <option value="11:30">11:30</option>
	        <option value="12:00">12:00</option>
	        <option value="11:30">12:30</option>
	        <option value="12:00">13:00</option>
	        <option value="11:30">13:30</option>
	        <option value="12:00">14:00</option>
	        <option value="11:30">14:30</option>
	        <option value="12:00">15:00</option>
	        <option value="11:30">15:30</option>
	        <option value="12:00">16:00</option>
	        <option value="11:30">16:30</option>
	        <option value="12:00">17:00</option>
	        <option value="11:30">17:30</option>
	        <option value="12:00">18:00</option>
	        <option value="11:30">18:30</option>
	        <option value="12:00">19:00</option>
	        <option value="11:30">19:30</option>
	        <option value="12:00">20:00</option>
	        <option value="11:30">20:30</option>
	        <option value="12:00">21:00</option>
	        <option value="11:30">21:30</option>
	      </select>
	    </div>
	
	    <!-- 人數 -->
	    <div class="mb-3">
	      <label for="people" class="form-label">人數</label>
	      <input type="number" class="form-control" id="people" name="people" min="1" max="20" required>
	    </div>
	
	    <!-- 備註 -->
	    <div class="mb-3">
	      <label for="note" class="form-label">備註</label>
	      <textarea class="form-control" id="note" name="note" rows="3" placeholder="例如：需要嬰兒座椅、靠窗座位等"></textarea>
	    </div>
	
	    <button type="submit" class="btn btn-warning w-100">送出訂位</button>
	  </form>
	</div>
	
	<!-- Loading Spinner --> <!-- m -->
	<div id="loadingSpinner" style="display: none; position:fixed; top:0; left:0; width:100vw; height:100vh; background-color: rgba(0,0,0,0.5); z-index:9999; justify-content:center; align-items:center;">
	  <div class="spinner-border text-warning" role="status" style="width: 3rem; height: 3rem;">
	    <span class="visually-hidden">Loading...</span>
	  </div>
	</div>


</body>
<Script>
	const dateInput = document.getElementById('date');
	const timeSelect = document.getElementById('time');
	
	// 計算明天日期
	const tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate() + 1);
	const minDate = tomorrow.toISOString().split('T')[0];
	
	dateInput.setAttribute('min', minDate);
	/*   // 設定最小日期為今天
	  const dateInput = document.getElementById('date');
	  const timeSelect = document.getElementById('time');
	
	  const today = new Date().toISOString().split('T')[0];
	  dateInput.setAttribute('min', today);
	
	  // 設定最小時段為現在
	  window.addEventListener('DOMContentLoaded', () => {
	    const select = document.getElementById('time');
	    const now = new Date();
	    const nowMinutes = now.getHours() * 60 + now.getMinutes();
	
	    for (const option of select.options) {
	      if (option.value) {
	        // option.value 格式是 "HH:mm"
	        const [hour, minute] = option.value.split(':').map(Number);
	        const optionMinutes = hour * 60 + minute;
	
	        // 已經過去的時間設 disabled
	        if (optionMinutes <= nowMinutes) {
	          option.disabled = true;
	        }
	      }
	    }
	  }); */

	let email = "<%= email %>";
	if ( email != "null" ) {
		let branch = Cookies.get('branch');
		if ( branch !== undefined ) {
			branch = decodeURIComponent(branch);
			$('#branch').val(branch);
			let date = decodeURIComponent(Cookies.get('date'));
			$('#date').val(date);
			let time = decodeURIComponent(Cookies.get('time'));
			$('#time').val(time);
			let people = decodeURIComponent(Cookies.get('people'));
			$('#people').val(people);
			let note = decodeURIComponent(Cookies.get('note'));
			if ( note == "None" ) {
				note = "";
			}
			$('#note').val(note);
		}
	}
	

	// 當表單送出時顯示 loading spinner
	$("form").on("submit", function () {
	  $("#loadingSpinner").css("display", "flex"); // 顯示 spinner
	});
</Script>
</html>