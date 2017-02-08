<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>List</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="/resources/css/slidebars.css">
<link rel="stylesheet" href="/resources/css/slidebars.atj.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- <link rel="stylesheet" href="/resources/css/jquery-ui.css"> -->
<style>
.viewList, #addList {
	width: 150px;
	height: 100%;
	margin: 5px;
	border: 1px solid grey;
	float: left;
}

.list {
	width: 150px;
	height: 100%;
	float: left;
}

.list_body {
	width: 90%;
}

.list_foot {
	width: 90%;
}

/* .list-card {
	width: 90%;
	border: 1px solid black;
	float: left;
} */

#content, #mainList {
	height: 100%;
	background-color: yellowgreen;
}

.g3-container {
	overflow-x: auto;
}

#content {
	height: 100%;
	padding-top: 100px;
}
.card-detail-main {
	float: left;
}

.card-detail-main > h1 {
	font-size: 50px;
	font-weight: bold;
}

.card-detail-main > h3 {
	font-size: 20px;
	font-weight: bold;
}



.card-detail-main > a:hover {
	text-decoration: underline;
	font-weight: bold;
}

.card-detail-sidebar {
	height: 600px;
	margin-top: 100px;
	float: right;
}

.card-detail-sidebar > button {
	text-align: left;
	width: 200px;
	height: 40px;
	font-weight: bold;
	font-size: 20px;
	background-color: white;
	border-radius: 10px 10px;
	outline: 0;
}

.card-detail-sidebar>button>span {
	margin-left: 10px;
	margin-bottom: 3px;
	color: black;
}

.cardView {
	overflow: hidden;
}
.btn-label {
	margin-right: 15px;
	margin-bottom: 5px;
}
.btn-attachment {
	margin-right: 15px;
	margin-bottom: 4px;
}
.btn-delete {
	margin-right: 15px;
	margin-bottom: 4px;
}

.submenu_hidden {
	display: none;
}

.submenu {
/* 
	top: 251px;
    left: 1285px;
    position: fixed;
    margin-top: 20px;
    background-color: white;
    width: 300px;
    border: 1px solid gray;
    border-radius: 5px;
     */
    position: relative;
    float: right;
    margin-top: 20px;
    border: 4px solid lightgray;
    border-radius: 5px;
    background-color: white;
}
.submenu:first-child {
	text-align: center;
}

.submenu > li:nth-child(2) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: red;
	width: 250px;
}

.submenu > li:nth-child(3) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: orange;
	width: 250px;
}

.submenu > li:nth-child(4) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: yellow;
	width: 250px;
}

.submenu > li:nth-child(5) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: green;
	width: 250px;
}

.submenu > li:nth-child(6) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: blue;
	width: 250px;
}

.submenu > li:nth-child(7) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: navy;
	width: 250px;
}

.submenu > li:nth-child(8) {
	margin-bottom: 5px;
	border-radius: 5px;
	background-color: violet;
	width: 250px;
}

