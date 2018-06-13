<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="/Prefiniti2/Prefiniti2.css" type="text/css" />
<script type="text/javascript" src="/Prefiniti2/Prefiniti2.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Prefiniti 2.0</title>
</head>

<body>

<cfquery name="Blog" datasource="#session.DB_Core#">
	SELECT * FROM webgrams WHERE dev_blog=1 ORDER BY post_date DESC
</cfquery>


<table width="1060" cellpadding="10">
<tr>
	<td>
		<img src="/homeres/Prefiniti-Logo-white.png" style="float:left;" border="0" alt="Prefiniti Logo"/>
	</td>
	<td align="right">Prefiniti 2.0 Technology Preview</td>
</tr>
</table>
<span style="font-size:xx-small; padding-left:15px;">
<a href="##" onclick="ShowScreenshots();">Screenshots</a> | <a href="##" onclick="ShowBlog();">Developer Blog</a></span><br />
<hr width="1060" align="left" />	

<div class="ContentArea" id="Blog" style="display:block; height:auto;">
	<h2>Welcome to the Prefiniti 2.0 Developer Blog</h2>
	
	<p style="margin-left:20px; width:1016px; font-size:12px;">This is the place to watch for updates on the development of the upcoming Prefiniti 2.0 release. Our development team will be writing blog entries as the project progresses.</p>
	
	<h2>What Is Prefiniti 2.0?</h2>
	
	<p style="margin-left:20px; font-size:12px; width:1016px; font-size:12px;">Prefiniti 2.0 is a major internal overhaul of the Prefiniti Application Framework. This new framework consists of a new API and object management system, with many features:
	<ul>
	<li>Capable of handling a limitless number of new business objects with an easy point-and-click interface</li>
	<li>New services and products can be added to the framework simply by defining a new business object type</li> 
	<li>Objects of all types can be related to each other and shared among users with a flexible permissions system</li>
	<li>Sessions will no longer require a full refresh in order to do business with a different company</li>
	<li>GPS and GIS is fully integrated throughout the framework</li>
	<li>Workflow rules may be defined for any order or project type, such that:
		<ul>
		<li>An order or project type may require multiple objects to be created at various milestones</li>
		<li>The creation, editing, deletion, sharing, or other manipulation of any object can trigger any number of customizeable events, such as:
			<ul>
			<li>Sending user notifications</li>
			<li>Sharing or relating objects</li>
			<li>Invoking the scheduling system</li>
			<li>Creating, modifying, or deleting new or existing objects</li>
			<li>Requesting new information from users or groups of users</li>
			</ul>
		</ul>		
	</li>
	<li>A new applications architecture, allowing applications to be installed to or removed from user profiles, based on site membership, roles, and permissions</li>
	<li>The new window manager (which is actually being used in the production Prefiniti 1.5 release) is fully-featured:
		<ul>
		<li>Window creation, sizing, minimizing, and maximizing</li>
		<li>Each window can be bound to any view of an object, or to the object's default view</li>
		<li>Each window can intercept and interpret a variety of messages, responding to events managed and dispatched by the window manager and other running applications</li>
		<li>Includes a familiar docked button interface for accessing Prefiniti applications and open windows</li>
		<li>Provides a virtual desktop environment, complete with hierarchical folders</li>
		<li>Customizable desktop wallpaper</li>
		<li>Uploads and orders are managed directly from the desktop or any folder</li>
		<li>Workflow-bound objects such as orders, projects, and timecards can be organized into folders per user preference</li>
		<li>The item basket allows users to select multiple desktop objects from different folders for operations such as: <ul><li>Copying objects</li><li>Shopping for goods and services</li><li>Sharing objects with friends</li></ul></li>
		<li>A new background service manager manages scheduling of background tasks, such as maintaining the Prefiniti Chat buddy list or monitoring a GPS device</li>
		<li>The help browser provides quick and easy access to context-sensitive online help</li>
		<li>The Prefiniti Chat service allows users to stay in touch with each other, without ever leaving the Prefiniti desktop</li>
		<li>The mapping system can now provide near real-time location and speed information with GPS and the new Prefiniti Desktop Tools (requires an NMEA 2.x-compliant GPS receiver)</li>
		</ul>
		
		
	</ul>
	
	</p>
	
	<cfoutput query="Blog">
	<h1 style="font-size:24px;">#DateFormat(post_date, "mmmm d, yyyy")#</h1>
	<div style="margin-left:40px; font-size:12px; color:white; width:1016px;">#w_body#</div>
	<hr />
	</cfoutput>
</div>


<div class="ContentArea" id="Screenshots" style="display:none; height:auto;">
	<h1>Prefiniti 1.6/2.0 Screenshots</h1>
	<p style="margin-left:40px; font-size:12px; color:white; width:1016px;">Click an image to view the full image size.</p>
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="application-panel-my-messages" ImageName="My Messages">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="application-panel" ImageName="Prefiniti Application Panel">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="create-new-folder" ImageName="Create New Folder">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="empty-folder" ImageName="An empty folder">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="folder-browser-object-info" ImageName="Folder browser and object info panel">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="help-browser" ImageName="Prefiniti help browser">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="initial-desktop" ImageName="A basic desktop">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="item-basket-context-menu" ImageName="Item basket and context menus">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="loading-screen" ImageName="Loading screen">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="network-browser" ImageName="Prefiniti Network Browser">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="prefiniti-chat" ImageName="The Prefiniti Chat service">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="service-manager" ImageName="Background Service manager">
	<cfmodule template="gallery_thumbnail.cfm" ImageFile="sign-in-screen" ImageName="Sign-in screen">
</div>

<div style="width:100%; font-size:xx-small; clear:left;">Copyright &copy; 2008 Prefiniti Inc.<br />Patent Pending.</div>
</body>
</html>
