<!--
<wwafcomponent>My Comments</wwafcomponent>
<wwaficon>comments.png</wwaficon>
-->

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> My Comments</h3>
    </div>
</div>
<br />
<br />

<div id="cm">
<cfmodule template="/socialnet/components/read_comments.cfm" user_id="#url.calledByUser#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="100" load_to="cm">
</div>