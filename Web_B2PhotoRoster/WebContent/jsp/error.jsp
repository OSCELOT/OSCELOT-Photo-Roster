<%@ page language="java" isErrorPage="true" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ taglib uri="/bbData" prefix="bbData"%>

<bbNG:learningSystemPage>
	<bbNG:pageHeader>
		<bbNG:pageTitleBar showTitleBar="true" title="Photo Roster"/>
	</bbNG:pageHeader>

	<bbNG:error exception='<%=(Exception) request.getSession().getAttribute("exception")%>'/>
	<h2>If the error persists, please contact the ITaP Customer Service Center at itap@purdue.edu.</h2>
	
	<div class="footer">
		<img src="../images/p.gif" alt="Purdue Logo">&nbsp;&nbsp;© 2013 Purdue University<br /><br />An equal access/equal opportunity university.  If you have trouble accessing this page because of a disability or have any inquiries/comments, please contact the ITaP Customer Service Center by emailing itap@purdue.edu or calling (765) 494-4000.
	</div>
</bbNG:learningSystemPage>