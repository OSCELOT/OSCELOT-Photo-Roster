<%--
    Document    : index
    Created on  : Jul 18, 2010, 4:37:14 PM
    Author      : moneil
    Notes       : Released to OSCELOT as Community Open Source under the BSD license

/*
  file:		photoroster.jsp
  project:	Open Source Photo Roster
  description:
  	Building Blocks Getting Started Guide: Open Source Photo Roster
  	Present a table of Course Memberships include photos if available,
  	else use placeholder and provide button to upload photo to the
  	plugin directory named with the members Batch_uid.
  author:	Mark O'Neil
  date:		2006-01-25
  version:	2.0.0
  version history:
  	date :: note
  		2014-03-19 :: Anthony Misner - heavy code modifications made, updated to more current code, customized for Purdue
        2010-08-04 :: Compatible with 9.1 + many more changes...
  	2006-01-23 :: created(mo)
*/
--%>

<%@ page language="java" errorPage="error.jsp"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="org.oscelot.utils.Files"%>
<%@ page import="blackboard.platform.plugin.PlugInUtil"%>
<%@page import="org.oscelot.bbbeans.Settings"%>
<%@page import="java.util.List"%>
<%@page import="blackboard.persist.Id"%>
<%@page import="blackboard.data.course.Course"%>
<%@page import="blackboard.data.course.CourseMembership"%>
<%@page import="blackboard.data.user.User"%>
<%@page import="blackboard.persist.course.CourseMembershipDbLoader"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="java.io.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="javax.xml.bind.DatatypeConverter.*"%>
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ taglib uri="/bbData" prefix="bbData"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.Iterator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String handle = (String) request.getSession().getAttribute("handle");
	String vendorId = (String) request.getSession().getAttribute("vendorId");
	String cssPath = PlugInUtil.getUri(vendorId, handle, "css/photoroster.css") + "?id=" + (new Random()).nextInt();
	String jsPath = PlugInUtil.getUri(vendorId, handle, "js/jquery-1.10.2.js") + "?id=" + (new Random()).nextInt();
	
%>




