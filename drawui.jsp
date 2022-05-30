<!DOCTYPE HTML>

<html>
<head>
	<%@ page import="java.io.*,java.util.*" %>
	<%@ page contentType="text/html;charset=utf-8"%>

	<%@ page import="java.sql.*"%>

	<% String aid="tt";

	String aTime="tt";
%>

<script src="jquery-3.6.0.min.js"></script>






<title id='title'>抽獎活動</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
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

		<!-- Footer -->
		<footer id="footer">
			<div class="inner">
				<%
				aid =request.getParameter("aid");

				String db_user="root"; 
				String db_pwd="1234";
// mysql 帳號密碼
				String db_database="test";
// mysql 資料庫名稱
				Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_database+"?user="+db_user+"&password="+db_pwd+"&useUnicode=true&characterEncoding=UTF-8");
				Statement stmt = conn.createStatement(); 
String sql="select prizetype,num,finished,DATE_FORMAT(date,'%Y-%c/%e %H:%i %a') time from activity where aid ='"+aid+"' ORDER BY prizetype DESC"; //查詢活動各獎項(降序)人數與建立時間(年月日 時間 星期)

ResultSet rs = stmt.executeQuery(sql); // sql查詢活動數量結果




%>

<h2  span style='font-size:1.75em;' id ='title'>#<%=aid%></h2>
<table id="table_id" class="display">  
	<thead>
		<tr>
			<th>獎項</th>
			<th>名額</th>

		</tr>
	</thead>
	<tbody>
		<%
		String aPrizetype,aNum;

String printString=""; //欲輸出的html字串
ArrayList<Integer> prizetypeList = new ArrayList<Integer>(); //獎項列表
ArrayList<Integer> numList = new ArrayList<Integer>(); //獎項人數列表
String isFinished="";

while(rs.next()){ 
	aPrizetype=rs.getString("prizetype");
	aNum=rs.getString("num");
	aTime=rs.getString("time");
	isFinished=rs.getString("finished");
	if(isFinished.equals("N"))
	{ //只抽還沒抽的獎項
		prizetypeList.add(Integer.parseInt(aPrizetype) );
		numList.add(Integer.parseInt(aNum) );
	}
	printString+="<tr><td>";
	printString+=aPrizetype+"獎</td>";
	printString+="<td>"+aNum+"人</td></tr>";	

}


	out.print(printString);//輸出html
	int counter=prizetypeList.size(); // 總共幾個獎項
	int index=0; //紀錄目前抽到幾獎
%>

<script>


	$(document).ready(function(){	
		$("#title").text("# <%=aid%>")

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

		
		var prizeArray = [];
		var numArray = [];
			var ii=0; //因為一開始就使用第0個了

			<%   for(int i=0; i<counter;i++  ){   %>
				prizeArray.push(<%=prizetypeList.get(i)%>);
				numArray.push(<%=numList.get(i)%>);
				<%  }   %>


				$("#title").text("#<%=aid%> (<%=aTime%>)");


    		if(typeof(prizeArray[0])!='undefined' ) $("#enter").text("抽出"+prizeArray[0]+"獎"); //若還有獎沒抽
    		else
    		{
    			$("#enter").text("已全數抽獎完畢")
				$("#enter").attr("disabled", "disabled"); //關閉按鈕
			}

			$("#prizetype").val(prizeArray[0]);
			$("#num").val(numArray[0]);
			$("#aid").val("<%=aid%>"); // 要傳出去的參數

			$("#enter").click(function(){


				if(ii< prizeArray.length){
					var fm=document.getElementById("fm");
					fm.submit();	

					ii++;
					if( ii<prizeArray.length )
					{ 
						$("#prizetype").val(prizeArray[ii]);
						$("#num").val(numArray[ii]);	
						$("#enter").text("抽出"+prizeArray[ii]+"獎");

					}
					else{
						$("#enter").text("已全數抽獎完畢")
						$("#enter").attr("disabled", "disabled"); //關閉按鈕
					}
				}
				
			});


		});
	</script>


</tbody>

<tfoot> 


	<tr> 
		<td><button id="enter" type="submit" class="primary">送出</button> </td>
		
		<td>
			<input type="button" value="回活動頁面",class="primary" onclick="location.href='activity.jsp';" >	
		</td>
	</tr>
</tfoot>

</table>

<form method="post" action="handle.jsp?action=draw" id="fm" target="_blank">
	<input type="hidden" id ='aid' name="aid" value='22'/>
	<input type="hidden" id ='num' name="num" value='22'/>			
	<input type="hidden" id ='prizetype' name="prizetype" value='22'/>

</form>

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