<cfinclude template="/socialnet/socialnet_udf.cfm">
<!--
<wwafcomponent>Friend Search</wwafcomponent>
-->

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Friend Search</h3>
        </div>
    </div>
    <br />
    <br />

<div style="padding-left:30px;">
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
          <td colspan="2" align="left"><input type="button" class="normalButton" name="submit" value="Search" onclick="javascript:AjaxSubmitForm(AjaxGetElementReference('searchUsers'), '/socialnet/components/search_users_sub.cfm', 'tcTarget'); hideDiv('gen_window_frame');"></td>
      </tr>      
    </table>
    </form>
</div>
                                            