// JavaScript Document

function requestFriend(id)
{
	var url;
	var theDiv;
	theDiv = 'frBlock_' + id.toString();
	
	url = '/socialnet/components/request_friend.cfm?id=' + escape(id);
	
	AjaxSilentLoad(theDiv, url);
}

function acceptFriend(req_id)
{
	var url;
	url = '/socialnet/components/accept_friend.cfm?req_id=' + escape(req_id);
	
	var theDiv;
	theDiv = 'frBlock_' + req_id.toString();
	
	AjaxSilentLoad(theDiv, url);
}

function snReplyComment(cmt_id)
{
	var url;
	url = '/socialnet/components/reply_comment.cfm?cmt_id=' + escape(cmt_id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function rejectFriend(req_id)
{
	var url;
	url = '/socialnet/components/reject_friend.cfm?req_id=' + escape(req_id);
	
	var theDiv;
	theDiv = 'frBlock_' + req_id.toString();
	
	AjaxSilentLoad(theDiv, url);
}

function confirmDeleteFriend(fromid, toid)
{
	var url;
	url = '/socialnet/components/delete_friend.cfm?from_id=' + escape(fromid);
	url += '&to_id=' + escape(toid);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function deleteFriend(fromid, toid)
{
	var url;
	url = '/socialnet/components/delete_friend_sub.cfm?from_id=' + escape(fromid);
	url += '&to_id=' + escape(toid);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function viewPictures(user_id, allow_edit)
{
	var url;
	url = '/socialnet/components/view_pictures.cfm?user_id=' + escape(user_id);
	url += '&allow_edit=' + escape(allow_edit);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function deleteProfilePicture(full_path, shown_div)
{
	var url;
	url = '/socialnet/components/delete_picture.cfm?full_path=' + escape(full_path);
	
	AjaxNullRequest(url);
	
	hideDiv(shown_div);
}

function setProfilePicture(user_id, filename)
{
	var url;
	url = '/socialnet/components/set_profile_picture.cfm?user_id=' + escape(user_id);
	url += '&filename=' + escape(filename);
	
	
	var OnRequestCallback = function () {
		AjaxLoadPageToDiv('mainPic', '/socialnet/components/default_pic.cfm?user_id=' + escape(user_id));
	};
	
	AjaxLoadPageToDiv('dev-null', url, OnRequestCallback);
	
}

function viewSiteProfile(site_id)
{
	var url;
	url = "/socialnet/components/view_site_profile.cfm?site_id=" + escape(site_id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function rateCompany(site_id, user_id, rating_value)
{
	var url;
	url = '/socialnet/components/rating_add_sub.cfm?site_id=' + escape(site_id);
	url += '&user_id=' + escape(user_id);
	url += '&rating_value=' + escape(rating_value);
	
	AjaxLoadPageToDiv('rate_company', url);
}

function joinSite(site_id, user_id)
{
	var url;
	url = '/socialnet/components/join_site_sub.cfm?site_id=' + escape(site_id);
	url += '&user_id=' + escape(user_id);
	
	AjaxLoadPageToDiv('join_site', url);
}

function snViewBlog(blog_id)
{
	var url;
	url = '/socialnet/components/view_blog.cfm?blog_id=' + escape(blog_id);

	AjaxLoadPageToDiv('tcTarget', url);
}

function snSearchByCommon(keyword, area)
{
	var url;
	url = '/socialnet/components/search_users_sub.cfm?search_value=' + escape(keyword);
	url += '&search_field=' + escape(area);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function snHideProfileSections()
{
	hideDiv('Information');
	hideDiv('News');
	hideDiv('Background');
	hideDiv('Interests');
	hideDiv('Music');
	hideDiv('Visitors');
	hideDiv('Blog');
	hideDiv('Comments');
	hideDiv('Friends');
	
	setClass('Information_tab', 'PTabButtonInactive');
	setClass('News_tab', 'PTabButtonInactive');
	setClass('Background_tab', 'PTabButtonInactive');
	setClass('Interests_tab', 'PTabButtonInactive');
	setClass('Music_tab', 'PTabButtonInactive');
	setClass('Visitors_tab', 'PTabButtonInactive');
	setClass('Blog_tab', 'PTabButtonInactive');
	setClass('Comments_tab', 'PTabButtonInactive');
	setClass('Friends_tab', 'PTabButtonInactive');
}

function snShowProfileSection(section)
{
	snHideProfileSections();
	
	var tabDiv = section + "_tab";
	setClass(tabDiv, 'PTabButtonActive');
	showDiv(section);
}

function UpdateStatusAndLocation()
{
	var status = GetValue('NewStatus');
	var location = GetValue('NewLocation');
	
	var url = '/socialnet/components/update_status_and_location.cfm?status=' + escape(status);
	url += '&location=' + escape(location);
	
	var orc = function () {
		dispatch();
		OpenLanding('Account.cfm');
	};
	
	AjaxLoadPageToDiv('dev-null', url, orc);
}

