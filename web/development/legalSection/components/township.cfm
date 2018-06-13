<!---http://localhost/LegalSection/Service.asmx?wsdl--->

<cfinvoke webservice="LegalSections" method="TownshipFromLatLong" Latitude="#url.latitude#" longitude="#url.longitude#" returnvariable="township">

<cfoutput>#variables.township#</cfoutput>