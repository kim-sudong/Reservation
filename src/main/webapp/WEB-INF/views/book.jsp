<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<h1 style='text-align:center; color:#003366'>예약관리</h1>
</head>
<style>
body{
 background-color: #fef0f6;
 }
table{
	border-collapse:collapse;
	border:1px solid black;
	margin:auto;
	
}
tr{
	/* border:1px solid black; */
}
#roomlist tbody td{
	border:1px solid black;
	background-color: #f7badd;
}
#roomlist thead tr{
	height:60px;
}
#lalist thead td{
	border:1px solid black;
	background-color: #f7badd;
}
td{
	text-align:center;
}
</style>
<body>
<a href='/'><h2>객실관리</h2></a>
<table  style='margin-top: 75px;'>
	<tr>
		<td style='vertical-align:top;'>
			<table id="roomlist" style='width:500px;'>
				<thead>
					<tr><td>숙박기간</td><td><input type=hidden id=roomid></td></tr>
					<tr><td><input type=date id=datein> ~</td><td><input type=date id=dateout></td></tr>
					<tr><td>객실종류</td><td><select id=type style='width:170px;'></select></td>
													<td><input type=button id=btnsu value=찾기></td></tr>
				</thead>
				<tbody>
					<tr><td>객실명</td><td>숙박가능인원</td><td>1박요금</td></tr>
				</tbody>
				<tfoot>
				
				</tfoot>
				
			</table>
		</td>
		
		
		<td>
			<table style='width:500px;height:650px;'>
				<tr><td>예약번호</td><td colspan="2"><input type=number id=id></td></tr>
				<tr><td>객실타입</td><td colspan="2"><input type=text id=latype readonly></td></tr>
				<tr><td>객실명</td><td colspan="2"><input type=text id=roomname readonly></td></tr>
				<tr><td>숙박기간</td><td><input type=text id=checkin readonly> ~</td><td><input type=text id=checkout readonly></td></tr>
				<tr><td>예약자명</td><td colspan="2"><input type=text id=name></td></tr>
				<tr><td>모바일</td><td colspan="2"><input type=text id=mobile></td></tr>
				<tr><td>총요금</td><td colspan="2"><input type=number id=price readonly> 원</td></tr>
				<tr><td>숙박인원</td><td colspan="2"><input type=number id=person > 명</td></tr>
				<tr><td colspan="3"><input type=button id=add value=등록>&nbsp;&nbsp;
									<input type=button id=reset value=비우기>&nbsp;&nbsp;
									<input type=button id=del value=삭제></td></tr>
				
			</table>
		</td>
			<td style='vertical-align:top;'>
			<table  id="lalist" style='width:700px;'>
				<thead>
					<tr><td>번호</td><td>숙박기간</td><td>객실명</td><td>예약자</td><td>모바일</td><td>숙박인원</td><td>숙박비</td></tr>
				</thead>
				<tbody>
				</tbody>
				
			</table>
		</td>
	</tr>
</table>


