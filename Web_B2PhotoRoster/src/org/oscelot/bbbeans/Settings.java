package org.oscelot.bbbeans;

import org.oscelot.photoroster.PhotoRoster;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import blackboard.data.ValidationException;
import blackboard.persist.PersistenceException;
import blackboard.portal.data.ExtraInfo;
import blackboard.portal.data.PortalExtraInfo;
import blackboard.portal.servlet.PortalUtil;

public class Settings {
	private static Logger logger = LoggerFactory.getLogger(PhotoRoster.class);
	
	private String blackboardPath;
	private String filePath;
	private String fileDirectory;
	private String remoteLocal;
	private String localURLRoot;
	private String remoteURLRoot;
	private String enableInstructorUpload;
	private String doneOnce;
	private String filenameID;
	private String scalePhotos;
	private String scaledPhotoExtents;
	private String photoCheck;
	private String allowableCourseRoles;

	public Settings() {
		this.blackboardPath = "Not Set";
		this.filePath = "Not Set";
		this.fileDirectory = "Not Set";
		this.remoteLocal = "Not Set";
		this.localURLRoot = "Not Set";
		this.remoteURLRoot = "Not Set";
		this.enableInstructorUpload = "Not Set";
		this.filenameID = "Not Set";
		this.scalePhotos = "Not Set";
		this.scaledPhotoExtents = "90";
		this.doneOnce = "Not Set";
		this.photoCheck = "Not Set";
		this.allowableCourseRoles = "Not Set";
	}

	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getRemoteLocal() {
		return this.remoteLocal;
	}

	public void setRemoteLocal(String remoteLocal) {
		this.remoteLocal = remoteLocal;
	}

	public String getRemoteURLRoot() {
		return this.remoteURLRoot;
	}

	public String getRemoteURL(String studentId) {
		String url = this.remoteURLRoot.replace("<X@X-ID-X@X>", studentId);
		url = url.replace("<X@X-EXTENSION-X@X>", ".jpg");

		return url;
	}

	public void setRemoteURLRoot(String remoteURLRoot) {
		this.remoteURLRoot = remoteURLRoot;
	}
	public String getEnableInstructorUpload() {
		return this.enableInstructorUpload;
	}

	public void setEnableInstructorUpload(String enableInstructorUpload) {
		this.enableInstructorUpload = enableInstructorUpload;
	}

	public void setDoneOnce(String value) {
		this.doneOnce = value;
	}

	public String getDoneOnce() {
		return this.doneOnce;
	}

	public void setFileDirectory(String fileDir) {
		this.fileDirectory = fileDir;
	}

	public String getFileDirectory() {
		return this.fileDirectory;
	}

	public void setBlackboardPath(String blackboardPath) {
		this.blackboardPath = blackboardPath;
	}

	public String getBlackboardPath() {
		return this.blackboardPath;
	}

	public void setLocalURLRoot(String localURLRoot) {
		this.localURLRoot = localURLRoot;
	}

	public String getLocalURLRoot() {
		return this.localURLRoot;
	}

	public void setFilenameID(String filenameID) {
		this.filenameID = filenameID;
	}

	public String getFilenameID() {
		return this.filenameID;
	}

	public void setScalePhotos(String scalePhotos) {
		this.scalePhotos = scalePhotos;
	}

	public String getScalePhotos() {
		return this.scalePhotos;
	}

	public void setScaledPhotoExtents(String scaledPhotoExtents) {
		this.scaledPhotoExtents = scaledPhotoExtents;
	}

	public String getScaledPhotoExtents() {
		return this.scaledPhotoExtents;
	}

	public void setPhotoCheck(String photoCheck) {
		this.photoCheck = photoCheck;
	}

	public String getPhotoCheck() {
		return this.photoCheck;
	}

	public String getAllowableCourseRoles() {
		return allowableCourseRoles;
	}

	public void setAllowableCourseRoles(String allowableCourseRoles) {
		this.allowableCourseRoles = allowableCourseRoles;
	}

	/**
	 * Load values stored in BBLEARN.PORTAL_EXTRA_INFO
	 * 
	 * @return
	 */
	public static Settings load() {
		Settings settings = new Settings();
		try {
			PortalExtraInfo pei = PortalUtil.loadPortalExtraInfo(null, null, "photoroster");
			ExtraInfo ei = pei.getExtraInfo();

			if (null == ei.getValue("doneOnce")) {
				ei.setValue("filePath", settings.getFilePath());
				ei.setValue("fileDirectory", settings.getFileDirectory());
				ei.setValue("remoteLocal", settings.getRemoteLocal());
				ei.setValue("localURLRoot", settings.getRemoteURLRoot());
				ei.setValue("remoteURLRoot", settings.getRemoteURLRoot());
				ei.setValue("enableInstructorUpload", settings.getEnableInstructorUpload());
				ei.setValue("filenameID", settings.getFilenameID());
				ei.setValue("scalePhotos", settings.getScalePhotos());
				ei.setValue("scaledPhotoExtents", settings.getScaledPhotoExtents());
				ei.setValue("photoCheck", settings.getPhotoCheck());
				ei.setValue("allowableCourseRoles", settings.getAllowableCourseRoles());
			}

			settings.setFilePath(ei.getValue("filePath"));
			settings.setFileDirectory(ei.getValue("fileDirectory"));
			settings.setRemoteLocal(ei.getValue("remoteLocal"));
			settings.setLocalURLRoot(ei.getValue("localURLRoot"));
			settings.setRemoteURLRoot(ei.getValue("remoteURLRoot"));
			settings.setEnableInstructorUpload(ei.getValue("enableInstructorUpload"));
			settings.setFilenameID(ei.getValue("filenameID"));
			settings.setScalePhotos(ei.getValue("scalePhotos"));
			settings.setDoneOnce(ei.getValue("doneOnce"));
			settings.setScaledPhotoExtents(ei.getValue("scaledPhotoExtents"));
			settings.setPhotoCheck(ei.getValue("photoCheck"));
			settings.setAllowableCourseRoles(ei.getValue("allowableCourseRoles"));
		} catch (Throwable t) {
			logger.error("Unable to load application settings", t);
		}
		
		return settings;
	}

	/**
	 * Save values to BBLEARN.PORTAL_EXTRA_INFO
	 * 
	 * @throws PersistenceException
	 * @throws ValidationException
	 */
	public void persist() throws PersistenceException, ValidationException {
		PortalExtraInfo pei = PortalUtil.loadPortalExtraInfo(null, null, "photoroster");
		ExtraInfo ei = pei.getExtraInfo();
		ei.setValue("remoteLocal", getRemoteLocal());
		ei.setValue("enableInstructorUpload", getEnableInstructorUpload());

		ei.setValue("filePath", getFilePath());
		ei.setValue("fileDirectory", getFileDirectory());
		ei.setValue("remoteURLRoot", getRemoteURLRoot());
		ei.setValue("localURLRoot", getLocalURLRoot());
		ei.setValue("filenameID", getFilenameID());
		ei.setValue("scalePhotos", getScalePhotos());
		ei.setValue("scaledPhotoExtents", getScaledPhotoExtents());
		ei.setValue("photoCheck", getPhotoCheck());
		ei.setValue("allowableCourseRoles", getAllowableCourseRoles());
		ei.setValue("doneOnce", "y");

		PortalUtil.savePortalExtraInfo(pei);
	}
}