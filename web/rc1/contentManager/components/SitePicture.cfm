<cfinclude template="/contentmanager/cm_udf.cfm">


<cfoutput><img src="#cmsSiteFileURL(attributes.SiteFileID)#" onclick="window.open('#cmsSiteFileURL(Attributes.SiteFileID)#','uploadStatusWindow');" width="#attributes.width#" height="#attributes.height#" align="absmiddle" alt="Site file #attributes.SiteFileID#"></cfoutput>