<html>
<head>
	<title>Prefiniti - Add Payment Profile</title>
<style>
	body {
		margin:0px;
		padding:0px;
		font-family:Verdana, Geneva, sans-serif;
		font-size:x-small;
	}
	
	td {
		font-family:Verdana, Geneva, sans-serif;
		font-size:x-small;
	}
</style>
</head>
    
<body>
<cfmodule template="/Framework/CoreSystem/Security/Resources/PCheckSession.cfm" HP_SessionKey="#URL.HP_SessionKey#">


<div style="width:100%; padding-top:10px;">
	<h2>Add Payment Profile</h2>
</div>

<cfparam name="ErrProfileName" default="">
<cfparam name="ErrCardType" default="">
<cfparam name="ErrNameOnCard" default="">
<cfparam name="ErrCardNumber" default="">
<cfparam name="ErrExpirationDate" default="">
<cfparam name="ErrCVV" default="">
<cfparam name="ErrZIP" default="">

<cfparam name="ErrorCount" default="">
<cfset ErrorCount = 0>

<cfif IsDefined("Form.Submit")>   <!--- validate card info --->

    <cfif Len(Trim(Form.profile_name)) EQ 0>
    	<cfset ErrProfileName = "* You must choose a profile name.<br>">
        <cfset ErrorCount = ErrorCount + 1>
    </cfif>
    
    <cfif Len(Trim(Form.profile_name)) GE 255>
    	<cfset ErrProfileName = "* Profile name must be 255 characters or less.<br>">
        <cfset ErrorCount = ErrorCount + 1>
    </cfif>
    
    <cfif NOT IsDefined("Form.card_type")>
    	<cfset ErrCardType = "* You must select a card type.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>
    
    <cfif Len(Trim(Form.name_on_card)) EQ 0>        
		<cfset ErrNameOnCard = "* You must enter your name as it appears on your credit card.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>
    
    <cfif Len(Trim(Form.name_on_card)) GE 255>        
		<cfset ErrNameOnCard = "* Name must be 255 characters or less.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>

	<cfif Len(Trim(Form.card_number)) NEQ 16>        
		<cfset ErrCardNumber = "* Card number must be exactly 16 digits.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>
    
    <cfif NOT IsNumeric(Trim(Form.card_number))>
    	<cfset ErrCardNumber = "* Card number must contain only numeric digits.<br>">
        <cfset ErrorCount = ErrorCount + 1>
    </cfif>
    
    <cfif NOT IsDate(Trim(Form.expiration_date))>
    	<cfset ErrExpirationDate = "* You must enter a valid expiration date.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>
    
    <cfif Len(Trim(Form.cvv)) NEQ 3>
    	<cfset ErrCVV = "* CVV number must be exactly 3 digits.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>
    
    <cfif Len(Trim(Form.zip)) NEQ 5>
    	<cfset ErrZIP = "* ZIP code must be exactly 5 digits.<br>">
        <cfset ErrorCount = ErrorCount + 1>
	</cfif>
                       
</cfif>

<cfif ErrorCount EQ 0>
	<cfif IsDefined("Form.Submit")>
       	
        <cftry>
            <cfquery name="CreatePaymentProfile" datasource="#Session.DB_Core#">
                INSERT INTO payment_profiles
                    (user_id,
                    card_number,
                    expiration_date,
                    name_on_card,
                    cvv,
                    profile_name,
                    card_type,
                    credit_card,
                    billing_zip)
                VALUES
                    (#URL.UserID#,                
                    '#Form.card_number#',
                    #CreateODBCDate(Form.expiration_date)#,
                    '#UCase(Replace(Form.name_on_card, ".", ""))#',
                    '#Form.cvv#',
                    '#Form.profile_name#',
                    '#Form.card_type#',
                    1,
                    '#Form.zip#')
            </cfquery>                                
            
            <cfoutput>
            	<div style="padding:5px;">
                
                <blockquote>
                <p style="color:##2957A2; font-weight:bold; margin-bottom:20px;">#Form.profile_name# <span style="font-weight:lighter;">(#Form.card_type#)</span></p>
                
                <p><strong>Card number:</strong> ****-****-****-#Right(Form.card_number, 4)#</p>
                <p><strong>Expiration date:</strong> #DateFormat(Form.expiration_date, "mm/yyyy")#</p>
                <p><strong>CVV number:</strong> #Form.cvv#</p>
                <p><strong>Name on card:</strong> #UCase(Replace(Form.name_on_card, ".", ""))#</p>
                
                <div style="border:1px solid black; padding:10px;">
                <p><strong style="color:green; font-weight:bold;"><img src="/graphics/disk.png" align="absmiddle" /> Payment profile saved.</strong></p>
                </div>
                </blockquote>
                </div>
                
                <div align="center" style="width:100%;"><input type="button" value="Return to Prefiniti" onClick="window.close();" /></div>
            </cfoutput>
		<cfcatch type="database">
        <cfoutput>
        	#cfcatch.Detail#
		</cfoutput>            
        </cfcatch>
        </cftry>            
        
        <cfabort>
    </cfif>
