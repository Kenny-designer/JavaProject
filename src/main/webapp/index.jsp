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
</head>
<style>
    /* 背景圖區塊樣式，使用 vw 和 vh 來設置大小 */
	.navbar-bg {
	  background-image: url('images/bg_3.jpg'); /* 替換成你的圖片路徑 */
	  background-size: cover;
	  background-position: center;
	  width: 100vw; /* 寬度為螢幕寬度 */
	  height: 100vh; /* 高度為螢幕高度的 50% */
	}

    /* 另一個區塊，顯示可調整的大小 */
	.banner-container {
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  gap: 30px; /* 控制間距 */
	  position: absolute;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  z-index: 1;
	  padding: 0 40px;
	  width: 100%; /* 讓容器佔滿寬度 */
	  max-width: 1200px; /* 限制整體最大寬，避免拉太寬 */
	}
	
	.content {
	  color: white;
	  background-color: rgba(0, 0, 0, 0.5);
	  padding: 30px;
	  border-radius: 10px;
	  text-align: left;
	  width: 500px; /* 改 max-width → width 固定寬 */
	  flex-shrink: 0; /* 不要被擠壓 */
	}
	
	.banner-img {
	  width: 460px;
	  height: auto;
	  border-radius: 10px;
	  flex-shrink: 0; /* 防止被壓縮 */
	}
</style>
<body>

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

<!-- 登出訊息 -->
<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
    <div class="alert alert-warning text-center" role="alert" style="position: fixed; top: 1rem; left: 50%; transform: translateX(-50%); z-index: 9999; width: auto; max-width: 90%;">
        <%= msg %>
    </div>
<%
        session.removeAttribute("msg"); // 顯示後清除
    }
%>

  <!-- 背景圖區塊 -->
  <div class="navbar-bg"></div>

  <!-- 可調整的區塊 -->
	<div class="banner-container">
	  <div class="content">
	    <h2>歡迎來到<br> Farina Pizza 法里娜披薩</h2>
	    <p>現點現烤，美味不等待！</p>
	  </div>
	  <img src="images/bg_1.png" alt="Pizza Image" class="banner-img">
	</div>

</body>
<script>
    setTimeout(() => {
        const alertBox = document.querySelector('.alert');
        if (alertBox) {
            alertBox.remove();
        }
    }, 3000); // 3秒後自動關閉提示
</script>

</html>