<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page import="java.text.ParseException"%>
<%@page import="java.net.*"%>
<%@page import="org.json.simple.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title>음주운전 신고 사이트</title>
    
     <style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	</style>
    
    <!-- Bootstrap Core CSS -->
    <link href="assets/node_modules/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <!-- page css -->
    <link href="css/pages/google-vector-map.css" rel="stylesheet">
    <!-- You can change the theme colors from here -->
    <link href="css/colors/default.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body class="fix-header card-no-border fix-sidebar">
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String s_name = (String)session.getAttribute("__name");
	String s_uno = (String)session.getAttribute("__uno");
	
	String r_lat = "";
	String r_lng = "";
	
	String detailAddr = "";
%>

    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="loader">
            <div class="loader__figure"></div>
            <p class="loader__label">인하공전 캡스톤 디자인</p>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <header class="topbar">
            <nav class="navbar top-navbar navbar-expand-md navbar-light">
                <!-- ============================================================== -->
                <!-- Logo -->
                <!-- ============================================================== -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp">
                        <!-- Logo icon --><b>
                            <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                            <!-- Dark Logo icon -->
                            <img src="assets/images/logo-icon.png" alt="homepage" class="dark-logo" />
                            <!-- Light Logo icon -->
                            <img src="assets/images/logo-light-icon.png" alt="homepage" class="light-logo" />
                        </b>
                        <!--End Logo icon -->
                        <!-- Logo text --><span>
                         <!-- dark Logo text -->
                         <img src="assets/images/logo-text.png" alt="homepage" class="dark-logo" />
                         <!-- Light Logo text -->    
                         <img src="assets/images/logo-light-text.png" class="light-logo" alt="homepage" /></span> </a>
                </div>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <div class="navbar-collapse">
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item"> <a class="nav-link nav-toggler hidden-md-up waves-effect waves-dark" href="javascript:void(0)"><i class="fa fa-bars"></i></a> </li>
                        <!-- ============================================================== -->
                        <!-- Search -->
                        <!-- ============================================================== -->
                    </ul>
                    <!-- ============================================================== -->
                    <!-- User profile and search -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav my-lg-0">
                        <!-- ============================================================== -->
                        <!-- Profile -->
                        <!-- ============================================================== -->
                        <li class="nav-item dropdown u-pro">
                        	<a class="nav-link waves-effect waves-dark"><%= s_name %> 님</a>
                            <a class="nav-link dropdown-toggle waves-effect waves-dark profile-pic" href="index.html" aria-haspopup="true" aria-expanded="false"> <span class="hidden-md-down">로그아웃</span> </a>
                            <a class="nav-link dropdown-toggle waves-effect waves-dark profile-pic" href="User_Pw_Check.jsp" aria-haspopup="true" aria-expanded="false"> <span class="hidden-md-down">개인정보수정</span> </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <aside class="left-sidebar">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li> <a class="waves-effect waves-dark" href="index.jsp" aria-expanded="false"><i class="fa fa-tachometer"></i><span class="hide-menu">Dashboard</span></a>
                        </li>
                        <li> <a class="waves-effect waves-dark" href="pages-profile.html" aria-expanded="false"><i class="fa fa-user-circle-o"></i><span class="hide-menu">Profile</span></a>
                        </li>
                        <li> <a class="waves-effect waves-dark" href="table-basic.html" aria-expanded="false"><i class="fa fa-table"></i><span class="hide-menu">신고 통계 확인</span></a>
                        </li>
                        <li> <a class="waves-effect waves-dark" href="icon-fontawesome.html" aria-expanded="false"><i class="fa fa-smile-o"></i><span class="hide-menu">Icons</span></a>
                        </li>
                        <li> <a class="waves-effect waves-dark" href="Map.jsp" aria-expanded="false"><i class="fa fa-globe"></i><span class="hide-menu">신고 메시지 조회</span></a>
                        </li>
                        <li> <a class="waves-effect waves-dark" href="Report_Management.jsp" aria-expanded="false"><i class="fa fa-bookmark-o"></i><span class="hide-menu">신고 내역 관리</span></a>
                        </li>
                        <li> <a class="waves-effect waves-dark" href="pages-error-404.html" aria-expanded="false"><i class="fa fa-question-circle"></i><span class="hide-menu">404</span></a>
                        </li>
                    </ul>
                    <div class="text-center m-t-30">
                        <a href="https://wrappixel.com/templates/adminwrap/" class="btn waves-effect waves-light btn-info hidden-md-down"> Upgrade to Pro</a>
                    </div>
                </nav>
                <!-- End Sidebar navigation -->
            </div>
            <!-- End Sidebar scroll-->
        </aside>
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="row page-titles">
                    <div class="col-md-5 align-self-center">
                        <h3 class="text-themecolor">신고 메시지 조회</h3>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                            <li class="breadcrumb-item active">신고 메시지 조회</li>
                        </ol>
                    </div>
                    <div class="col-md-7 align-self-center">
                        <a href="https://wrappixel.com/templates/adminwrap/" class="btn waves-effect waves-light btn btn-info pull-right hidden-sm-down"> Upgrade to Pro</a>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Start Page Content -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            
                            
                            <%
								try{
									Class.forName("com.mysql.jdbc.Driver");
									
									String sql = "select * from report"
											+ " where rcheck = false";
							
									Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_C", "root", "1234");
									Statement stmt = conn.createStatement();
									ResultSet rs = stmt.executeQuery(sql);
									
									int i = 0;
									
									while(rs.next()) {
										%>
										<div class="card-body">
										<%
										r_lat = rs.getString("r_lat");
										r_lng = rs.getString("r_lng");
										
										
										//구글 Geocoding API 부분
										String apiURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
												+ r_lat + "," + r_lng + "&language=ko&key=AIzaSyC6HXFaISHIMHUEVB4Mlnt35APpFlJlZrY";
										
										
										StringBuffer jsonBuffer = new StringBuffer();
										String jsonString = new String();
										String buf;
										try {
											URL url = new URL(apiURL);
											URLConnection urlConn = url.openConnection();
											
											BufferedReader br = new BufferedReader(new InputStreamReader(
													urlConn.getInputStream(), "UTF-8"));
											while ((buf = br.readLine()) != null) {
												jsonString += buf;
											}
											
											JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
											JSONArray jArray = (JSONArray) jObj.get("results");
											jObj = (JSONObject) jArray.get(0);
											
											out.println("<h4>" + (String) jObj.get("formatted_address") + "</h4>");
											detailAddr = (String) jObj.get("formatted_address");
										}catch(Exception e) {
											System.out.println("Error reading JSON string:"+ e.toString());
										}
										//////////////////////////
										
										
										String r_message = rs.getString("rme");
							%>
<h4 class="card-title"> 좌표 : <%= r_lat%>, <%= r_lng%> 신고메시지 : <%= r_message %></h4>
<!-- 지도 들어가는 부분~~~ 0a8eac823d3ebfada476ace3d342d63f 마커 표시하고싶어 -->
<div class="map_wrap">
    <div id="map_<%= i %>" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	<div class="hAddr">
        <span class="title">신고지역위치</span>
        <span class="innerHTML"><%= detailAddr %></span>
        <span id="centerAddr"></span>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0a8eac823d3ebfada476ace3d342d63f&libraries=services"></script>
<script>
var r_lat = "<%=r_lat%>";
var r_lng = "<%=r_lng%>";
var detailAddr = "<%=detailAddr%>"

var mapContainer = document.getElementById('map_<%= i %>'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(r_lat, r_lng), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
    
//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(r_lat, r_lng); 

// 마커를 생성합니다
marker.setPosition(markerPosition);
marker.setMap(map);
infowindow.setContent(detailAddr);
infowindow.open(map, marker);

</script>
<!--  지도 끝 -->	
		
<%			
			//지도를 여기에 넣어야 하나?
			//out.println("<h4 style='text-align:right'>좌표 : " + r_lat + ", " + r_lng + " / 메시지 : " + r_message + "</h4>");
			i++;
			%>
			</div>
			<%
		}
		
		
		
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e) {
		response.sendRedirect("Error.jsp");
		e.printStackTrace();
	}
%>
                            
                                
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End PAge Content -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
                2020 인하공전 컴퓨터시스템과
            </footer>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="assets/node_modules/jquery/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/node_modules/bootstrap/js/popper.min.js"></script>
    <script src="assets/node_modules/bootstrap/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="js/perfect-scrollbar.jquery.min.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="js/custom.min.js"></script>
    <!-- google maps api -->
    <script src="https://maps.google.com/maps/api/js?key=AIzaSyCUBL-6KdclGJ2a_UpmB2LXvq7VOcPT7K4&sensor=true"></script>
    <script src="assets/node_modules/gmaps/gmaps.min.js"></script>
    <script src="assets/node_modules/gmaps/jquery.gmaps.js"></script>
</body>

</html>