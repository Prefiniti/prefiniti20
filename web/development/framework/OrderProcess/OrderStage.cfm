<cfswitch expression="#Attributes.Stage#">
	<cfcase value="0">
	<div class="StageBlock">
		$<span style="font-size:8px;"><br />PMT</span>
	</div>
	</cfcase>
	<cfcase value="1">
	<div class="StageBlock">
		$<span style="font-size:8px;"><br />PMT</span>
	</div>
	</cfcase>
	<cfcase value="2">
	<div class="StageBlock">
		*<span style="font-size:8px;"><br />FUL</span>
	</div>
	</cfcase>
	<cfcase value="3">
	<div class="StageBlock">
		*<span style="font-size:8px;"><br />FUL</span>
	</div>
	</cfcase>
	<cfcase value="4">
	<div class="StageBlock">
		&gt;<span style="font-size:8px;"><br />DEL</span>
	</div>
	</cfcase>
</cfswitch>

<cfoutput><span class="OrdHeader">ORDER #Attributes.OrderID#</span></cfoutput>