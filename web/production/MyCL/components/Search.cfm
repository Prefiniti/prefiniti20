<style type="text/css">
	.search td
	{
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: xx-small;
	
	}
</style>
	<div class="search">
	<form name="search" action="searchSub.cfm" method="post">
	<table  border="0" cellpadding="0" cellspacing="0">

	<tr>
	  <td>Look for:</td>
	  <td colspan="2"><input type="text" name="SearchValue"></td>
	  </tr>
	<tr>
		<td>In the following fields:</td>
		<td colspan="2"><p>
		  <label>
		    <input type="radio" name="SearchField" value="clsJobNumber" />
		    Job Number</label>
		  <br />
		  <label>
		    <input type="radio" name="SearchField" value="subdivision" checked/>
		    Subdivision</label>
		  <br />
		  <label>
		    <input type="radio" name="SearchField" value="address"/>
		    Address</label>
			<br />
		  <label>
		    <input type="radio" name="SearchField" value="section"/>
		    Section</label>
			<br />
		  <label>
		    <input type="radio" name="SearchField" value="township"/>
		    Township</label>
			<br />
		  <label>
		    <input type="radio" name="SearchField" value="range"/>
		    Range</label>
	    </p></td>
	</tr>
	<tr>
		<td>Criteria:</td>
		<td><p>
		  <label>
		    <input type="radio" name="SearchType" value="BeginsWith" />
		    Begins With</label><br />
		  
		  <label>
		    <input type="radio" name="SearchType" value="Contains" checked />
		    Contains</label>
			<br />
			
		</p></td>
	</tr>
	<tr>
	<td colspan="2" align="right"><input name="submit" type="submit" class="normalButton" value="Search Jobs" /></td>
	</tr>
	</table>
	</form>
	</div>