<!DOCTYPE HTML>

<html>
<head>
	<%@ page import="java.io.*,java.util.*" %>
	<%@ page contentType="text/html;charset=utf-8"%>

	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Random"%>


	<script src="jquery-3.6.0.min.js"></script>
	<script src="jquery.dataTables.min.css"></script>
	<script src="jquery.dataTables.min.js"></script>	



	<title>抽獎結果</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
	<script type="text/javascript">
 document.oncontextmenu = function(e) {

        return false ;
    }


    document.onkeydown = function(e) {
        var ev = window.event || e;
        var code = ev.keyCode || ev.which;
        if (code == 116) {
            ev.keyCode ? ev.keyCode = 0 : ev.which = 0;
            cancelBubble = true;

            if (e && e.preventDefault) e.preventDefault();
            else window.event.returnValue = false ;

            return false ;
        }
    }	

</script>
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

<%

String db_user="root"; 
String db_pwd="1234";
// mysql 帳號密碼
String db_database="test";
//資料庫都使用同一個
String sql="";


String printString="";
String act =request.getParameter("action");
String aid;
if(act.equals("add"))
{ 
	 //out.print("你所使用的是新增抽獎活動");
	 aid=request.getParameter("aid"); //取得活動編號
	 int[]num=new int[10]; //存十種獎項的人數設定
	 boolean isExist=false; //預防完全沒人數的活動
	 for(int i=1;i<11;i++)
	 {
	 	String temp;//數量
	 	temp=request.getParameter(i+"prize");
	 	if (temp.equals("")) num[i-1]=Integer.parseInt("0");
	 		else
	 		{
	 			num[i-1] = Integer.parseInt(temp);
			isExist=true;//至少有一個有人數的獎項
		} 
	}
	 if(isExist==false) response.sendRedirect("index.html"); //發起無意義抽獎活動 直接回首頁



	 //進行資料庫連線 以及執行sql指令
	 Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_database+"?user="+db_user+"&password="+db_pwd+"&useUnicode=true&characterEncoding=UTF-8");
	 Statement stmt = conn.createStatement(); 
	conn.setAutoCommit(false);//設為false,每次execute將不會立刻提交,而是等待commit();

	sql="";
	String whiteArr = request.getParameter("whiltelist");
	if (!whiteArr.equals(""))
	{ 
	 	String []whiltelist=whiteArr.split(","); //取白名單
	 	for(int i=0;i<whiltelist.length ;i++)
	 	{
			sql = "insert into whitelist(aid,wid) values("+"'"+aid+"','"+whiltelist[i]+"')"; //Index,活動id,獎項種類,獎項人數,抽獎狀態
			//INSERT INTO User(name) VALUES('Taliesin')
			stmt.executeUpdate(sql);
		}

		conn.commit();
	}







	sql="select count(id) AS count from activity";

	try
	{ 
		for(int i=0;i<10;i++)
		{
			if(num[i]!=0 ) // 如果該獎項沒有人數 就不要存
			{ 
				//sql = "insert into activity values("+(id+i+1)+",'"+aid+"',"+(i+1)+","+num[i]+",'N')"; //Index,活動id,獎項種類,獎項人數,抽獎狀態
				//sql = "insert into activity values('"+aid+"',"+(i+1)+","+num[i]+",'N')"; //Index,活動id,獎項種類,獎項人數,抽獎狀態
				sql = "insert into activity(aid,prizetype,num,finished) values('"+aid+"',"+(i+1)+","+num[i]+",'N')"; //Index,活動id,獎項種類,獎項人數,抽獎狀態
				stmt.executeUpdate(sql);
				//out.println("<p>"+sql); debug用
			}
		}

	}
	catch(Exception e)
	{
		out.print(e.toString());
	}
	conn.commit();
	//rs.close();

%>		
<script type="text/javascript">
	alert("已成功新增 #<%=aid%>抽獎活動!");
	window.location = 'index.html';
</script>
<%
}// if add