<bbNG:learningSystemPage ctxId="ctx" entitlement="course.user.VIEW">
	<bbNG:cssFile href="<%=cssPath%>" />
	<bbNG:jsFile href="<%=jsPath%>" />

	<script>
	   //To Avoid Conflicts with Other BlackBoard Libraries use  $jj. 
	   //http://learn.jquery.com/using-jquery-core/avoid-conflicts-other-libraries/
	   
	    var $j = jQuery.noConflict();
    $j(document).ready(function(){
		   $j(".pagingprefs").hide();
 
 	    	$j(".SubmitCollectionFull0").hide();
  	    	$j(".SubmitCollectionFull").show();
 			$j(".rowSingle00").attr('colspan',6);
  	   	$j('.photoPrint').height(80);
  	   	$j("th").hide();


	    	
  	    	$j(".rowSingle11").hide();
  	    	$j(".rowSingle1").hide();
  	    	$j(".labelClass2").hide();
	    	$j(".labelClass0").show();
	    	$j(".labelClass02").hide();
	    	$j(".labelClass03").hide();
	    	$j(".labelClass04").hide();
  	    	$j(".rowSingle00").show();
  	    	$j(".rowSingle41").hide();
  	    	$j(".rowSingle42").show();
  	    	
  	    	if ($j("#displayFieldsEachRow").is(":checked")) {
  	         $j(".labelClass90").show();
                    $j(".labelClass902").hide();
               $j(".labelClass903").hide();
               $j(".labelClass904").hide();
            $j(".labelClass3").hide();
            $j(".labelClass32").hide();
            $j(".labelClass33").hide();
            $j(".labelClass34").hide();
  	    	   }

  	    	   else {
     	    	   		$j(".labelClass").hide();
  	    	    	$j(".labelClass3").hide();
	    	    	$j(".labelClass32").hide();
	    	    	$j(".labelClass33").hide();
	    	    	$j(".labelClass34").hide();
  	    	   }
  	    	
	    	if ($j("#displayFieldsEachRow").is(":checked")) {
	    	   	$j(".labelClass").hide();
	    	   	$j(".labelClass3").show();
	    	   	$j(".labelClass32").show();
	    	   	$j(".labelClass33").show();
	    	   	$j(".labelClass34").show();
	    	   }

	    	   else {
   	    	   		$j(".labelClass").hide();
	    	    	$j(".labelClass3").hide();
	    	    	$j(".labelClass32").hide();
	    	    	$j(".labelClass33").hide();
	    	    	$j(".labelClass34").hide();
	    	   }
	    	

    	   $j("#r1").click(function() {
    		   $j(".pagingprefs").hide();
   			$j(".rowSingle00").attr('colspan',1);
    	   	$j('.photoPrint').height(80);
    		$j("th").hide();
   	    	$j(".SubmitCollectionFull").hide();

   	    	$j(".SubmitCollectionFull0").show();

   	    	$j(".rowSingle00").show();
   	    	$j(".rowSingle41").hide();
   	    	$j(".rowSingle42").hide();
    	    	$j(".rowSingle11").hide();
    	    	$j(".rowSingle1").show();
    	    	$j(".labelClass2").show();
    	    	$j(".labelClass0").hide();
    	    	$j(".labelClass02").hide();
    	    	$j(".labelClass03").hide();
    	    	$j(".labelClass04").hide();
    	    	if ($j("#displayFieldsEachRow").is(":checked")) {
    	    	   	$j(".labelClass").hide();
    	    	   	$j(".labelClass3").show();
    	    	   	$j(".labelClass32").show();
    	    	   	$j(".labelClass33").show();
    	    	   	$j(".labelClass34").show();
    	    	   }

    	    	   else {
       	    	   		$j(".labelClass").hide();
    	    	    	$j(".labelClass3").hide();
    	    	    	$j(".labelClass32").hide();
    	    	    	$j(".labelClass33").hide();
    	    	    	$j(".labelClass34").hide();
    	    	   }
    	   });

/*
    	   $j("#r2").click(function() {
    		   $j(".pagingprefs").hide();
      	    	$j(".SubmitCollectionFull0").show();
       	    	$j(".SubmitCollectionFull").hide();
   			$j(".rowSingle00").attr('colspan',6);
    	   	$j('.photoPrint').height(270);
    	   	$j(".rowSingle41").hide();
    	   	$j(".rowSingle42").hide();
       	   	$j("th").hide();
    	   	    $j(".rowSingle00").show();
    	    	$j(".rowSingle11").show();
    	    	$j(".rowSingle1").hide();
    	    	$j(".labelClass2").hide();
    	    	$j(".labelClass0").show();
    	    	$j(".labelClass02").show();
    	    	$j(".labelClass03").show();
    	    	$j(".labelClass04").show();
    	    	if ($j("#displayFieldsEachRow").is(":checked")) {
    	    	   	$j(".labelClass").show();
    	    	   	$j(".labelClass3").hide();
    	    	   	$j(".labelClass32").hide();
    	    	   	$j(".labelClass33").hide();
    	    	   	$j(".labelClass34").hide();
    	    	   }

    	    	   else {
       	    	   		$j(".labelClass").hide();
    	    	    	$j(".labelClass3").hide();
    	    	    	$j(".labelClass32").hide();
    	    	    	$j(".labelClass33").hide();
    	    	    	$j(".labelClass34").hide();
    	    	   }

    	   });

*/
    	   $j("#r3").click(function() {
    		   $j(".pagingprefs").hide();
      	    
       	    	$j(".SubmitCollectionFull0").show();
       	    	$j(".SubmitCollectionFull").hide();
   			$j(".rowSingle00").attr('colspan',6);
    	   	$j('.photoPrint').height(450);
    		$j("th").hide();
   	    	$j(".rowSingle00").show();
   	    	$j(".rowSingle41").hide();
   	    	$j(".rowSingle42").hide();
    	    	$j(".rowSingle11").show();
    	    	$j(".rowSingle1").hide();
    	    	$j(".labelClass2").hide();
    	    	$j(".labelClass0").show();
    	    	$j(".labelClass02").show();
    	    	$j(".labelClass03").show();
    	    	$j(".labelClass04").show();
    	    	if ($j("#displayFieldsEachRow").is(":checked")) {
    	    	   	$j(".labelClass").show();
    	    	   	$j(".labelClass3").hide();
	    	    	$j(".labelClass32").hide();
	    	    	$j(".labelClass33").hide();
	    	    	$j(".labelClass34").hide();
    	    	   }

    	    	   else {
       	    	   		$j(".labelClass").hide();
    	    	    	$j(".labelClass3").hide();
    	    	    	$j(".labelClass32").hide();
    	    	    	$j(".labelClass33").hide();
    	    	    	$j(".labelClass34").hide();
    	    	   }
    	   });
    	   
    	   $j("#r4").click(function() {
    		   $j(".pagingprefs").hide();
     
      	    	$j(".SubmitCollectionFull0").hide();
       	    	$j(".SubmitCollectionFull").show();
      			$j(".rowSingle00").attr('colspan',6);
       	   	$j('.photoPrint').height(80);
       	   	$j("th").hide();


   	    	
       	    	$j(".rowSingle11").hide();
       	    	$j(".rowSingle1").hide();
       	    	$j(".labelClass2").hide();
    	    	$j(".labelClass0").show();
    	    	$j(".labelClass02").hide();
    	    	$j(".labelClass03").hide();
    	    	$j(".labelClass04").hide();
       	    	$j(".rowSingle00").show();
       	    	$j(".rowSingle41").hide();
       	    	$j(".rowSingle42").show();
       	    	
       	    	if ($j("#displayFieldsEachRow").is(":checked")) {
       	         $j(".labelClass90").show();
	                     $j(".labelClass902").hide();
                    $j(".labelClass903").hide();
                    $j(".labelClass904").hide();
                 $j(".labelClass3").hide();
                 $j(".labelClass32").hide();
                 $j(".labelClass33").hide();
                 $j(".labelClass34").hide();
       	    	   }

       	    	   else {
          	    	   		$j(".labelClass").hide();
       	    	    	$j(".labelClass3").hide();
    	    	    	$j(".labelClass32").hide();
    	    	    	$j(".labelClass33").hide();
    	    	    	$j(".labelClass34").hide();
       	    	   }
       	   });



    	   $j("#displayFieldsEachRow").click(function() {

    		   
    		   if ($j("#displayFieldsEachRow").is(":checked")) {
   	    	   	
    			   if ($j("#r1").is(":checked")) {
    				   
		    	    	$j(".labelClass90").hide();
		    	    	$j(".labelClass902").hide();
		    	    	$j(".labelClass903").hide();
		    	    	$j(".labelClass904").hide();
		    	    	$j(".labelClass3").show();	   	
		    	    	$j(".labelClass32").show();
		    	    	$j(".labelClass33").show();
		    	    	$j(".labelClass34").show();
                           $j(".labelClass").hide();
    		    	   }

    		    	   else {
    		    		            if ($j("#r4").is(":checked")) {
  	    	                             $j(".labelClass0").show();
    		    			                         $j(".labelClass90").show();
    	   		       	    	                     $j(".labelClass902").hide();
    	   		    	    	                     $j(".labelClass903").hide();
    	   		    	    	                     $j(".labelClass904").hide();
    			    	    	                     $j(".labelClass3").hide();
    			    	    	                     $j(".labelClass32").hide();
    			    	    	                     $j(".labelClass33").hide();
    			    	    	                     $j(".labelClass34").hide();
    			    	    	
    		    		            }
    		    		   
    		    		            else {
  	    	                             $j(".labelClass").show();
   		    	    	                             $j(".labelClass0").show();
   		    	    	                             $j(".labelClass02").show();
   		    	    	                             $j(".labelClass03").show();
   		    	    	                             $j(".labelClass04").show();
    		    			                         $j(".labelClass90").show();
    	   		       	    	                     $j(".labelClass902").show();
    	   		    	    	                     $j(".labelClass903").show();
    	   		    	    	                     $j(".labelClass904").show();
		    	    	                             $j(".labelClass3").hide();
		    	    	                             $j(".labelClass32").hide();
		    	    	                             $j(".labelClass33").hide();
		    	    	                             $j(".labelClass34").hide();
    		    	               }
    		    		   }
   	    	   }

   	    	   else {
   	    	    	
   	    		$j(".labelClass").hide();
    	    	$j(".labelClass3").hide();
    	    	$j(".labelClass32").hide();
    	    	$j(".labelClass33").hide();
    	    	$j(".labelClass34").hide();
                $j(".labelClass90").hide();
	              $j(".labelClass902").hide();
                   $j(".labelClass903").hide();
                   $j(".labelClass904").hide();
   	    	   }
    		   
    		   
  


    	   });




    	   });
    </script>

	<bbNG:pageHeader>
		<bbNG:breadcrumbBar>
			<bbNG:breadcrumb>Photo Roster</bbNG:breadcrumb>
		</bbNG:breadcrumbBar>
		<bbNG:pageTitleBar showTitleBar="true" title="Photo Roster" />
	</bbNG:pageHeader>

	<%!org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger("photoroster");%>
	<%
		boolean remotePhotoFound = false;
			if (ctx == null || ctx.getCourse() == null) {
				log.info("No context found");
				request.getSession()
						.setAttribute(
								"exception",
								new Exception(
										"You must use this tool from within a course."));
				throw new Exception("Invalid Context");
			}
			String b64 = "";
			int photoHeight = 90;
			int photoWidth = 90;
			Course sessionCourse = ctx.getCourse();
			String sessionCourseTitle = sessionCourse.getTitle();
			String courseIdParameter = sessionCourse.getCourseId();
			Id sessionCourseId = ctx.getCourseId();
			Settings settings = Settings.load();
			String allowableCourseRoles = settings
					.getAllowableCourseRoles();

			// Check to verify user is enrolled in the course with a valid course role
			if (ctx.getCourseMembership() == null) {
				log.info("Access denied to: {}. No course role.", ctx
						.getUser().getUserName());
				request.getSession().setAttribute(
						"exception",
						new Exception(
								"You must have one of the following course roles: "
										+ allowableCourseRoles));
				throw new Exception("No Course Role");
			}
			String sessionUserRole = ctx.getCourseMembership()
					.getRoleAsString().toUpperCase();
			if (!allowableCourseRoles.equalsIgnoreCase("*")) {
				String[] courseRoles = allowableCourseRoles.split(",");
				boolean roleFound = false;
				for (String courseRole : courseRoles) {
					if (courseRole.equalsIgnoreCase(sessionUserRole)) {
						roleFound = true;
						break;
					}
				}
				if (!roleFound) {
					log.info("Access denied to: {}. Role: {}", ctx
							.getUser().getUserName(), sessionUserRole);
					log.info("Allowable course roles: {}",
							allowableCourseRoles);
					request.getSession().setAttribute(
							"exception",
							new Exception(
									"You must have one of the following course roles: "
											+ allowableCourseRoles));
					throw new Exception("Invalid Course Role");
				}
			}

			Comparator<CourseMembership> cmSortByUsername = new Comparator<CourseMembership>() {
				public int compare(CourseMembership cm1,
						CourseMembership cm2) {
					String s1 = (String) ((User) cm1.getUser())
							.getUserName();
					String s2 = (String) ((User) cm2.getUser())
							.getUserName();
					return s1.toLowerCase().compareTo(s2.toLowerCase());
				}
			};

			Comparator<CourseMembership> cmSortByFamilyName = new Comparator<CourseMembership>() {
				public int compare(CourseMembership cm1,
						CourseMembership cm2) {
					String s1 = (String) ((User) cm1.getUser())
							.getFamilyName();
					String s2 = (String) ((User) cm2.getUser())
							.getFamilyName();
					int compare = s1.toLowerCase().compareTo(
							s2.toLowerCase());
					if (compare == 0) {
						s1 = (String) ((User) cm1.getUser()).getGivenName();
						s2 = (String) ((User) cm2.getUser()).getGivenName();
						compare = s1.toLowerCase().compareTo(
								s2.toLowerCase());
					}
					return compare;
				}
			};

			Comparator<CourseMembership> cmSortByRole = new Comparator<CourseMembership>() {
				public int compare(CourseMembership cm1,
						CourseMembership cm2) {
					String s1 = org.oscelot.utils.Utils
							.getRoleString("COURSE",
									(CourseMembership.Role) cm1.getRole());
					String s2 = org.oscelot.utils.Utils
							.getRoleString("COURSE",
									(CourseMembership.Role) cm2.getRole());
					int compare = s1.toLowerCase().compareTo(
							s2.toLowerCase());
					if (compare == 0) {
						s1 = (String) ((User) cm1.getUser())
								.getFamilyName();
						s2 = (String) ((User) cm2.getUser())
								.getFamilyName();
						compare = s1.toLowerCase().compareTo(
								s2.toLowerCase());
						if (compare == 0) {
							s1 = (String) ((User) cm1.getUser())
									.getGivenName();
							s2 = (String) ((User) cm2.getUser())
									.getGivenName();
							compare = s1.toLowerCase().compareTo(
									s2.toLowerCase());
						}
					}
					return compare;
				}
			};

			Comparator<CourseMembership> cmSortByEmailAddress = new Comparator<CourseMembership>() {
				public int compare(CourseMembership cm1,
						CourseMembership cm2) {
					String s1 = (String) ((User) cm1.getUser())
							.getEmailAddress();
					String s2 = (String) ((User) cm1.getUser())
							.getEmailAddress();
					return s1.toLowerCase().compareTo(s2.toLowerCase());
				}
			};

			List<CourseMembership> allMembershipsList = CourseMembershipDbLoader.Default
					.getInstance().loadByCourseId(sessionCourseId, null,
							true);

			Iterator<CourseMembership> i = allMembershipsList.iterator();
			String tmpUserId = "";
			try {
				while (i.hasNext()) {
					CourseMembership o = i.next();
					tmpUserId = o.getUser().getBatchUid();//some condition
					if (tmpUserId.length() > 6) {
						if (tmpUserId.substring(0, 7).equals("bb_demo")) {

							i.remove();
						}
					}

				}
			} catch (Exception e) {
			}

			Collections.sort(allMembershipsList, cmSortByFamilyName);
			Files imgs = Files.load();
	%>
	<bbNG:jsBlock>

	</bbNG:jsBlock>
	<script>


   </script>
	<script type="text/javascript">

	function breakeveryheader(){
		
		for (i=0; i<document.getElementsByTagName("H5").length; i++)
		document.getElementsByTagName("H5")[i].style.pageBreakBefore="always"
		}

 function funcMsg() {

	    
	}
 
 
 function printTable()
        {
	 breakeveryheader();
	   if ($j("#r4").is(":checked")) {
			 var divToPrint=document.getElementById("divSubmitCollectionFull");
	   }
	   else{
			 //var divToPrint=document.getElementById("listContainer_datatable");
			 var divToPrint=document.getElementById("divSubmitCollectionFull2");
	   }
	   


    	$j(".rowSingle42").hide();
    	 $j("th").hide();
	 var courseTitle="<center><b>Photo Roster for <%=sessionCourseTitle%></b></center>";
	   newWin= window.open("");
	   newWin.document.write(courseTitle);
	   newWin.document.write("<br/><center>");
	   newWin.document.write(divToPrint.outerHTML);
	   newWin.document.write("</center>");
	   newWin.location.reload();
	   newWin.focus();
	   newWin.print();
	   newWin.close();
  	
	   $j(".rowSingle42").show();
   
	}

	$j('button').on('click',function(){
	printData();
	})

 </script>

	<br>
	<%
		int tempTableCounter = -2;
	int tempTableCounter2 = 0;
	int printbreakcounter1=0;
	int printbreakcounter2=0;
	int printbreakcounter3=0;
	%>


		
							<center>
							<h2>
								
								<%=sessionCourseTitle%>
							</h2>
						</center>
										
	<div onclick="funcMsg();" onkeyup="funcMsg();">
		<p class="print-align-right">
			<input type="submit" onclick="printTable()" value="Print">
			Photo size: <input type="radio"
				id="r3" name="photoSize" value="large">1-in-1 page<input
				type="radio" id="r4" name="photoSize" value="photowithname" checked>Full page
				

		</p>
	</div>
						<div id="divSubmitCollectionFull">
						
  	
        	
	<table  align="center" class="SubmitCollectionFull"><tr><td>

						
		<table align="center" id="listCd">
			<tbody>
				<tr>
					<th>

					</th>
				</tr>

				<tr>
					<center>
						<td><bbNG:inventoryList objectVar="cMemb2"  
								collection="<%=allMembershipsList%>"
								className="CourseMembership" description="Course Membership" showAll="true" displayPagingControls="false">
								<div id="listContainer_datatable2">
								<bbNG:listOptions allowEditPaging="false" />
								<!--  retrieve photo for this user matching on the user's student_id -->


					<bbNG:listElement isRowHeader="true" name="Photo" label="Photo" ></bbNG:listElement>
    				<bbNG:listElement label="Name" name="Name" comparator="<%=cmSortByFamilyName%>" >
			</bbNG:listElement>
				<bbNG:listElement label="Username" name="Username" comparator="<%=cmSortByUsername%>" >
		</bbNG:listElement>
					<bbNG:listElement label="Email" name="Email" comparator="<%=cmSortByEmailAddress%>" >
		</bbNG:listElement>
					<bbNG:listElement label="Role" name="Role" comparator="<%= cmSortByRole%>" >
			</bbNG:listElement>



								<bbNG:listElement label="" name="sr1">
								<%if (cMemb2.getUser().getFamilyName().endsWith("PreviewUser")){}
								else {
								%>
					<%
								
										if (tempTableCounter == 5 || tempTableCounter == -3 || tempTableCounter == -2 || tempTableCounter == -1) {
											
														
														
											if( tempTableCounter == -3)
											{
												tempTableCounter = -2;
											}
											else if (tempTableCounter == -2)
											{
												tempTableCounter = -1;
											}
											else if (tempTableCounter == -1)
											{
												tempTableCounter = 0;
											}
											else if (tempTableCounter == 5)
											{
												tempTableCounter = 0;
											}
											
									%>
								
				</TR>
			</tbody>
		</table>
		</td>
		</tr></table>
		<%if (printbreakcounter1==5){
			%><H5></H5><% 
			printbreakcounter2=0;
			printbreakcounter1=printbreakcounter1+1;
		}
		else if (printbreakcounter1>6)
		{
			if (printbreakcounter2==4){
				%><H5></H5><% 
				printbreakcounter2=0;
			}
			else {
				printbreakcounter2=printbreakcounter2+1;
			}
		}
		else
		{
			printbreakcounter1=printbreakcounter1+1;
		}
	
		
		%>

		<table><tr>
			<td><table  id="listContainer_datatable" class="">
					<tbody id="listContainer_databody">

						<TR id="listContainer_row:1" class="">
					
							<%
								} else {
							%>
						</TR>
					</tbody>
				</table></td>
		
			<td><table  id="listContainer_datatable" class="">
					<tbody id="listContainer_databody1">

						<TR id="listContainer_row:1" class="">
							
							<%
								tempTableCounter = tempTableCounter + 1;
											}
							%>


							<left>
								<td colSpan="1" class="rowSingle00" name="mainTDname"><p>
									<left>
										<%
											if (org.oscelot.photoroster.PhotoRoster
																.isThereAPhoto(cMemb2.getUser().getStudentId())) {

															try {
																b64 = "";

																BufferedImage bImage = ImageIO.read(new File(
																		Files.getFilePath()
																				+ cMemb2.getUser()
																						.getStudentId()
																				+ ".jpg"));//give the path of an image
																photoHeight = bImage.getHeight();
																photoWidth = bImage.getWidth();
																ByteArrayOutputStream baos = new ByteArrayOutputStream();
																ImageIO.write(bImage, "jpg", baos);
																baos.flush();
																byte[] imageInByteArray = baos.toByteArray();
																baos.close();
																b64 = javax.xml.bind.DatatypeConverter
																		.printBase64Binary(imageInByteArray);
																bImage.flush();

															} catch (Exception e) {
																e.printStackTrace();
															}
															if (photoHeight > photoWidth) {// 90 was the original size
										%>
										<img name="photoPrintName" class="photoPrint" height="80"
											src="data:image/jpg;base64, <%=b64%>" alt="Image not found" />

										<%
											} else {
										%>
										<img name="photoPrintName" class="photoPrint" height="80"
											src="data:image/jpg;base64, <%=b64%>" alt="Image not found" />

										<%
											}

														} else { // No photo - display placeholder and upload text// 83 was the size
										%>

										<img style="float: middle;" name="photoPrintName"
											class="photoPrint" height="80" alt="No Photo Available"
											src="../images/no_photo.jpg">
										<%
											if (settings.getEnableInstructorUpload().equals(
																	"yes")) {
										%>
										<p>
											<a
												href="post.jsp?action=load&usersstudent_id=<%=cMemb2.getUser().getStudentId()%>
                    		&sessionCourseID=<%=courseIdParameter%>">
												upload a photo</a>
										</p>
										<%
											}
														}
										%>
									</left>
									</p>
									<p>
									<left>
										<label class="labelClass0" style="display: none;"
											name="rowSingleName11"><font size="2pt"><%=cMemb2.getUser().getGivenName()%><br/>&nbsp;<%=cMemb2.getUser().getFamilyName()%></font></label><font
											color="grey"><label style="display: none;"
											name="labelfName2" class="labelClass90">(First, Last)</label></font>
									</left>
									</p><br/>
									</td>

								<td colSpan="1" class="rowSingle1" valign="middle"><left>
									<p>
										<label class="labelClass2" name="rowSingleName1"><font size="2pt"><%=cMemb2.getUser().getGivenName()%><br/>&nbsp;<%=cMemb2.getUser().getFamilyName()%></font></label>
									</p>
									<p>
										<font color="grey"><label style="display: none;"
											name="labelfName" class="labelClass3">(First, Last)</label></font>
									</p><br/>
									</left></td>
								



							</center>
						</TR>
					</tbody>
				</table></td>
			<Td class="rowSingle41"><center>
					<%
						if (org.oscelot.photoroster.PhotoRoster
											.isThereAPhoto(cMemb2.getUser().getStudentId())) {

										try {
											b64 = "";

											BufferedImage bImage = ImageIO.read(new File(
													Files.getFilePath()
															+ cMemb2.getUser()
																	.getStudentId()
															+ ".jpg"));//give the path of an image
											photoHeight = bImage.getHeight();
											photoWidth = bImage.getWidth();
											ByteArrayOutputStream baos = new ByteArrayOutputStream();
											ImageIO.write(bImage, "jpg", baos);
											baos.flush();
											byte[] imageInByteArray = baos.toByteArray();
											baos.close();
											b64 = javax.xml.bind.DatatypeConverter
													.printBase64Binary(imageInByteArray);
											bImage.flush();

										} catch (Exception e) {
											e.printStackTrace();
										}
										if (photoHeight > photoWidth) {// 90 was the original size
					%>
					<img name="photoPrintName" class="photoPrint" height="80"
						src="data:image/jpg;base64, <%=b64%>" alt="Image not found" />

					<%
						} else {
					%>
					<img name="photoPrintName" class="photoPrint" height="80"
						src="data:image/jpg;base64, <%=b64%>" alt="Image not found" />

					<%
						}

									} else { // No photo - display placeholder and upload text// 83 was the size
					%>

					<img style="float: middle;" name="photoPrintName"
						class="photoPrint" height="80" alt="No Photo Available"
						src="../images/no_photo.jpg">
					<%
						if (settings.getEnableInstructorUpload().equals(
												"yes")) {
					%>
					<p>
						<a
							href="post.jsp?action=load&usersstudent_id=<%=cMemb2.getUser().getStudentId()%>
                    		&sessionCourseID=<%=courseIdParameter%>">
							upload a photo</a>
					</p>
					<%
						}
									}
					%>
				</center></td>



			<td class="rowSingle42" width="258"><table  id="listContainer_datatable"
					>
					<tbody id="listContainer_databody">

						<TR id="listContainer_row:1" class="">
							


<%} %>
							</bbNG:listElement>




							</bbNG:inventoryList>

							</td>
							</center>
						</tr>

					</tbody>
				</table>
	</td></tr></table>
	
	
	
	
	<table  align="center" class="SubmitCollectionFull0" ><tr><td>	
