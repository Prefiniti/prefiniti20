<cfquery name="GetPP" datasource="#session.DB_Core#">
	SELECT * FROM payment_profiles WHERE id=#Attributes.PPID#
</cfquery>

<cfswitch expression="#GetPP.credit_card#">
	<cfcase value="0">
		<table>
		<tr>
		<td>
		<h4>Cash</h4>
		</td>
		</tr>
		</table>
	</cfcase>
	<cfcase value="1">
		<cfoutput query="GetPP">
				<table>
				<tr>
				<td>
				<h4>Credit Card</h4>
				</td>
				<td>&nbsp;</td>
				</tr>
				<tr>
				<td><strong>Card:</strong></td>
				<td>#card_type#</td>
				</tr>
				<tr>
				<td><strong>Name:</strong></td>
				<td>#name_on_card#</td>
				</tr>
				<tr>
				<td><strong>No.:</strong></td>
				<td>#card_number#</td>
				</tr>
				<tr>
				<td><strong>Exp.:</strong></td>
				<td>#DateFormat(expiration_date, "mm/yy")#</td>
				</tr>
				<tr>
				<td><strong>CVV:</strong></td>
				<td>#cvv#</td>
				</tr>
                <tr>
                <td><strong>Billing ZIP:</strong></td>
                <td>#billing_zip#</td>
                </tr>
				</table>
		</cfoutput>
	</cfcase>
</cfswitch>


