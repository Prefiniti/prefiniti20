<div style="width:100%; height:100%;" class="__PREFINITI_DOCUMENT">
	<div style="padding:30px;">
	<form name="searchUsers" id="searchUsers" method="post" action="/socialnet/components/search_users_sub.cfm">
    <table width="100%" cellspacing="0" cellpadding="5">
        <tr>
            <td>Search By:</td>
            <td><p>
              <label>
                <input type="radio" name="search_field" value="longName" id="search_field_0" checked>
                Name Contains</label>
              <br>
              <label>
                <input type="radio" name="search_field" value="lastName" id="search_field_1">
                Last Name</label>
              <br>
              <label>
                <input type="radio" name="search_field" value="email" id="search_field_2">
                E-Mail Address</label>
              <br>
            </p></td>
        </tr>
        <tr>
          <td>Search For:</td>
          <td><input type="text" name="search_value" id="search_value"></td>
        </tr>
        <tr>
          <td colspan="2" align="center" style="padding:10px;"><input type="button" class="normalButton" name="submit" value="Begin Search" onclick="javascript:AjaxSubmitForm(AjaxGetElementReference('searchUsers'), '/socialnet/components/search_users_sub_20.cfm', 'UPFS_Target');"></td>
      </tr>      
    </table>
    </form>
	</div>
</div>