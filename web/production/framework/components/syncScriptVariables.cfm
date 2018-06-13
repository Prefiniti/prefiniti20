
    glob_userid='#session.userid#';
    glob_companyid='#session.companyID#';
    <cfif #session.role# EQ "ADMIN">
        glob_isAdmin = true;
    <cfelse>
        glob_isAdmin = false;
    </cfif>
    
        hideDiv('mastHead');
    
    alert('script variables synchronized');
    
    glob_usertype = #session.usertype#;
    glob_isTCAdmin = '#session.tcadmin#';
    glob_unreadMail = '#unreadQ.RecordCount#';
    glob_order_processor = '#session.order_processor#';
    glob_site_maintainer = '#session.site_maintainer#';
    glob_userName = '#session.userName#';
    glob_longName = '#session.longname#';
    glob_tcsigned = '#session.tcsigned#';
    glob_tcopen = '#session.tcopen#';
    glob_overdue = '#session.overdue#';
    glob_newJobs = '#session.newJobs#';
    soundManagerInit();
    <cfif #session.browsertype# NEQ "Microsoft Internet Explorer">
        //enableRTEventListener();
    <cfelse>
        showMessage('Browser Warning', 'You are running Internet Explorer.<br>Event notifications disabled.');
    </cfif>