</style>
<script>
	/*    document.onkeydown = refl;
	
	 function refl() {
	 if(event.keyCode == 116){
	 location.href='/main/board';
	 return false;
	 }
	 } 
	 */
	 
	var webSocket = new WebSocket('ws://211.183.8.14/socket');
	webSocket.onopen = function(event) {
		onOpen(event)

	};
	webSocket.onclose = function() {
		onClose()
	};
	webSocket.onerror = function(event) {
		onError(event)
	};
	webSocket.onmessage = function(event) {
		onMessage(event)

	};

	var b_num = '${b_num}';
	var numOfList = 0; // 전체 리스트 갯수
	window.onload = function() {
		
		
	      $('#mainList').sortable({
	         update : function(ev,ui) {
	        	 
	            var result = $('#mainList').sortable('toArray');
	            send(ev.target.innerHTML,'listMove','mainList');
	            var moveData=new Object();
	            var msg= '';
	            for(var i = 0 ; i < result.length; i++){
	                if(i<(result.length-1)){ 
	                  msg+= result[i]+',';
	               }else{
	                  msg+= result[i];
	               }
	                
	             }
	             
	             moveData = result;
	             
	             var data = JSON.stringify(moveData);
	             $.ajax({
	                url : '/main/moveList',
	                method : 'post',
	                data : {
	                   data : msg,
	                   length : result.length,
	                   bnum : b_num
	                }
	                
	             }).done();
	             
	         }

	      });
	      
	      $.ajax({
	         url : '/main/searchList',
	         method : 'post',
	         data : {
	            bnum : b_num
	         }
	      }).done(function(msg) {
	         
	         var listArr = JSON.parse(msg);
	         
	         $.each(listArr, function(i) {

	            var l_num = listArr[i].l_num;
	            var id = l_num;
	            var div = document.createElement('div');
	            div.id= 'list'+id;
	            div.className = 'list';
	            
	            var viewList = document.createElement('div');
	            viewList.id = id;
	            viewList.className= 'viewList';
	            
	            
	            var list_foot = document.createElement('div');
	            list_foot.className= 'list_foot';
	            
	            var addCardDiv = document.createElement('div');
	            addCardDiv.className = 'addCard';
	          
	            var aTag = document.createElement('a');
	            var createAText = document.createTextNode('addCard');
	            
	            
	            $.ajax({
	               url : '/main/searchCard',
	               method : 'post',
	               data : {
	                  bnum : b_num,
	                  lnum : l_num
	               }
	            }).done(function(msg) {
	               var cardArr = JSON.parse(msg);
	               
	               $.each(cardArr, function(i) {
	                  var cardDiv = document.createElement('div');
	                  var c_num= cardArr[i].c_num;
	                  
	                  cardDiv.id= c_num;
	                  cardDiv.className = 'list-card';
	                  cardDiv.onclick =function() {
	                     cardView(b_num,l_num,c_num)
	                  };
	                  
	                  var createCardText = document.createTextNode('card'+c_num );
	                  
	                  
	                  cardDiv.appendChild(createCardText);
	                  div.appendChild(cardDiv);
	                  
	                  

	               });
	               
	                
	               $('#list'+id).sortable({
	                  connectWith : '.list',
	                  update : function(ev,ui) {
	                     var result1 = $('#list'+id).sortable('toArray');
	                      var targetId= ev.target.id;
	                      var parentId = ev.toElement.parentElement.id;
	                      var cardArr= '';
	                      
	 		              send(ev.target.innerHTML,'cardMove','list'+id);
	                      if(targetId == parentId){
	                         
	                         for(var i = 0 ; i < result1.length; i++){
	                            if(i < (result1.length-1)){ 
	                               cardArr += result1[i]+',';
	                           }else{
	                              cardArr += result1[i];
	                           }
	                         
	                         }
	                      
	                         $.ajax({
	                            url:'/main/moveCard',
	                            method:'post',
	                            data:{
	                               
	                               bnum:b_num,
	                               lnum:id,
	                               cnum:ev.toElement.id,
	                               msg : cardArr,
	                               length : result1.length
	                            }
	                         
	                         }).done();
	                      }else{
	                      }
	                  }  
	               });
	               

	            });
	            
	            
	            
	            aTag.setAttribute('href', '#');
	            aTag.setAttribute('className', 'aaaa');
	            aTag.setAttribute('onClick', 'addCard(' + l_num
	                  + ',\'' + id + '\')');
	            aTag.appendChild(createAText);
	            
	            addCardDiv.appendChild(aTag); 
	            list_foot.appendChild(addCardDiv); 
	            
	            viewList.appendChild(div); 
	            viewList.appendChild(list_foot); 
	            
	            
	            
	            
	             document.getElementById('mainList').appendChild(viewList); 
	            

	         });
							
	         numOfList = $('.viewList').length; // 전체 viewList의 갯수 획득
							
	         console.log('length_onload: ' + numOfList);
						
	         setWidthOnload(numOfList); // Onload 시 전체 width 설정


	      });
	     
	};

	function setWidthOnload(num) {

		var currentWidth = $('.g3-container').width();
		var margin = $(".viewList").css("margin").replace('px', '');
		var borderWidth = $('.viewList').css("borderWidth").replace('px', '');
		var listWidth = $('.viewList').width() + margin * 2 + borderWidth * 2;
		var afterWidth = currentWidth + listWidth * (num - 10);

		if (((num + 1) * listWidth) > currentWidth) {

			$('.g3-container').css('width', afterWidth);
		}
	}

	function setWidthAddList(num) {
		var currentWidth = $('.g3-container').width();
		var margin = $(".viewList").css("margin").replace('px', '');
		var borderWidth = $('.viewList').css("borderWidth").replace('px', '');
		var listWidth = $('.viewList').width() + margin * 2 + borderWidth * 2;
		var afterWidth = currentWidth + listWidth;

		if (((num + 1) * listWidth) > currentWidth) {

			$('.g3-container').css('width', afterWidth);
		}

	}

	function addList() {
	      $.ajax({
	          method : 'post',
	          url : '/main/createList',
	          data : {
	             id : '${sessionScope.id}',
	             title : 'TestTitle',
	             bnum : b_num

	          }

	       }).done(function(msg) {
	            
	          var arrList = JSON.parse(msg);
	          var id = arrList.l_num;
	          var div = document.createElement('div');
	          div.id = 'list'+id;
	          div.className = 'list';

	                   
	          var viewList = document.createElement('div');
	          viewList.id = id;
	          viewList.className= 'viewList';
	          
	          
	          var list_foot = document.createElement('div');
	          list_foot.className= 'list_foot';

	          var addCardDiv = document.createElement('div');
	          addCardDiv.className = 'addCard';
	          
	          var aTag = document.createElement('a');
	          var createAText = document.createTextNode('addCard');
	          aTag.setAttribute('href', '#');
	          aTag.setAttribute('className', 'aaaa');
	          aTag.setAttribute('onClick', 'addCard(' + arrList.l_num
	                + ',\'' + id + '\')');

	          aTag.appendChild(createAText);

	          addCardDiv.appendChild(aTag);
	          
	          list_foot.appendChild(addCardDiv); 
	          
	          viewList.appendChild(div); 
	          viewList.appendChild(list_foot); 
	          
	          document.getElementById('mainList').appendChild(viewList);
	          
	          numOfList = $('.viewList').length;
	          setWidthAddList(numOfList);
	       
	          $('#list'+id).sortable({
	             connectWith : '.list',
	             update : function(ev,ui) {  
	             	
	                var result1 = $('#list'+id).sortable('toArray');
	                 var targetId= ev.target.id;
	                 var parentId = ev.toElement.parentElement.id;
	                 var cardArr= '';
	                 
	                 if(targetId == parentId){
	                 send(ev.target.innerHTML,'cardMove','list'+id);
	                    for(var i = 0 ; i < result1.length; i++){
	                       if(i < (result1.length-1)){ 
	                          cardArr += result1[i]+',';
	                      }else{
	                         cardArr += result1[i];
	                      }
	                    
	                    }
	                 
	                    $.ajax({
	                       url:'/main/moveCard',
	                       method:'post',
	                       data:{
	                          
	                          bnum:b_num,
	                          lnum:id,
	                          cnum:ev.toElement.id,
	                          msg : cardArr,
	                          length : result1.length
	                       }
	                    
	                    }).done();
	                 }
	             }  
	          });
	          
	          var listHtml = $('#mainList')[0].innerHTML;
	          send(listHtml,'listCreate', 'mainList');
	       
	       });
	      
	      
	}

	function addCard(l_num, id) {
		   $.ajax({
		         method : 'post',
		         url : '/main/createCard',
		         data : {
		            id : '${sessionScope.id}',
		            title : 'TestTitle',
		            bnum : b_num,
		            lnum : l_num

		         }

		      }).done(function(msg) {
		         var cardArr = JSON.parse(msg);

		         var newCard = document.createElement('div');
		         var c_num = cardArr.c_num;

		         newCard.id = c_num; 
		         newCard.className = 'list-card';
		         newCard.onclick = function() {
		        	 
		            cardView(b_num,l_num,c_num)
		            
		         };
		         var createCardText = document.createTextNode('card' + c_num);


		         newCard.appendChild(createCardText);
		         document.getElementById('list'+id).appendChild(newCard);
		         
		         var cardHtml = $('#list'+id)[0].innerHTML;
		          send(cardHtml,'cardCreate','list'+id);
		      });

	}

	function cardView(b_num, l_num, c_num) {
		  $.ajax({
		         method : 'post',
		         url : '/main/selectCardDetail',
		         data : {
		            bnum : b_num,
		            lnum : l_num,
		            cnum : c_num
		         }
		      }).done(function(msg) {
		    	  
				document.getElementById('boardNum').value = b_num;
				document.getElementById('listNum').value = l_num;
				document.getElementById('cardNum').value = c_num;
		        cardModal.style.display = "block";
		      });

	}
	function comment() {
		
		$.ajax({
	         method : 'post',
	         url : '/main/addComment',
	         data : {
	            bnum : $('#boardNum')[0].value,
	            lnum : $('#listNum')[0].value,
	            cnum : $('#cardNum')[0].value,
	            comment : $('#commentArea')[0].value
	            
	         }
	      }).done(function(msg) {
	    	  
	      });
		
	}

	function labelView() {
		$('.btn_label_toggle').next("div").toggleClass('submenu_hidden');
	}
	
