
<style>
	p
	{
		font-size:medium;
	}
</style>

<div style="padding:30px;">
<h3 class="stdHeader">Business Account Free Trial</h3>

<div style="width:800px;">
<p>Prefiniti understands that not all businesses are created equal.  Your 30 day free trial will be created according to the unique needs of your business. After you submit your information a Prefiniti representative will contact you within one business day to discuss the specific needs of your business and set up your account. Your trial comes with no strings attached – no hidden fees or commitments to surprise you later. Absolutely no billing information is required at this time and your contact information will be used for the sole purpose of setting up your account.</p>
<!---
<p>We are glad you have decided to set up your business on The Prefiniti Network. Before you begin taking advantage of online ordering and our other business services, we need to ask you a few basic questions about your company.</p>

<cfoutput>
<p>We will not need any billing information unless you decide to continue using our services after your 30-day trial has passed. If you complete this sign up process today, your free trial will last until <strong>#DateFormat(DateAdd("d", 30, Now()), "mmmm d, yyyy")#</strong>.</p>
</cfoutput>--->
</div>

<form action="/business_register_sub.cfm" method="post">

<p>What is <strong>your company's name?</strong></p>
<p style="padding-left:30px;"><input type="text" name="company_name" /></p>

<p>What is <strong>your name?</strong></p>
<p style="padding-left:30px;"><input type="text" name="your_name" /></p>

<p>What is <strong>your e-mail address?</strong></p>
<p style="padding-left:30px;"><input type="text" name="your_email" /></p>

<p>What is <strong>your phone number?</strong></p>
<p style="padding-left:30px;"><input type="text" name="your_phone" /></p>

<p><strong>How many employees</strong> are in your company?</p>
<p style="padding-left:30px;"><input type="text" name="employee_count" /></p>

<p>Do you have a <strong>personal account</strong> on The Prefiniti Network?</p>
<p style="padding-left:30px;">	

  <label>
  <input type="radio" name="prefiniti_account" value="Yes" id="prefiniti_account_0">
    Yes</label>
  <br>
  <label>
  <input type="radio" name="prefiniti_account" value="No" id="prefiniti_account_1" checked>
    No</label>
  <br>

</p>

<p>If you <strong>do</strong> have a personal account on Prefiniti, what is your <strong>Prefiniti username</strong>?</p>
<p style="padding-left:30px;"><input type="text" name="prefiniti_username" /></p>

<input style="font-weight:bold;" type="submit" name="submit" class="normalButton" value="Begin Your Free Trial Now!">

</form>

</div>

<script language="javascript">
	hideSplash();
	shiftOpacity('plogo', 6000);	
</script>
