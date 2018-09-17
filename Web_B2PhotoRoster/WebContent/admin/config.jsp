<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="blackboard.data.user.User"%>
<%@page import="blackboard.platform.context.*"%>
<%@page import="org.oscelot.bbbeans.Settings"%>

<%@ taglib uri="/bbNG" prefix="bbNG" %>

<bbNG:learningSystemPage ctxId="ctx" title="OSCELOT Photo Roster Config" entitlement="system.admin.VIEW">
	<bbNG:pageHeader instructions="${bundle['page.system.tools.instructions']}">
		<bbNG:breadcrumbBar environment="SYS_ADMIN_PANEL" navItem="admin_plugin_manage">
			<bbNG:breadcrumb>Modify Photo Roster Settings</bbNG:breadcrumb>
	    </bbNG:breadcrumbBar>
		<bbNG:pageTitleBar iconUrl="../images/icon_sm.gif" showTitleBar="true" title="Modify Photo Roster Settings"/>
	</bbNG:pageHeader>
	
	<%
	String vendorId = "OSCELOT";
	String applicationHandle = "OPRO";
	boolean enable_instructor_upload = false;
	Settings oproConfig = org.oscelot.bbbeans.Settings.load();	
	String cancelUrl = org.oscelot.utils.Utils.getNavigationItem("admin_plugin_manage").getHref();	
	pageContext.setAttribute("cancelUrl", cancelUrl);	
	%>
	
	<bbNG:jspBlock>	
		<script type="text/javascript">
			function dispHandle(obj) {
				if (obj.style.display == "none") {
					obj.style.display = "";
				} else {
					obj.style.display = "none";
				}
			}
		</script>
	</bbNG:jspBlock>
	
	<%
	Settings settings = Settings.load();
	
	boolean radioLocal = settings.getRemoteLocal().equals("local")?true:false;
	boolean radioRemote = settings.getRemoteLocal().equals("remote")?true:false;
	String filePathString = null!=settings.getFilePath()?settings.getFilePath():"Enter the path of your local image store - should be under the content directory";
	String fileDirString = null!=settings.getFileDirectory()?settings.getFileDirectory():"Enter the name of the local image directory";
	String localURLRootString = null!=settings.getLocalURLRoot()?settings.getLocalURLRoot():"Enter the local URL root. e.g.: https://192.168.56.101";
	String remoteURLRootString = null!=settings.getRemoteURLRoot()?settings.getRemoteURLRoot():"Enter the local URL root. e.g.: https://192.168.56.101";
	boolean radioAllowUploadsYes = settings.getEnableInstructorUpload().equals("yes")?true:false;
	boolean radioAllowUploadsNo = settings.getEnableInstructorUpload().equals("no")?true:false;
	boolean radioFilenameIDStudentID = settings.getFilenameID().equals("studentid")?true:false;
	boolean radioFilenameIDUserID = settings.getFilenameID().equals("userid")?true:false;
	String scalePhotosSetting = settings.getScalePhotos();
	String photoCheckSetting = settings.getPhotoCheck();
	boolean scalePhotos = (null!=scalePhotosSetting && scalePhotosSetting.equals("scalePhotos"))?true:false;
	String scaledPhotoExtents = null!=settings.getScaledPhotoExtents()?settings.getScaledPhotoExtents():"";
	boolean photoCheck = (null!=photoCheckSetting && photoCheckSetting.equals("true"))?true:false;
	String allowableCourseRoles = null!=settings.getFilePath()?settings.getAllowableCourseRoles():"Enter the course roles allowed to use this tool.";
	%>
	
	Complete these settings prior to making the tool available to users.
	
	<bbNG:form action="config_process.jsp" name="configForm" method="post">
	  <bbNG:dataCollection markUnsavedChanges="true" showSubmitButtons="true">
	    <bbNG:step hideNumber="false" title="Select Photo Identifier" instructions="Select the identifier used for Photos. This is the photo filename w/o the extension.
	    	<br>Note: Setting is currently not used - all photos are referenced using the Student ID.">
	        <bbNG:dataElement isRequired="true" label="Photo Filename">
	            <bbNG:radioElement title="STUDENT_ID" name="filenameID" value="studentid" isSelected="<%= radioFilenameIDStudentID %>">STUDENT_ID</bbNG:radioElement><br>
	            <bbNG:radioElement title="USER_ID" name="filenameID" value="userid" isSelected="<%= radioFilenameIDUserID %>">USER_ID</bbNG:radioElement>
	        </bbNG:dataElement>
	    </bbNG:step>
	    
		<bbNG:step hideNumber="false" title="Local Storage Settings" instructions="Complete this section if using local storage.
			<br>You must create the directory as specified via the 'File Path' and 'File Directory' settings either as a mounted filesystem or a physical directory.
			<br>Note that the File Path and File Directory must be webserver accessible - i.e.: in the blackboard docs directory.
			<br>e.g.: on Linux, you may use File Path=/usrs/local/blackboard/docs and File Directory=/photos<hr>">
			<bbNG:dataElement isRequired="false" label="Use Local Files">
				<bbNG:radioElement isSelected="<%= radioLocal %>" name="remoteLocal" id="remoteLocal" value="local"></bbNG:radioElement>
			</bbNG:dataElement>
	      
			<bbNG:dataElement isRequired="false" label="File Path">
			  <bbNG:textElement type="string" name="filePath" size="64" value="<%= filePathString %>"/><br>
			</bbNG:dataElement>

			<bbNG:dataElement isRequired="false" label="Local URL Root">
				<bbNG:textElement type="string" name="localURLRoot" size="64" value="<%= localURLRootString %>"/><br>
			</bbNG:dataElement>
	    </bbNG:step>
	    
	    <bbNG:step hideNumber="false" title="Remote Storage Settings" instructions="Complete this section if using remote storage.
	    	<br>Note: This setting is currently not functional. Code changes are required. Changing to this option may break the tool.">
	    	<bbNG:dataElement isRequired="false" label="Use Remote Files">  
	        	<bbNG:radioElement isSelected="<%= radioRemote %>" name="remoteLocal" id="remoteLocal" value="remote"></bbNG:radioElement>
	    	</bbNG:dataElement>
	    	<bbNG:dataElement isRequired="false" label="Remote URL Root" >
	     		<bbNG:textElement type="string" name="remoteURLRoot" id="remoteURLRoot" size="64" value="<%= remoteURLRootString %>"/><br>
	          	Enter the full URL for your website or service which delivers your images.<br>
	          	eg: http://www.yourdomain.edu/path/&lt;X@X-ID-X@X&gt;&lt;X@X-EXTENSION-X@X&gt; <br>or<br> http://www.yourdomain.edu/photoroster.cgi?id=&lt;X@X-ID-X@X&gt;<br>
	          	Note that in the case of specifying the extension only .jpg files are currently supported.<br>
	      	</bbNG:dataElement>
			<bbNG:dataElement isRequired="false" label="Check for Availabile Photo?">
				<bbNG:checkboxElement id="photoCheck" name="photoCheck" value="true" isSelected="<%= photoCheck %>" /><br>
		    	Note: Using this availability check on remote photos will increase delivery time. If you do not select this setting your remote photo service must provide an 'image not found' image or you will see broken links should a photo not be available.<br>
			    The Photo Roster uses a HTTP HEAD check which may not work with some services.
			</bbNG:dataElement>
	    </bbNG:step>
	    
	    <bbNG:step hideNumber="false" title="Enable Uploads Setting" instructions="Check if you wish to allow image uploads (currently supports jpg only)
	    	<br>Note: This setting is currently not functional. Code changes are required. Changing to this option may break the tool.">
	    	<bbNG:dataElement isRequired="true" label="Allow Uploads to local filestore?">
	        	<bbNG:radioElement title="Yes" name="enableInstructorUpload" value="yes" isSelected="<%= radioAllowUploadsYes %>">YES</bbNG:radioElement>&nbsp;
	            <bbNG:radioElement title="No" name="enableInstructorUpload" value="no" isSelected="<%= radioAllowUploadsNo %>">NO</bbNG:radioElement>
	        </bbNG:dataElement>
	    </bbNG:step>
	    
	    <bbNG:step hideNumber="false" title="Set Photo Scaling" instructions="Set the maximum size in pixels for photos - this is applied to the extents of the image. Uncheck if photos are prescaled at source.">
	    	<bbNG:dataElement isRequired="true" label="Photo Scaling">
	            <bbNG:checkboxElement id="scalePhotos" name="scalePhotos" value="scalePhotos" isSelected="<%= scalePhotos %>" /><br>
	             Note: This will increase delivery time - it is suggested that photos be scaled at the source. This is especially true in the case of remote images.
	        </bbNG:dataElement>
	        <bbNG:dataElement isRequired="true" label="Photo Max Dimension">
	            Enter the maximum Height or Width: <bbNG:textElement id="scaledPhotosExtents" name="scaledPhotoExtents" value="<%= scaledPhotoExtents %>" size="4"/>
	        </bbNG:dataElement>
		</bbNG:step>
		
		<bbNG:step hideNumber="false" title="Set Allowable Course Roles" instructions="Set the course roles that have access to this tool. An asterick will open this tool to all users (use with caution). Examples: INSTRUCTOR,STUDENT">
			<bbNG:dataElement isRequired="true" label="Course Roles">
			  <bbNG:textElement type="string" name="allowableCourseRoles" value="<%= allowableCourseRoles %>"/><br>
			</bbNG:dataElement>
		</bbNG:step>
		
	    <bbNG:stepSubmit hideNumber="false" showCancelButton="true" cancelUrl="${cancelUrl}" />
	  </bbNG:dataCollection>
	</bbNG:form>
</bbNG:learningSystemPage>