</script>
</head>
<body>
	
	<!-- 상단바 -->
	<header id="header" class="clearfix">
		<a href="/main/board"><h1 style="top: -10px;">PROJECT 321</h1></a>
		<a href="#"class="btn_board"><span>Boards</span>
		</a>
		<form action="#" method="post" id="sch_main_wrap">
			<fieldset>
				<input type="text" name="sch_main" id="sch_main">
			</fieldset>
			<a href="#"><span class="btn_ico_sch"></span></a>
		</form>
		<a href="#" class="js-toggle-right-slidebar">☰</a>
	</header>
	<!-- 타이틀바 -->
	<div class="title-bar"><span class="title-main">List</span></div>
	
	<div id="content">
		<!-- 리스트 -->
		<div class="g3-container" canvas="container" align="right">
			<p></p>
			<div class="content">
				<div id="mainList" class="mainList"></div>
				<div id="addList" onclick="addList();">Create</div>
			</div>

		</div>
		<!-- 사이드메뉴 -->
		<div off-canvas="slidebar-2 right shift" style="z-index: 9999;">
			<ul class="menu">
				<a class="menu-icon" href="#"><i class="icon-reorder"></i></a>
				<ul class="side-menu">
					<h2 class="title">Menu</h2>
					<li class="link"><a href="#" class="link_tag1">Board</a></li>
					<li class="link"><a href="#" class="link_tag2" id="myBtn">History</a>
					</li>
					<li class="link"><a href="#" onclick="openChat();"
						class="link_tag3 js-close-right-slidebar">Chatting</a></li>
					<li class="link"><a href="#" class="link_tag4">File</a></li>
					<li class="link"><a href="#" class="link_tag5">Members</a></li>
				</ul>
			</ul>
		</div>
		<!-- 히스토리 -->
		<div id="myModal" class="modal">
			<div class="modal-content">
				<span id="hisClose" class="close">&times;</span>
				<p>
					Minsik Kim added slide menu study to to do listJan 16 at 3:59 PM<br>
					<br> MKMinsik Kim added menu view study to to do listJan 16 at
					3:42 PM<br> <br> MKMinsik Kim added event hadling study
					to to do listJan 16 at 3:42 PM<br> <br> MKMinsik Kim
					added to do list to this boardJan 16 at 3:42 PM<br> <br>
					MKMinsik Kim added ++ to listJan 16 at 3:23 PM<br> <br>
					MKMinsik Kim added list to this boardJan 16 at 10:38 AM<br> <br>
					MKMinsik Kim created this boardJan 16 at 10:37 AM<br> <br>
					Minsik Kim added slide menu study to to do listJan 16 at 3:59 PM<br>
					<br> MKMinsik Kim added menu view study to to do listJan 16 at
					3:42 PM<br> <br> MKMinsik Kim added event hadling study
					to to do listJan 16 at 3:42 PM<br> <br> MKMinsik Kim
					added to do list to this boardJan 16 at 3:42 PM<br> <br>
					MKMinsik Kim added ++ to listJan 16 at 3:23 PM<br> <br>
					MKMinsik Kim added list to this boardJan 16 at 10:38 AM<br> <br>
					MKMinsik Kim created this boardJan 16 at 10:37 AM<br> <br>
					Minsik Kim added slide menu study to to do listJan 16 at 3:59 PM<br>
					<br> MKMinsik Kim added menu view study to to do listJan 16 at
					3:42 PM<br> <br> MKMinsik Kim added event hadling study
					to to do listJan 16 at 3:42 PM<br> <br> MKMinsik Kim
					added to do list to this boardJan 16 at 3:42 PM<br> <br>
					MKMinsik Kim added ++ to listJan 16 at 3:23 PM<br> <br>
					MKMinsik Kim added list to this boardJan 16 at 10:38 AM<br> <br>
					MKMinsik Kim created this boardJan 16 at 10:37 AM<br> <br>
					Minsik Kim added slide menu study to to do listJan 16 at 3:59 PM<br>
					<br> MKMinsik Kim added menu view study to to do listJan 16 at
					3:42 PM<br> <br> MKMinsik Kim added event hadling study
					to to do listJan 16 at 3:42 PM<br> <br> MKMinsik Kim
					added to do list to this boardJan 16 at 3:42 PM<br> <br>
					MKMinsik Kim added ++ to listJan 16 at 3:23 PM<br> <br>
					MKMinsik Kim added list to this boardJan 16 at 10:38 AM<br> <br>
					MKMinsik Kim created this boardJan 16 at 10:37 AM<br> <br>
					Minsik Kim added slide menu study to to do listJan 16 at 3:59 PM<br>
					<br> MKMinsik Kim added menu view study to to do listJan 16 at
					3:42 PM<br> <br> MKMinsik Kim added event hadling study
					to to do listJan 16 at 3:42 PM<br> <br> MKMinsik Kim
					added to do list to this boardJan 16 at 3:42 PM<br> <br>
					MKMinsik Kim added ++ to listJan 16 at 3:23 PM<br> <br>
					MKMinsik Kim added list to this boardJan 16 at 10:38 AM<br> <br>
					MKMinsik Kim created this boardJan 16 at 10:37 AM<br> <br>
				</p>
			</div>
		</div>
		<div id="mySidenavChat" class="sidenav-chat" style="margin-top: 50px;">
			<a href="javascript:void(0)" class="closebtn" onclick="closeChat()">&times;</a>
			<jsp:include page="websocket.jsp" flush="false"></jsp:include>
		</div>
		<div id="cardModal" class="card-modal">
		<div class="modal-content">
			<p><span id="cardClose" class="close">&times;</span></p>
			<div id="cardView" class="cardView">
				<div class="card-detail-main" >
				
					<input type="hidden" id="boardNum">
					<input type="hidden" id="listNum">
					<input type="hidden" id="cardNum">
					
					<h1>card title</h1>
					<div id="descId">
