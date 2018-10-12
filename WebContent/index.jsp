<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>  
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/easyui.css">
<link rel="stylesheet" type="text/css" href="css/icon.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">

$(function(){
	$('.item').draggable({
		revert:true,
		proxy:'clone',
		onStartDrag:function(){
			$(this).draggable('options').cursor = 'not-allowed';
			$(this).draggable('proxy').css('z-index',10);
		},
		onStopDrag:function(){
			$(this).draggable('options').cursor='move';
		}
	});
	$('.cart').droppable({
		onDragEnter:function(e,source){
			$(source).draggable('options').cursor='auto';
		},
		onDragLeave:function(e,source){
			$(source).draggable('options').cursor='not-allowed';
		},
		onDrop:function(e,source){
			var name = $(source).find('p:eq(0)').html();
			var price = $(source).find('p:eq(1)').html();
			addProduct(name, parseFloat(price.split('$')[1]));
		}
	});
	var data = {"total":0,"rows":[]};
	var totalCost = 0;
	function addProduct(name,price){
		function add(){
			for(var i=0; i<data.total; i++){
				var row = data.rows[i];
				if (row.name == name){
					row.quantity += 1;
					return;
				}
			}
			data.total += 1;
			data.rows.push({
				name:name,
				quantity:1,
				price:price
			});
		}
		add();
		totalCost += price;
		$('#cartcontent').datagrid('loadData', data);
		$('div.cart .total').html('Total: $'+totalCost);
	}
	
});
</script>
</head>
<body>
<div class="cart">
	<h1>Shopping Cart</h1>
	<table id="cartcontent" style="width:300px;height:auto;">
		<thead>
			<tr>
				<th field="name" width=140>Name</th>
				<th field="quantity" width=60 align="right">Quantity</th>
				<th field="price" width=60 align="right">Price</th>
			</tr>
		</thead>
	</table>
	<p class="total">Total: $0</p>
	<h2>Drop here to add to cart</h2>
</div>
<ul class="products">
	<li>
		<a href="#" class="item">
			<img src="images/shirt1.gif"/>
			<div>
				<p>Balloon</p>
				<p>Price:$25</p>
			</div>
		</a>
	</li>
	<li>
		<a href="#" class="item">
			<img src="images/shirt2.gif"/>
			<div>
				<p>Feeling</p>
				<p>Price:$25</p>
			</div>
		</a>
	</li>
	<!-- other products -->
</ul>

</body>
</html>