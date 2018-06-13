<!--
<wwafcomponent>Reply to Comment</wwafcomponent>
<wwafsidebar>sb_Home.cfm</wwafsidebar>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>pi-16x16.png</wwaficon>
-->


<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="goc" datasource="#session.DB_Core#">
	SELECT * FROM comments WHERE id=#url.cmt_id#
</cfquery>    

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
    <div style="float:left">
        <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Reply to Comment</h3>
    </div>
</div>
<br>
<br>

<cfoutput query="goc">
<div class="homeHeader"><img src="/graphics/comment.png" align="absmiddle"> Original Comment</div>
<div style="padding-left:30px;">
	<strong>From #getLongname(from_id)#</strong><br>
    <p>#body#</p>
</div>

<div class="homeHeader"><img src="/graphics/comment_add.png" align="absmiddle"> My Reply</div>
<div>
	<cfmodule template="/socialnet/components/post_comment.cfm" from_id="#url.calledByUser#" to_id="#from_id#">
</div>
</cfoutput>    