<%-- 
    Document   : post
    Created on : Jul 18, 2010, 4:55:46 PM
    Author     : moneil

<%--

<jsp:useBean id="PhotoRoster" scope="page" class="org.oscelot.photoroster.PhotoRoster"/>

<%@ page	language="java"
		import="java.util.*,
		        blackboard.base.*,
				blackboard.data.*,
				blackboard.data.user.*,
				blackboard.data.course.*,
				blackboard.persist.*,
				blackboard.persist.user.*,
				blackboard.persist.course.*,
				blackboard.platform.*,
                                org.oscelot.utils.Uploader"
		pageEncoding="UTF-8"
%>

<%@taglib uri="/bbNG" prefix="bbNG" %>


<%
	String iconUrl = "/images/ci/icons/bookopen_u.gif";
	String page_title = "Getting Started Guide: Photo Roster";
	String msg = "Hello";
	String backTargetURL = "photoroster.jsp?course_id=";
	String sessionCourseID = request.getParameter("sessionCourseID");
        String cancelTarget = "photoroster.jsp?course_id=" + sessionCourseID;

//System.err.println("Post.jsp:sessionCourseID:[" + request.getParameter("sessionCourseID"));
//System.err.println("Post.jsp:usersstudent_id " + request.getParameter("usersstudent_id"));

%>

<bbNG:genericPage title="<%= page_title %>">
  <bbNG:pageHeader instructions="Select your Photo. Only jpeg photos with an extension of '.jpg' are accepted in this version.">
    <bbNG:breadcrumbBar environment="CTRL_PANEL">
      <bbNG:breadcrumb>Photo Roster Photo Upload</bbNG:breadcrumb>
    </bbNG:breadcrumbBar>
    <bbNG:pageTitleBar iconUrl="../images/icon_sm.gif" showTitleBar="true" title="Upload Photo Roster Image for Selected Student"/>
  </bbNG:pageHeader>
    
      <bbNG:form action="process_post.jsp" method="POST" name="post_img" id="post_img" enctype="multipart/form-data">
          
          <input type=hidden name="student_id" value = "<%= request.getParameter("usersstudent_id") %>" />
          <input type=hidden name="courseID" value = "<%= request.getParameter("sessionCourseID") %>" />
          
          <bbNG:dataCollection showSubmitButtons="true">
              <bbNG:step hideNumber="false" instructions="Select the photo you wish to upload." title="Photo Selection">
                  <bbNG:dataElement isRequired="true">
                      <bbNG:filePicker required="true" showLinkTitle="false" var="file" baseElementName="file" mode="LOCAL_FILE_ONLY">
                    </bbNG:filePicker>
                  </bbNG:dataElement>
              </bbNG:step>
              <bbNG:stepSubmit cancelUrl="<%= cancelTarget %>" hideNumber="false" title="Submit the photo" showCancelButton="true">
              </bbNG:stepSubmit>
          </bbNG:dataCollection>
        </bbNG:form>
    </bbNG:genericPage>
--%>