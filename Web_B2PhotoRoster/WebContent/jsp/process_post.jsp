<%-- 
    Document   : process_post.jsp
    Created on : Aug 12, 2010, 12:49:39 PM
    Author     : moneil
--%>
<%--
<%@page contentType="text/html"
        language="java"
        import="java.util.*,
		blackboard.base.*,
		blackboard.data.*,
                blackboard.data.user.*,
                blackboard.data.course.*,
                blackboard.persist.*,
                blackboard.persist.user.*,
                blackboard.persist.course.*,
                blackboard.platform.*,
                org.oscelot.utils.Uploader,
                javax.servlet.http.HttpServletRequest,
                org.apache.commons.fileupload.MultipartStream,
                java.io.File,
                org.apache.commons.fileupload.servlet.ServletFileUpload,
                org.apache.commons.fileupload.disk.DiskFileItemFactory,
                org.apache.commons.fileupload.*"
	pageEncoding="UTF-8"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="PhotoRoster" scope="page" class="org.oscelot.photoroster.PhotoRoster"/>


<%@taglib uri="/bbNG" prefix="bbNG" %>


<%
    String iconUrl = "/images/ci/icons/bookopen_u.gif";
    String page_title = "Getting Started Guide: Photo Roster";
    String msg = "Hello";
    String sessionCourseID = null;
    String goBackTargetURL = null;
    String student_id = null;
    String course_id = null;

    org.oscelot.utils.Uploader myUploader = new Uploader();

    myUploader.doFilePost(request, application);

    goBackTargetURL = "photoroster.jsp?course_id=" + myUploader.getParameter("courseID");
%>

<bbNG:learningSystemPage title="Photo Upload" >
    <bbNG:receipt type="SUCCESS" iconUrl="../images/icon_sm.gif" title="Image Uploaded" recallUrl="<%= goBackTargetURL %>">
</bbNG:receipt>
</bbNG:learningSystemPage>
--%>