<table align="center" id="listCd">
	<tbody>
	
    	<tr><center><td>	
    	<div id="divSubmitCollectionFull2">
		   <bbNG:inventoryList objectVar="cMemb2" collection="<%=allMembershipsList%>"   className="CourseMembership"  showAll="true" displayPagingControls="false" description="Course Membership">
  <bbNG:listOptions allowEditPaging="false" />
		<!--  retrieve photo for this user matching on the user's student_id -->


    				<bbNG:listElement isRowHeader="true" name="Photo" label="Photo" ></bbNG:listElement>
    				<bbNG:listElement label="Name" name="Name" comparator="<%=cmSortByFamilyName%>" >
			</bbNG:listElement>
				<bbNG:listElement label="Username" name="Username" comparator="<%=cmSortByUsername%>" >
		</bbNG:listElement>
					<bbNG:listElement label="Email" name="Email" comparator="<%=cmSortByEmailAddress%>" >
		</bbNG:listElement>
					<bbNG:listElement label="Role" name="Role" comparator="<%= cmSortByRole%>" >
			</bbNG:listElement>

			<bbNG:listElement label="" name="sr1">


			</td></tr><tr><center><td colSpan="1" class="rowSingle00" name="mainTDname"><p><center><%
            
    	    	if (org.oscelot.photoroster.PhotoRoster.isThereAPhoto(cMemb2.getUser().getStudentId() ) ) {
    	    		
    	    		try {
    	    		    b64="";
    	    		    
      	    		    BufferedImage bImage = ImageIO.read(new File(Files.getFilePath()+cMemb2.getUser().getStudentId()+".jpg"));//give the path of an image
    	    		    photoHeight=bImage.getHeight();
    	    		    photoWidth=bImage.getWidth();
    	    		    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    	    		    ImageIO.write( bImage, "jpg", baos );
    	    		    baos.flush();
    	    		    byte[] imageInByteArray = baos.toByteArray();
    	    		    baos.close();
    	    		    b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
						bImage.flush();
    	    		    
    	    		}
    	    		catch (Exception e)
    	    		{
    	    			e.printStackTrace();
    	    			}
    	    		if (photoHeight>photoWidth){// 90 was the original size
    	    			%>
       	    		 <img  name="photoPrintName"  class="photoPrint" height="80" src="data:image/jpg;base64, <%=b64%>" alt="Image not found" />
       	    		
       	    		<%	
    	    		}
    	    		else {
    	    			%>
       	    		 <img  name="photoPrintName"  class="photoPrint" height="80" src="data:image/jpg;base64, <%=b64%>" alt="Image not found" />
       	    		
       	    		<%
    	    		}
    		
    	    	} else  { // No photo - display placeholder and upload text// 83 was the size
             	%>
             	   
                    <img  style="float:middle;"  name="photoPrintName"  class="photoPrint" height="80" alt="No Photo Available" src="../images/no_photo.jpg">
                <%
                    if (settings.getEnableInstructorUpload().equals("yes")) {
                %>
                    	<p> <a href = "post.jsp?action=load&usersstudent_id=<%=cMemb2.getUser().getStudentId()%>
                    		&sessionCourseID=<%=courseIdParameter%>"> upload a photo</a></p>
             	<% 	}
             	}
            
        %></center></p>