else if(act.equals("draw")){
		aid =request.getParameter("aid"); //取得活動編號
		int pnum =  Integer.parseInt(request.getParameter("num")) ; //取得此獎項人數
		int prizetype =Integer.parseInt(request.getParameter("prizetype")) ;//取得獎項


		// mysql 資料庫名稱
		Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db_database+"?user="+db_user+"&password="+db_pwd+"&useUnicode=true&characterEncoding=UTF-8");


		Statement stmt = conn.createStatement(); 

		sql="select count(aid) whiteNum from whitelist WHERE aid='"+aid+"'";

		ResultSet rs=stmt.executeQuery(sql);
		rs.next();
		int whiteNum=rs.getInt("whiteNum");//白名單人數 如果為0就是沒設定 抽取所有人
		if(whiteNum==0){

			sql="Select id,name From worker WHERE not Exists (select wid from history where (worker.id=history.wid) and  history.aid='";
			sql+=aid+"')  "; 
			sql+="Order By Rand() Limit "+pnum; //查詢活動名稱與建立時間(年月日 時間 星期)
		}
		else
		{//篩選白名單
			sql="Select id,name From worker WHERE not Exists (select wid from history where (worker.id=history.wid) and  history.aid='";
			sql+=aid+"') "; 
			sql+="and (Exists (select wid from whitelist where (worker.id=whitelist.wid) and  whitelist.aid='"; 
			sql+=aid+"') )"; 						
			sql+="Order By Rand() Limit "+pnum; //查詢活動名稱與建立時間(年月日 時間 星期)			

		}







		rs = stmt.executeQuery(sql); // sql查詢活動數量結果

		StringBuilder multiSql = new StringBuilder(); // 此方法比起字串直接+=還快很多 多條插入

		multiSql.append("insert into history(aid,wid,prize) values ");


		String wid,wname;
		StringBuilder printString2 = new StringBuilder(); // 此方法比起字串直接+=還快很多
		printString2.append("<div style='margin:100 auto' >");
		printString2.append("<h2  span style='font-size:1.75em;' id ='title'># "+ aid+"\t "+prizetype +"獎結果</h2> ");
		printString2.append("<table id='table_id' class='display'>  <thead><tr><th>工號</th><th>名子</th></tr></thead><tbody>");


		int size=0 ;

		// if(size==0){ //抽不到人 代表已經抽完了
		// 	sql="UPDATE activity SET finished='Y' WHERE (aid= '"+aid+"' ) and (prizetype="+prizetype+");"; //更新要先把安全模式關閉	
		// 	stmt.executeUpdate(sql); // 更新活動狀態 已抽完
		// 	response.sendRedirect("index.html"); // 已經抽完了 沒法抽出名單 
		// 	return;
		// }


		while(rs.next()){ 
			size++; // 確認是否有抽出人來
			wid=rs.getString("id");
			wname=rs.getString("name");
			multiSql.append("('");
			multiSql.append(aid);
			multiSql.append("','");
			multiSql.append(wid);
			multiSql.append("',");
			multiSql.append(prizetype);
			multiSql.append("),");			

			printString2.append("<tr><td>");
			printString2.append(wid);
			printString2.append("</td><td>");		
			printString2.append(wname);	
			printString2.append("</td></tr>");				
	
		}

		if(size!=0)
		{ // 還抽的到人才需要做insert

			multiSql.setLength(multiSql.length() - 1);
			multiSql.append(";");		
			stmt.executeUpdate(multiSql.toString()); // 
		}







		printString2.append("</div >");
		printString2.append("</tbody></table>");


		//sql="SET SQL_SAFE_UPDATES=0; "; //更新要先把安全模式關閉
		sql="UPDATE activity SET finished='Y' WHERE (aid= '"+aid+"' ) and (prizetype="+prizetype+");"; //更新要先把安全模式關閉
		//sql+="SET SQL_SAFE_UPDATES=1; "; //更新完畢把安全模式開啟		



		stmt.executeUpdate(sql); // 

		out.print(printString2.toString());//輸出html





		rs.close();
	%>



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
			$('#table_id').DataTable();
		} );
	</script>

	<%
}




//response.sendRedirect("index.html");








%>







</div>

<!-- Scripts -->
<script src="assets/js/browser.min.js"></script>
<script src="assets/js/breakpoints.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>