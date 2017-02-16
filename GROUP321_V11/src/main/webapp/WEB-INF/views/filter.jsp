<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>

<script>
   // 라벨 카드 필터
   function searchFilter() {
      var result = '%' + $('#FilterSearch').val() + '%';
      if ($('#FilterSearch').val() == '') {
         $('.mainList').html('');
         listSearch(b_num);
      } else {

         $.ajax({
            url : "/main/searchFilter",
            method : "post",
            dataType : "json",
            data : {
               b_num : b_num,
               result : result
            }
         }).done(function(msg) {
            $('#FilterSearch').val('');

            $('.list').html('');
            $.each(msg, function(i) {
               console.log(msg[i]);

               var cardDiv = document.createElement('div');
               var b_num = msg[i].b_num;
               var l_num = msg[i].l_num;
               var c_num = msg[i].c_num;

               cardDiv.id = c_num;
               cardDiv.className = 'list-card';
               cardDiv.onclick = function() {
                  cardView(b_num, l_num, c_num);
               };

               labelSet(b_num, l_num, c_num);

               // 카드 내부의 label div 생성!!!
               for (var j = 1; j <= 7; j++) {
                  var labelDiv = document.createElement('div');
                  labelDiv.id = 'labelDiv' + c_num + '_' + j;
                  cardDiv.append(labelDiv);
               }

               var createCardText = document.createTextNode(msg[i].title);

               cardDiv.appendChild(createCardText);

               $('#list' + l_num).append(cardDiv);
            });
         });
      }

   }

   $(function() {

      $('.check').click(function() {
         var labelOk = false;
         var result = '';
         var count = 0;
         $('.list').html('');
         $.each($('.check'), function(i) {
            if ($('.check')[i].checked) {
               labelOk = true;
               if (count == 0) {
                  result += $('.check')[i].value;
               } else {
                  result += '|' + $('.check')[i].value;

               }
               count++;

            }
         });

         $.ajax({
            url : "/main/searchLabel",
            method : "post",
            dataType : "json",
            data : {
               b_num : b_num,
               result : result
            }
         }).done(function(msg) {
            $.each(msg, function(i) {
               var cardDiv = document.createElement('div');
               var b_num = msg[i].b_num;
               var l_num = msg[i].l_num;
               var c_num = msg[i].c_num;

               cardDiv.id = c_num;
               cardDiv.className = 'list-card';
               cardDiv.onclick = function() {
                  cardView(b_num, l_num, c_num);
               };

               labelSet(b_num, l_num, c_num);

               // 카드 내부의 label div 생성!!!
               for (var j = 1; j <= 7; j++) {
                  var labelDiv = document.createElement('div');
                  labelDiv.id = 'labelDiv' + c_num + '_' + j;
                  cardDiv.append(labelDiv);
               }

               var createCardText = document.createTextNode(msg[i].title);

               cardDiv.appendChild(createCardText);

               $('#list' + l_num).append(cardDiv);
            });
         });
         console.log(result);
         if (!labelOk) {
            $('.mainList').html('');
            listSearch(b_num);
         }
      });
   });
</script>

<div id="searchFilter">
   <input type="text" id="FilterSearch" /> <input type="button" onclick="searchFilter();" value="검색">
</div>
<div id="searchLabel">
   <div class='filterDiv'>
      <input type="checkbox" id="check1" class="check" value="#CD3861">
      <li id="label1" class="labels">&nbsp;</li>
   </div>
   <div class='filterDiv'>
      <input type="checkbox" id="check2" class="check" value="#E56D29">
      <li id="label2" class="labels">&nbsp;</li>
   </div>
   <div class='filterDiv'>
      <input type="checkbox" id="check3" class="check" value="#FFE641">
      <li id="label3" class="labels">&nbsp;</li>
   </div>
   <div class='filterDiv'>
      <input type="checkbox" id="check4" class="check" value="#68D168">
      <li id="label4" class="labels">&nbsp;</li>
   </div>
   <div class='filterDiv'>
      <input type="checkbox" id="check5" class="check" value="#52E4DC">
      <li id="label5" class="labels">&nbsp;</li>
   </div>
   <div class='filterDiv'>
      <input type="checkbox" id="check6" class="check" value="#3296FF">
      <li id="label6" class="labels">&nbsp;</li>
   </div>
   <div class='filterDiv'>
      <input type="checkbox" id="check7" class="check" value="#6A5ACD">
      <li id="label7" class="labels">&nbsp;</li>
   </div>
</div>
