package org.oscelot.utils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.oscelot.bbbeans.Settings;

public class Files {
	static String localURL;
	static String fileDirectory = "images";
	static String filePath = "/usr/local/blackboard/content/";
	static String remoteURL;
	public static final String[] allowedFileExtensions = { ".jpg" };
	public static int KB = 1024;
	public static int MB = 1048576;
	public static String directorySep = System.getProperty("file.separator");
	public static Settings settings = null;

	public static Files load() {
		settings = Settings.load();

		Files ff = new Files();

		filePath = settings.getFilePath();
		localURL = settings.getLocalURLRoot();
		remoteURL = settings.getRemoteURLRoot();
		fileDirectory = settings.getFileDirectory();

		return ff;
	}

	// does not appear to be used
	/*
	public boolean isBlockedFile(String fileName) {
		String lowerCaseName = fileName.toLowerCase();
		
		for (int i = 0; i < allowedFileExtensions.length; i++) {
			if (lowerCaseName.endsWith(allowedFileExtensions[i])) {
				return false;
			}
		}
		
		return true;
	}
	 */
	
	public static String getBasePath(ServletContext context) {
		return context.getRealPath(directorySep) + "WEB-INF" + directorySep;
	}

	public static String getTempPath(ServletContext context) {
		return getBasePath(context) + "tmp" + directorySep;
	}

	public static String getUploadPath() {
		return filePath + fileDirectory + directorySep;
	}

	public static String getRemoteURL() {
		return remoteURL + directorySep;
	}

	public static String getFilePath() {
		return filePath;
	}

	public static String getFileDirectory() {
		return fileDirectory;
	}

	public static String getImgUrlRoot(String studentId) {
		return directorySep + fileDirectory + directorySep + studentId + ".jpg";
	}

	public static String getDownloadPath(HttpServletRequest request) {
		return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
				+ "/" + getURLSafeFilePath() + "/" + fileDirectory;
	}

	public static String getURLSafeFilePath() {
		return filePath.replaceAll(directorySep, "/");
	}
}