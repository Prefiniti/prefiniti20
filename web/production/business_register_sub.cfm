<style>
	p
	{
		font-size:medium;
	}
</style>

<cfoutput>
<cfmail from="#form.your_email#" to="anthony@prefiniti.com; john@prefiniti.com" subject="BUSINESS ACCOUNT REQUEST" type="html">

	<h1>Business Account Request</h1>
    
    <p><strong>Business Name:</strong>  #form.company_name#</p>
    
    <p><strong>Requestor Name:</strong>  #form.your_name#</p>
    
    <p><strong>Requestor E-Mail:</strong> <a href="mailto:#form.your_email#">#form.your_email#</a></p>
    
    <p><strong>Requestor Phone Number:</strong> #form.your_phone#</p>
    
    <p><strong>Employees in Company:</strong> #form.employee_count#</p>
    
    <cfif form.prefiniti_account EQ "Yes">
    	<p>The requestor has a Prefiniti account under the username #form.prefiniti_username#</p>
	<cfelse>
    	<p>The requestor does not have a Prefiniti account</p>
	</cfif>                

</cfmail>
</cfoutput>

<script language="javascript">
	shiftOpacity('plogo', 6000);	
</script>
<br />
<br />

<table width="800">
<tr>
<td align="center">
	<div style="width:450px; border:1px solid #efefef; padding:50px;">
    	<h3 class="stdHeader">Thank You</h3>
        
        <p>Your information has been sent to us. We will personally contact you by the end of the <strong>next business day</strong> at the latest to complete the setup process and begin your 30-day free trial.</p> 
        
        <p>The free trial period will not begin counting down until after we have contacted you and completed the setup process.</p>
        
        <cfif form.prefiniti_account EQ "No">
			<p>Why not <a href="/appBase.cfm?contentBar=/authentication/components/register.cfm">set up your Personal Account now</a> and begin exploring our social networking features?</p>
            
            <p>Personal accounts are <strong>always free</strong>, even if you decide to cancel your business account after the 30-day trial has expired, and you will be using your personal account to log into The Prefiniti Network for both personal and business use.</p>
		</cfif>
		
        <p><a href="/default.cfm">Prefiniti Home</a></p>
	</div>        
	</td>
    </tr>
    </table>    
    
<script>
	hideSplash();
</script>	