</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	loadtype();
	loadRlist();
})
.on('click','#btnsu',function(){
	clear();
/* 	let n = "";
	let checkin = ($('#datein').val());
	let checkout = ($('#dateout').val());
	
	let date1 = new Date($('#datein').val());
	let date2 = new Date($('#dateout').val());
	for (let i = 0; i<$('#lalist tbody tr').length; i++){ 
		let date = $('#lalist tbody tr').eq(i).find('td').eq(1).text();
		let check = date.split("~")
		//console.log(check[0],check[1]);
		let date3 = new Date(check[0]);
		let date4 = new Date(check[1]);
		console.log(date1,date2,date3,date4);
		if(date1>=date3 && date1<=date4 || date2>=date3 && date2<=date4){
			console.log($('#lalist tbody tr').eq(i).find('td').eq(2).text());
			 n = $('#lalist tbody tr').eq(i).find('td').eq(2).text();
			
			for(let z = 0; z<$('#roomlist tfoot tr').length; z++){
				let d = $('#roomlist tfoot tr').eq(z).find('td').eq(0).text();
					if(n==d){
						$('#roomlist tfoot tr').eq(z).remove();
					}
			}
		}
	}	 */
	let type = $('#type option:selected').text();
	console.log(type);
	let n = "";
	//let checkin = $('#datein').val();
	//let checkout = $('#dateout').val();
	
	let date1 = new Date($('#datein').val());
	let date2 = new Date($('#dateout').val());
	if($('#datein').val()=='' || $('#dateout').val()=='' || date1>=date2){
		alert('날짜를 확인해주세요');
		return false;
	}
	$.post('/getTlist',{type:type},function(data){
		console.log(data);
		$('#roomlist tfoot').empty();
		for( let x of data){
			let str ='<tr><td>'+x['name']+'</td><td>'+x['person']+'</td><td>'+x['price']+'</td></tr>';
			$('#roomlist tfoot').append(str);
			
		}
	},'json').done(function(){
		for (let i = 0; i<$('#lalist tbody tr').length; i++){ 
			let date = $('#lalist tbody tr').eq(i).find('td').eq(1).text();
			let check = date.split("~")
			//console.log(check[0],check[1]);
			let date3 = new Date(check[0]);
			let date4 = new Date(check[1]);
			console.log(date1,date2,date3,date4);
			if(date1>=date3 && date1<=date4 || date2>=date3 && date2<=date4){
				console.log($('#lalist tbody tr').eq(i).find('td').eq(2).text());
				 n = $('#lalist tbody tr').eq(i).find('td').eq(2).text();
				
				for(let z = 0; z<$('#roomlist tfoot tr').length; z++){
					let d = $('#roomlist tfoot tr').eq(z).find('td').eq(0).text();
						if(n==d){
							$('#roomlist tfoot tr').eq(z).remove();
						}
				}
			}
		}	
	})
})
.on('click','#roomlist tfoot tr',function(){
	clear()
	let roomname = $(this).find('td:eq(0)').text();
	let person = $(this).find('td:eq(1)').text();
	let price = $(this).find('td:eq(2)').text();
	let type = $('#type option:selected').text();
	let datein = $('#datein').val();
	let dateout = $('#dateout').val();
	
	let date1 = new Date(datein);
	let date2 = new Date(dateout);
	let date = date2.getTime() - date1.getTime();
	let days = date/(1000 * 3600 * 24);
	
	$.post('/getroomid',{roomname:roomname},function(data){
		$('#roomid').val(data);
	},'text')
	
	
	$('#latype').val(type);
	$('#checkin').val(datein);
	$('#checkout').val(dateout);
	$('#roomname').val(roomname);
	$('#price').val(days*price);
	$('#person').val(person);
	$('#person').attr('max',person);
})
.on('click','#add',function(){
	let roomid = $('#roomid').val();
	let id = $('#id').val();
	let latype = $('#latype').val();
	let checkin = $('#checkin').val();
	let checkout = $('#checkout').val();
	let roomname = $('#roomname').val();
	let price = $('#price').val();
	let person = $('#person').val();
	let name = $('#name').val();
	let mobile = $('#mobile').val();

	if(checkin=='' || checkout=='' ||latype=='' ||price=='' ||person=='' ||name=='' ||mobile=='' ||roomname=='' ){alert('빈 칸이 있는데?'); return false;}
	console.log(checkin,checkout,latype,'['+price+']','['+person+']',name,mobile,roomname,'['+id+']');
	
	if(id==''){
		$.post('/addlalist',{roomid:roomid,checkin:checkin,checkout:checkout,price:price,
							person:person,name:name,mobile:mobile},
			function(){
						loadRlist();
						clear();
			},'text')
	}
	else{
		console.log(checkin,checkout,latype,'['+price+']','['+person+']',name,mobile,roomname,'['+id+']');
		$.post('/updatelalist',{roomid:roomid,checkin:checkin,checkout:checkout,price:price,
							person:person,name:name,mobile:mobile,id:id},
		function(){
					loadRlist();
					clear();
		},'text')
		
	}
	
})
.on('click','#reset',function(){
	clear();
})
.on('click','#lalist tbody tr',function(){
	let id = $(this).find('td:eq(0)').text();
	let roomname = $(this).find('td:eq(2)').text();
	$.post('/RoomT',{id:id},function(data){
		$('#latype').val(data);
	},'text')
	$.post('/getroomid',{roomname:roomname},function(data){
		$('#roomid').val(data);
	},'text')
	
	let date = $(this).find('td:eq(1)').text();
	//let roomname = $(this).find('td:eq(2)').text();
	let name = $(this).find('td:eq(3)').text();
	let mobile = $(this).find('td:eq(4)').text();
	let price = $(this).find('td:eq(5)').text();
	let person = $(this).find('td:eq(6)').text();
	let check = date.split("~")
	
	
	$('#id').val(id);
	$('#latype').val();
	$('#roomname').val(roomname);
	$('#checkin').val(check[0]);
	$('#checkout').val(check[1]);
	$('#name').val(name);
	$('#mobile').val(mobile);
	$('#price').val(person);
	$('#person').val(price);
	
})
.on('click','#del',function(){
	let id = $('#id').val();
	$.post('/dellalist',{id:id},function(data){
		loadRlist();
		clear();
	},'text')
})
function clear(){
	$('#latype,#checkin,#checkout,#roomname,#price,#person,#name,#mobile,#id').val('');
}
function loadtype(){
		$.post('/getType',{},function(data){
			console.log(data);
			$('#type').empty();
			for( let x of data){
				let str ='<option value='+x['id']+'>'+x['roomname']+'</option>';
				$('#type').append(str);
			}
		},'json')
}
function loadRlist(){
	$.post('/getRlist',{},function(data){
		console.log(data);
		$('#lalist tbody').empty();
		for( let x of data){
			let str ='<tr><td>'+x['id']+'</td><td>'+x['checkin']+'~'+x['checkout']+'</td><td>'+x['roomname']+'</td><td>'+x['name']+
					'</td><td>'+x['mobile']+'</td><td>'+x['person']+'</td><td>'+x['price']+'</td></tr>';
			$('#lalist tbody').append(str);
		}
	},'json')
}
</script>
</html>