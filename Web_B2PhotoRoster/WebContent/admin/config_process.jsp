<%-- 
    Document   : config_process.jsp
    Created on : Jul 17, 2010, 9:42:00 PM
    Author     : moneil
--%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" errorPage="/jsp/error.jsp"%>
<%@page import="blackboard.data.user.User"%>
<%@page import="blackboard.persist.navigation.NavigationItemDbLoader"%>
<%@page import="org.oscelot.bbbeans.Settings"%>

<%@ taglib uri="/bbNG" prefix="bbNG"%>

<%
String sysAdminUrl = NavigationItemDbLoader.Default.getInstance().loadByInternalHandle("admin_plugin_manage").getHref();

Settings oproConfig = Settings.load();
oproConfig.setFilenameID(null!=request.getParameter("filenameID")?request.getParameter("filenameID"):" ");

oproConfig.setRemoteLocal(null!=request.getParameter("remoteLocal")?request.getParameter("remoteLocal"):" ");
oproConfig.setEnableInstructorUpload(null!=request.getParameter("enableInstructorUpload")?request.getParameter("enableInstructorUpload"):" ");
oproConfig.setFilePath(null!=request.getParameter("filePath")?request.getParameter("filePath"):" ");
oproConfig.setFileDirectory(null!=request.getParameter("fileDirectory")?request.getParameter("fileDirectory"):" ");
oproConfig.setRemoteURLRoot(null!=request.getParameter("remoteURLRoot")?request.getParameter("remoteURLRoot"):" ");
oproConfig.setLocalURLRoot(null!=request.getParameter("localURLRoot")?request.getParameter("localURLRoot"):" ");
oproConfig.setScalePhotos(null!=request.getParameter("scalePhotos")?request.getParameter("scalePhotos"):" ");
oproConfig.setScaledPhotoExtents(null!=request.getParameter("scaledPhotoExtents")?request.getParameter("scaledPhotoExtents"):" ");
oproConfig.setPhotoCheck(null!=request.getParameter("photoCheck")?request.getParameter("photoCheck"):" ");
oproConfig.setAllowableCourseRoles(null!=request.getParameter("allowableCourseRoles")?request.getParameter("allowableCourseRoles"):" ");
oproConfig.persist();
%>

<bbNG:learningSystemPage title="Modify Photo Roster Settings">
	<bbNG:receipt type="SUCCESS" iconUrl="/images/ci/icons/tools_u.gif" title="Photo Roster Settings Saved" recallUrl="<%=sysAdminUrl%>">
		<center><h1>Your settings have been saved</h1></center>
		<h2>passed parameters:</h2>
		Filename ID: <%=request.getParameter("filenameID")%><br>
		Remote or Local: <%=request.getParameter("remoteLocal")%><br>
		Allow Instructor upload: <%=request.getParameter("enableInstructorUpload")%><br>
		Local Image Path: <%=request.getParameter("filePath")%><br>
		Local Image Directory: <%=request.getParameter("fileDirectory")%><br>
		Local URL Root: <%=request.getParameter("localURLRoot")%><br>
		<br>
		Scale Photos: <%=(null!=request.getParameter("scalePhotos")?request.getParameter("scalePhotos"):" ")%><br>
		Scaled Photo Extents: <%=(null!=request.getParameter("scaledPhotoExtents")?request.getParameter("scaledPhotoExtents"):" ")%><br>
		<br>
		Remote URL Root: <%=request.getParameter("remoteURLRoot")%><br>
		Test for Remote Photo?: <%=request.getParameter("photoCheck")%><br>
		<br>
		Allowable Course Roles: <%=request.getParameter("allowableCourseRoles")%><br>
		<br>
	</bbNG:receipt>
</bbNG:learningSystemPage>