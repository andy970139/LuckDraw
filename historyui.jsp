<!DOCTYPE HTML>

<html>

<head>
	<script src="jquery-3.6.0.min.js"></script>
	<%@ page import="java.io.*,java.util.*" %>
	<%@ page contentType="text/html;charset=utf-8"%>

	<%@ page import="java.sql.*"%>

	<% String aid="";

	String aTime="";
%>




<%@ page import="java.io.*,java.util.*" %>
<%@ page contentType="text/html;charset=utf-8"%>

<%@ page import="java.sql.*"%>
<title>抽獎程式</title>
<meta charset="utf-8" />	
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
<script src="jquery-3.6.0.min.js"></script>
<script src="jquery.dataTables.min.css"></script>
<script src="jquery.dataTables.min.js"></script>
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
		<div id="main">
			<div class="inner">
				<header>
					<h1 id="title" >#<%=aid%>抽獎結果<br />
					</h1>
					<p id='content'>本網頁依獎項抽出(小至大)、抽獎紀錄檢閱、建立抽獎活動 </p>
				</header>


				<%
				aid =request.getParameter("aid");

				String db_user="root"; 
				String db_pwd="1234";
// mysql 帳號密碼
				String db_database="test";
// mysql 資料庫名稱
				Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_database+"?user="+db_user+"&password="+db_pwd+"&useUnicode=true&characterEncoding=UTF-8");
				Statement stmt = conn.createStatement(); 
				stmt.setFetchSize(20000);

				String sql="select DATE_FORMAT(date,'%Y-%c/%e %H:%i %a') time from activity  where aid='"+aid+"'"; //查詢活動名稱與建立時間(年月日 時間 星期)


				ResultSet rs = stmt.executeQuery(sql); // sql查詢活動數量結果


				rs.next();

				aTime=rs.getString("time");;


	

				sql="select wid,prize,worker.name, DATE_FORMAT(timestamp,'%Y-%c/%e %H:%i %a') time from history,worker where worker.id=history.wid ";
				sql+="and history.aid='"+aid+"'" ;




				rs = stmt.executeQuery(sql); // sql查詢活動數量結果


				StringBuilder printString2 = new StringBuilder(); // 此方法比起字串直接+=還快很多	
				printString2.append("<table id='table_id' class='display'><thead><tr><th>工號</th><th>名子</th><th>獎項</th><th>中獎時間</th></tr></thead><tbody>");

				String wid,prizeType,wname,drawTime;

				while(rs.next()){ 
					wid=rs.getString("wid");
					prizeType=rs.getString("prize");					
					wname=rs.getString("name");
					drawTime=rs.getString("time");		

					printString2.append("<tr><td>");
					printString2.append(wid);
					printString2.append("</td><td>");		
					printString2.append(wname);	
					printString2.append("</td><td>");		
					printString2.append(prizeType);	
					printString2.append("</td><td>");			
					printString2.append(drawTime);	
					printString2.append("</td></tr>");				

				}
				printString2.append("</tbody>");












				out.print(printString2.toString());//輸出html


				rs.close();			
			%>



			<tfoot> 


				<tr> 
					<td></td><td></td><td></td>
					<td>
						<!-- 將按鍵放在最右邊 -->
						<input type="button" value="回紀錄頁面",class="primary" onclick="location.href='history.jsp';" >	
					</td>
				</tr>
			</tfoot>
		</table>
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


				$('#title').text("#<%=aid%> 抽獎結果")
				$('#content').html("抽獎活動建立時間: <%=aTime%> <br>以下是抽獎結果，可以自行根據工號、員工名、獎項進行查詢。")		
				$('#table_id').DataTable({
					            deferRender:    true,

            scrollCollapse: true,
            scroller:       true
				});
			} );
		</script>

	</div>
</div>

<!-- Footer -->
<footer id="footer">
	<div class="inner">
		<section>
			<h2>Contact</h2>
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

<script src="assets/js/browser.min.js"></script>
<script src="assets/js/breakpoints.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>