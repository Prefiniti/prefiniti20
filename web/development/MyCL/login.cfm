<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>MyCL Login</title>
<link rel="stylesheet" href="../style/cls.css" />
<style type="text/css">
	.leftImg
	{
	display: inline;
	float: left;		
	padding-right: 20px;
	}
	.lb 
	{
	width:238px;
	border: 1px solid #CCCCCC;
	padding: 5px;
	}
</style>
</head>

<body>
	<div class="bodyWrapper">
	<table width="900">
		<tr>
		  <td width="600" valign="top">
				<div class="leftImg"><img src="images/workers.jpg" /></div>
				<h1>Welcome.</h1>

						<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Duis ligula lorem, consequat eget, tristique nec, auctor quis, purus. Vivamus ut sem. Fusce aliquam nunc vitae purus. Aenean viverra malesuada libero. Fusce ac quam. Donec neque. Nunc venenatis enim nec quam. Cras faucibus, justo vel accumsan aliquam, tellus dui fringilla quam, in condimentum augue lorem non tellus. Pellentesque id arcu non sem placerat iaculis. Curabitur posuere, pede vitae lacinia accumsan, enim nibh elementum orci, ut volutpat eros sapien nec sapien. Suspendisse neque arcu, ultrices commodo, pellentesque sit amet, ultricies ut, ipsum. Mauris et eros eget erat dapibus mollis. Mauris laoreet posuere odio. Nam ipsum ligula, ullamcorper eu, fringilla at, lacinia ut, augue. Nullam nunc.</p>
						<p>Sed et lectus in massa imperdiet tincidunt. Praesent neque tortor, sollicitudin non, euismod a, adipiscing a, est. Mauris diam metus, varius nec, faucibus at, faucibus sollicitudin, lectus. Nam posuere felis ac urna. Vestibulum tempor vestibulum urna. Nullam metus. Vivamus ac purus. Nullam interdum ullamcorper libero. Morbi vehicula imperdiet justo. Etiam mollis fringilla ante. Donec et dui. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Etiam mi libero, luctus nec, blandit ac, rutrum ac, lectus.</p></td>
			<td width="300" valign="top" align="right">
				<cfmodule template="components/BlockHeader.cfm" width="250" text="Log In">
				<cfmodule template="components/Login.cfm" width="250" success="#url.success#" siteid="MyCL">
				<br />
				<br />
				<cfmodule template="components/BlockHeader.cfm" width="250" text="Get Started Now">
				<div align="left" class="lb">
				<p>The power of MyCL is just a few clicks away! Register for an account today, and increase your productivity with:</p>
				<ul>
				<li>Online orders</li>
				<li>Project tracking</li>
				<li>Digital drawing delivery</li>
				</ul>
				<p>Registration is easy! Just go to the <a href="register.cfm">registration page</a> and supply the requested information.</p>
				</div>
			</td>
		</tr>
	</table>	
	
	</div>
	
</body>
</html>