<cfelse>
	<div style="background-color:#2957A2; border-color:black; margin:10px; padding:5px; color:white;">
    	<cfoutput>
        	There were <strong>#ErrorCount# errors</strong> in your submission.<br /><br />Please correct the erroneous fields (marked by <strong style="color:red;">*</strong>) and try again.
        </cfoutput>
    </div>    
</cfif>

<cfoutput>
<div style="font-size:small; margin-left:20px;">
<form name="NewPP" method="post" action="/product_ordering/AddPaymentProfile.cfm?HP_SessionKey=#URL.HP_SessionKey#&UserID=#URL.UserID#">
	<table width="500" border="0" cellpadding="3" cellspacing="0">
    	<tr>
        	<td width="200">
            	<strong>Profile Name:</strong><br /><br /> 
                
                (For example, "My Visa")
            </td>
            <td>
            	<span style="color:red;">#ErrProfileName#</span>
            	<input  type="text" 
                		name="profile_name" 
						<cfif IsDefined("Form.profile_name")>
                        	value="#Form.profile_name#"
                        </cfif> />
            </td>
        </tr>
        <tr>
        	<td style="background-color:##EFEFEF;"><strong>Card Type:</strong></td>
            <td style="background-color:##EFEFEF;">
            
            <span style="color:red;">#ErrCardType#</span>
            <p>
              <label>
                <input type="radio" name="card_type" value="Visa" id="card_type_0"
                <cfif IsDefined("Form.card_type")>
                	<cfif Form.card_type EQ "Visa">
                    	checked
                    </cfif>
                </cfif> />
                <img src="/graphics/ccico/Regular/48x48/visa.png" alt="Visa" align="absmiddle" /></label>
              <br />
              <label>
                <input type="radio" name="card_type" value="MasterCard" id="card_type_1"
                 <cfif IsDefined("Form.card_type")>
                	<cfif Form.card_type EQ "MasterCard">
                    	checked
                    </cfif>
                </cfif> />
                <img src="/graphics/ccico/Regular/48x48/masterCard.png" alt="MasterCard" align="absmiddle" /></label>
              <br />
              <label>
                <input type="radio" name="card_type" value="American Express" id="card_type_2"
                 <cfif IsDefined("Form.card_type")>
                	<cfif Form.card_type EQ "American Express">
                    	checked
                    </cfif>
                </cfif> />
                <img src="/graphics/ccico/Regular/48x48/amex.png" alt="American Express" align="absmiddle" /></label>
              <br />
              <label>
                <input type="radio" name="card_type" value="Discover" id="card_type_3"
                 <cfif IsDefined("Form.card_type")>
                	<cfif Form.card_type EQ "Discover">
                    	checked
                    </cfif>
                </cfif> />
                <img src="/graphics/ccico/Regular/48x48/discover.png" alt="Discover" align="absmiddle" /></label>
              <br />
            </p>
            	
            </td>
        </tr>
        <tr>
        	<td>
	            <strong>Name on Card:</strong>
            </td>
            <td>
            	<span style="color:red;">#ErrNameOnCard#</span>
            	<input type="text" 
                	name="name_on_card"
                    <cfif IsDefined("Form.name_on_card")>
                    	value="#Form.name_on_card#"
                    </cfif> />
            </td>
        </tr>
        <tr>
        	<td style="background-color:##EFEFEF;">
            <strong>Card Number:</strong></td>
            <td style="background-color:##EFEFEF;">
            	<span style="color:red;">#ErrCardNumber#</span>
                <input type="text" name="card_number"
                	<cfif IsDefined("Form.card_number")>
                    	value="#Form.card_number#"
                    </cfif> /></td>
        </tr>
        <tr>
        	<td><strong>Expiration Date:</strong></td>
            <td>
            	<span style="color:red;">#ErrExpirationDate#</span>
            	<input type="text" name="expiration_date"
                	<cfif IsDefined("Form.expiration_date")>
                    	value="#Form.expiration_date#"
                    </cfif> /></td>
        </tr>
        <tr>
        	<td style="background-color:##EFEFEF;"><strong>CVV:</strong></td>
            <td style="background-color:##EFEFEF;">
            <span style="color:red;">#ErrCVV#</span>
            <input type="text" name="cvv"
            	<cfif IsDefined("Form.cvv")>
                	value="#Form.cvv#"
                </cfif> /></td>
        </tr>
        <tr>
        	<td style="background-color:white;"><strong>Billing ZIP:</strong></td>
            <td style="background-color:white;">
            <span style="color:red;">#ErrZIP#</span>
            <input type="text" name="zip"
            	<cfif IsDefined("Form.zip")>
                	value="#Form.zip#"
                </cfif> /></td>
        </tr>
        <tr>
        	<td colspan="2" align="center"><br />
            	<input type="submit" name="Submit" value="Save Payment Profile" />
            </td>
		</tr>           
            
       
        
    </table>

</form>
</div>
</cfoutput>

</body>
</html>
    