<!-- 					<div class="card-desc"> -->
						<a href="#" class="	 glyphicon-pencil desc-tag" onclick="descPop();">&nbsp;description...</a>
					</div>
					<h3>Add Comment</h3>
						<textarea rows="10" cols="80" id="commentArea"></textarea>
						<input type="button" value="SAVE" onclick="comment();">
					<div>Comments Area(for Append)</div>
				</div>
				
				<div class="card-detail-sidebar">
					<button onclick="labelView();" class="btn-label-view dropdown">
						<span class="btn_label_toggle"><img alt="label" src="/resources/images/btn-label.png" width="20px" height="20px" class="btn-label">&nbsp;Label</span>
						<div class="submenu_hidden">
							<div class="submenu_main">
								<ul class="submenu">
								<span>labels</span>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<li>&nbsp;
									<span></span>
								</li>
								<a href="#">add color...</a>
							</ul>
							</div>
							
						</div>
						
					</button>
					
					
					<br><br>
					<button >
						<span><img alt="label" src="/resources/images/btn-attachment.png" width="20px" height="20px" class="btn-attachment">&nbsp;Attachment</span>
					</button>
					<br><br>
					<button >
						<span><img alt="label" src="/resources/images/btn-delete.png" width="20px" height="20px" class="btn-delete">&nbsp;Delete</span>
					</button>
					<br><br>
					<button >
						<span><img alt="label" src="/resources/images/btn-delete.png" width="20px" height="20px" class="btn-delete">&nbsp;empty1</span>
					</button>
					<br><br>
					<button >
						<span><img alt="label" src="/resources/images/btn-delete.png" width="20px" height="20px" class="btn-delete">&nbsp;empty2</span>
					</button>
					<br><br>
				</div>
			</div>
			
		</div>
	</div>

</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="/resources/js/jquery-ui.js"></script>
<script src="/resources/js/slidebars.js"></script>
<script src="/resources/js/slidebars.atj.js"></script>
<script src="/resources/js/sortable.atj.js"></script>
<script src="/resources/js/scripts.js"></script>

</html>