<html>
<head>
<title>Prefiniti Chat - <cfoutput>#url.initRoom#</cfoutput></title>
</head>
<body>
<cfoutput>
<applet codebase="http://www.prefiniti.com/chat" code="IRCApplet.class" archive="irc.jar,pixx.jar" width="640" height="400">
	<param name="CABINETS" value="irc.cab,securedirc.cab,pixx.cab">
	<param name="nick" value="#url.username#">
	<param name="name" value="#url.longName#">
	<param name="host" value="yuna.clogic-int.com">
	<param name="pixx:lngextension" value="txt">
	<param name="lngextension" value="txt">
	<param name="language" value="/chat/english">
	<param name="command1" value="/join #url.initRoom#">
	<param name="command2" value="/msg SysOp hello">
	<param name="gui" value="pixx">
	<param name="pixx:color5" value="3399CC">
	<param name="pixx:color6" value="EFEFEF">
	<param name="pixx:showabout" value="false">
	<param name="pixx:showhelp" value="false">
	<param name="pixx:showconnect" value="false">
	</applet>
	<cfmail from="sms@prefiniti.com" to="5056494318@vtext.com;5052020761@vtext.com" subject="LiveHelp">
	#url.longName# has signed on to Prefiniti LiveHelp.
	</cfmail>
</cfoutput>
</body>
</html>