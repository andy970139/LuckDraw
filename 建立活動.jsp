<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="java.sql.*"%>
<html>
<head>

	<title>建立抽獎活動</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
	<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	<script src="assets/js/jquery.min.js"></script>
</head>

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
<body class="is-preload">
	<%@ page import="java.text.DecimalFormat" %>
	<%

//連接資料庫
	String db_user="root"; 
	String db_pwd="1234";
// mysql 帳號密碼
	String db_database="test";
// mysql 資料庫名稱
	Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_database+"?user="+db_user+"&password="+db_pwd+"&useUnicode=true&characterEncoding=UTF-8");
	Statement stmt = conn.createStatement(); 
	String sql="select count(DISTINCT aid) AS count from activity";

ResultSet rs = stmt.executeQuery(sql); // sql查詢活動數量結果
int num=0;
while(rs.next()){ 

	num=rs.getInt("count");
}
DecimalFormat df=new DecimalFormat("0000");

String sNum='A'+df.format(num+1);






rs.close();
%>


<!-- Wrapper -->
<div id="wrapper">

	<!-- Header -->
	<header id="header" style="padding-top: 30px;">
		<div class="inner">

			<!-- Logo -->
			<a href="index.html" class="logo">
				<span class="symbol"><img src="images/logo.svg" alt="" /></span><span class="title">LuckyDraw</span>
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
	<div id="main" >
		<div class="inner" >

			<section   >
				<h2 span style="font-size:2em;">建立抽獎活動(#<%=sNum%>)</h2>


				<form method="post" action="handle.jsp?action=add"> <!--以get方式作為傳入handle.jsp整合控制檔案指令 並以post的方式傳出活動相關內容  -->
					<table id="test">
						<thead>
							<tr>
								<th>獎項</th>
								<th>人數</th>
								<th>(若無此獎項請填 0)<td><input type="hidden" name="aid" value="<%=sNum%>" /></td></th>
							</tr>
						</thead>
						<tbody >

							<script type="text/javascript">


								for (var i = 10; i >0 ; i--) {
									　	var TestString='<tr><td>'+i+'獎 :</td> <td><input type="text" name="'+i+'prize" id=""  placeholder="0" /></td> <td></td></tr>';
									　	document.write(TestString);
								}


							</script>
							<tr>
								<td colspan="3">
									
									<textarea name="whiltelist"  placeholder="抽獎人員(請以','分開 如:w000001,w00002... 若無輸入默認全選)"></textarea>
									
								</td>
							</tr>

						</tbody>
						<tfoot>
							<tr>
								<td colspan="2"> 	
									<ul class="actions">
										<li><input type="submit" value="Send" class="primary" /></li>

									</ul>					
								</td>
								<td>				
									<input type="button" value="回首頁",class="primary" onclick="location.href='index.html';" >		
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
			</div>










		</section>

	</div>
</div>




</div>
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



</body>
</html>