<p><center><label class="labelClass0" style="display:none;" name="rowSingleName11"    ><%=cMemb2.getUser().getGivenName()%>&nbsp;<%=cMemb2.getUser().getFamilyName()%></label><font color="grey"><label  style="display:none;" name="labelfName2"  class="labelClass">(First, Last)</label></font></center></p>
<p><center><label  class="labelClass0" style="display:none;" name="rowSingleName12"  ><%=cMemb2.getUser().getUserName()%></label><font color="grey"><label style="display:none;" name="labeluser2"  class="labelClass">(username)</label></font></center></p>
<p><center><label  class="labelClass0" style="display:none;" name="rowSingleName13"  ><%=cMemb2.getUser().getEmailAddress()%></label><font color="grey"><label style="display:none;" name="labelemail2"  class="labelClass">(email)</label></font></center></p>
<p><center><label  class="labelClass0" style="display:none;" name="rowSingleName14"   ><%=org.oscelot.utils.Utils.getRoleString("COURSE", cMemb2.getRole())%></label><font color="grey"><label style="display:none;"  name="labelrole2"  class="labelClass">(role)</label></font></center></p>
        
        </td>
       
<td colSpan="1" class="rowSingle1" valign="middle"><left><p><label  class="labelClass2" name="rowSingleName1"   ><%=cMemb2.getUser().getGivenName()%>&nbsp;<%=cMemb2.getUser().getFamilyName()%></label></p><p><font color="grey"><label  style="display:none;" name="labelfName" class="labelClass3">(First, Last)</label></font></p></left></td>
<td  colSpan="1" class="rowSingle1" valign="middle"><left><p><label   class="labelClass2" name="rowSingleName2"  ><%=cMemb2.getUser().getUserName()%></label></p><p><font color="grey"><label  style="display:none;" name="labeluser" class="labelClass3">(username)</label></font></p></left></td>
<td colSpan="1" class="rowSingle1" valign="middle"><left><p><label   class="labelClass2" name="rowSingleName3"  ><%=cMemb2.getUser().getEmailAddress()%></label></p><p><font color="grey"><label  style="display:none;" name="labelemail"  class="labelClass3">(email)</label></font></p></left></td>
<td colSpan="1" class="rowSingle1" valign="middle"><left><p><label   class="labelClass2" name="rowSingleName4"  ><%=org.oscelot.utils.Utils.getRoleString("COURSE", cMemb2.getRole())%></label></p><p><font color="grey"><label  style="display:none;" name="labelrole"  class="labelClass3">(role)</label></font></p></left></td>
</tr>


	

			</TABLE><H5></H5><TABLE class="inventory sortable $wrappingTableClass">
			
<tr>
			</bbNG:listElement>	
	
			
		

    </bbNG:inventoryList>
		</DIV>
			</td>	</center></tr>    

</tbody>
        </table>
        	</td></tr></table>
        	
      
	
	
	
	</div>
</bbNG:learningSystemPage>
