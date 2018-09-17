package org.oscelot.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import blackboard.data.navigation.NavigationItem;
import blackboard.persist.PersistenceException;
import blackboard.persist.navigation.NavigationItemDbLoader;

public class Utils {
	


	private static Logger logger = LoggerFactory.getLogger(Utils.class);
	
	public static String getRoleString(String type, Object role) {
		String uRole = "";
		if (type.equals("COURSE")) 	{
			if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.INSTRUCTOR) {
				uRole = "Instructor";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.STUDENT) {
				uRole = "Student";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.DEFAULT) {
				uRole = "Student";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.TEACHING_ASSISTANT) {
				uRole = "Teaching Assistant";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.GRADER) {
				uRole = "Grader";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.GUEST) {
				uRole = "Guest";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.COURSE_BUILDER) {
				uRole = "Course Builder";
			} else if ((blackboard.data.course.CourseMembership.Role)role == blackboard.data.course.CourseMembership.Role.NONE) {
				uRole = "No explicit role (NONE)";
			} else {
				uRole = "Cannot Identify Course Membership Role";
			}
		} else if (type.equals("SYSTEM")) {
			if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.ACCOUNT_ADMIN) {
				uRole = "Account Administrator";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.COURSE_CREATOR) {
				uRole = "Course creator";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.COURSE_SUPPORT) {
				uRole = "Course support";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.DEFAULT) {
				uRole = "User";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.GUEST) {
				uRole = "Guest";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.NONE) {
				uRole = "No explicit role (NONE)";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.OBSERVER) {
				uRole = "Observer";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.SYSTEM_ADMIN) {
				uRole = "System Administrator";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.SYSTEM_SUPPORT) {
				uRole = "System support";
			} else if ((blackboard.data.user.User.SystemRole)role == blackboard.data.user.User.SystemRole.USER) {
				uRole = "User";
			} else {
				uRole = "Cannot Identify User System Role";
			}
		} else {
			uRole = "TYPE not qualified in method.";
		}

		return uRole;
	}

	public static NavigationItem getNavigationItem(String name) {
		NavigationItem navItem = null;
		try {
			NavigationItemDbLoader niLoader = NavigationItemDbLoader.Default.getInstance();
			navItem = niLoader.loadByInternalHandle(name);
		} catch (PersistenceException e) {
			logger.error("",e);
			navItem = null;
		}
		
		return navItem;
	}
}