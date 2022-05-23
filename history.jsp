<!DOCTYPE HTML>

<html>
		<form method="post" action="historyui.jsp" id="fm">
	</form>
<head>
	<script src="jquery-3.6.0.min.js"></script>
<style>
#gotop {
    position: fixed;
    border-radius: 50px;
    right: 20px;
    bottom: 30px;
    padding: 10px 16px;
    font-size: 30px;
    background: rgba(228, 211, 211, 0.7);
    color: #FAFCFD;
    cursor: pointer;
    z-index: 1000;
}
</style>
<div id="gotop">top</div>

	<script>



		$(document).ready(function(){


			$("article>a").click(function(){
				var str=$(this).attr('id');
				$('#fm').append('<input type="hidden" name="aid" value='+str+' />');
				var fm=document.getElementById("fm");
				fm.submit();


			});
		});
	</script>









	<%@ page import="java.io.*,java.util.*" %>
	<%@ page contentType="text/html;charset=utf-8"%>

	<%@ page import="java.sql.*"%>
	<title>抽獎程式</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
	<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>

</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header" style="padding-top: 30px;">
			<div class="inner">

				<!-- Logo -->
				<a href="index.html" class="logo">
					<span class="symbol"><img src="images/logo.svg" alt="" /></span><span class="title">TSMC</span>
				</a>



			</div>
		</header>

		<!-- Menu -->
		<nav id="menu">
			<h2>Menu</h2>
			<ul>
				<li><a href="index.html">Home</a></li>
				<li><a href="generic.html">Ipsum veroeros</a></li>
				<li><a href="generic.html">Tempus etiam</a></li>
				<li><a href="generic.html">Consequat dolor</a></li>
				<li><a href="elements.html">Elements</a></li>
			</ul>
		</nav>

		<!-- Main -->
		<div id="main">
			<div class="inner">
				<header>
					<h1>抽獎活動<br />
					</h1>
					<p>本網頁依獎項抽出(小至大)、抽獎紀錄檢閱、建立抽獎活動 </p>
				</header>
				<section class="tiles">

<%

//連接資料庫
String db_user="root"; 
String db_pwd="1234";
// mysql 帳號密碼
String db_database="test";
// mysql 資料庫名稱
Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_database+"?user="+db_user+"&password="+db_pwd+"&useUnicode=true&characterEncoding=UTF-8");
Statement stmt = conn.createStatement(); 
String sql="select DISTINCT aid,finished ,DATE_FORMAT(date,'%Y-%c/%e %H:%i %a') time from activity GROUP BY aid"; //查詢活動名稱與建立時間(年月日 時間 星期)

ResultSet rs = stmt.executeQuery(sql); // sql查詢活動數量結果
String aid,aTime;
String printString=""; //欲輸出的html字串
while(rs.next()){ 
	aid=rs.getString("aid");
	aTime=rs.getString("time");
	printString+="  <article class='style5'  ><span class='image' ><img src='images/pic05.jpg'  /></span>";
	printString+="	<a id='"+aid+"'> ";// 路徑
	printString+="<h2 span style='font-size:1.75em;'  >#"+aid+"</h2>";	//活動名稱
	printString+=" 	<div class='content' ><p>於"+aTime+"\t<br>所建立的抽獎活動</p></div> "	;//活動資訊(建立時間)
	printString+=" </a></article>";		




}

out.print(printString);//輸出html
rs.close();
%>


</section>
</div>
</div>

<!-- Footer -->
<footer id="footer">
	<div class="inner">
		<section>
			<h2>Get in touch</h2>
			<form method="post" action="#">
				<div class="fields">
					<div class="field half">
						<input type="text" name="name" id="name" placeholder="Name" />
					</div>
					<div class="field half">
						<input type="email" name="email" id="email" placeholder="Email" />
					</div>
					<div class="field">
						<textarea name="message" id="message" placeholder="Message"></textarea>
					</div>
				</div>
				<ul class="actions">
					<li><input type="submit" value="Send" class="primary" /></li>
				</ul>
			</form>
		</section>
		<section>
			<h2>Follow</h2>
			<ul class="icons">
				<li><a href="#" class="icon brands style2 fa-twitter"><span class="label">Twitter</span></a></li>
				<li><a href="#" class="icon brands style2 fa-facebook-f"><span class="label">Facebook</span></a></li>
				<li><a href="#" class="icon brands style2 fa-instagram"><span class="label">Instagram</span></a></li>
				<li><a href="#" class="icon brands style2 fa-dribbble"><span class="label">Dribbble</span></a></li>
				<li><a href="#" class="icon brands style2 fa-github"><span class="label">GitHub</span></a></li>
				<li><a href="#" class="icon brands style2 fa-500px"><span class="label">500px</span></a></li>
				<li><a href="#" class="icon solid style2 fa-phone"><span class="label">Phone</span></a></li>
				<li><a href="#" class="icon solid style2 fa-envelope"><span class="label">Email</span></a></li>
			</ul>
		</section>

	</div>
</footer>

</div>

<!-- Scripts -->
<script type="text/javascript">



	$(document).ready( function () {
		$("#gotop").click(function(){
		    jQuery("html,body").animate({
		        scrollTop:0
		    },500);
		});
		$(window).scroll(function() {
		    if ( $(this).scrollTop() > 200){
		        $('#gotop').fadeIn("fast");
		    } else {
		        $('#gotop').stop().fadeOut("fast");
		    }
		});
	} );
</script>
<script src="assets/js/browser.min.js"></script>
<script src="assets/js/breakpoints.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>