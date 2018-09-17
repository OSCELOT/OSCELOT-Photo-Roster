package org.oscelot.photoroster;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.awt.image.ImageObserver;
import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

import javax.imageio.ImageIO;

import org.oscelot.bbbeans.Settings;
import org.oscelot.utils.Files;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PhotoRoster implements ImageObserver {
	private static Logger logger = LoggerFactory.getLogger(PhotoRoster.class);
	static Settings settings = Settings.load();
	static Image img = null;

	public static String directorySep = System.getProperty("file.separator");

	public static PhotoRoster load() {
		return new PhotoRoster();
	}

	/**
	 * Retrieve photo from local storage and return complete HTML img tag
	 *   using the width and length properties to "scale" the image
	 * 
	 * @param studentId
	 * @param maxDimension
	 * @return
	 */
	public static String getLocalScaledPhotoURL(String studentId, int maxDimension) {
		int calculatedWidth = 100;
		int calculatedHeight = 100;
		int actualWidth = 100;
		int actualHeight = 100;
		double calculatedReduction = 100.0D;
		
		BufferedImage image = null;
		try {
			image = ImageIO.read(new File(Files.getFilePath() + Files.getFileDirectory()
					+ directorySep + studentId + ".jpg"));
			actualWidth = image.getWidth();
			actualHeight = image.getHeight();

			if (actualHeight > maxDimension || actualWidth > maxDimension) {
				if (actualHeight > actualWidth) {
					calculatedReduction = (double) maxDimension / (double) actualHeight;
				} else {
					calculatedReduction = (double) maxDimension / (double) actualWidth;
				}
				calculatedHeight = (int)(calculatedReduction * actualHeight);
				calculatedWidth = (int)(calculatedReduction * actualWidth);			
			} else {
				calculatedHeight = actualHeight;
				calculatedWidth = actualWidth;
			}
		} catch (IOException e) {
			logger.error("Error scaling local file for student: {}", studentId, e);
			calculatedWidth = maxDimension;
			calculatedHeight = maxDimension;
		}
		
		return "<img src=\"../../../../../purdue" + Files.getFileDirectory() + "/" + studentId
				+ ".jpg" + "\"" + "width=\"" + calculatedWidth + "\" height=\"" + calculatedHeight + "\"/>";	
	}

	/**
	 * Retrieve photo from remote location and return URL with
	 *  the width and length properties to "scale" the image
	 *  
	 *  This method has not been tested!!
	 *   
	 * @param studentId
	 * @param maxDimension
	 * @return
	 */
	public static String getRemoteScaledPhotoURL(String studentId, int maxDimension) {
		URL url = null;
		int calculatedWidth = 100;
		int calculatedHeight = 100;
		int actualWidth = 100;
		int actualHeight = 100;
		double calculatedReduction = 100.0D;

		String remoteURLStr = settings.getRemoteURL(studentId);
		PhotoRoster pr = load();
		try {
			url = new URL(remoteURLStr);
			img = ImageIO.read(url);
			actualWidth = img.getWidth(pr);
			actualHeight = img.getHeight(pr);

			if (actualHeight > actualWidth) {
				if (actualHeight > maxDimension) {
					calculatedReduction = (double) maxDimension / (double) actualHeight;
					calculatedHeight = (int)(calculatedReduction * actualHeight);
					calculatedWidth = (int)(calculatedReduction * actualWidth);
				}
			} else if (actualWidth > actualHeight) {
				if (actualWidth > maxDimension) {
					calculatedReduction = (double) maxDimension / (double) actualHeight;
					calculatedHeight = (int)(calculatedReduction * actualHeight);
					calculatedWidth = (int)(calculatedReduction * actualWidth);
				}
			} else {
				calculatedHeight = actualHeight;
				calculatedWidth = actualWidth;
			}
		} catch (IOException e) {
			logger.error("Error scaling remote file for student: {}", studentId);
			logger.error("URL: {}", url);
			logger.error("",e);
		}

		return remoteURLStr + "\" \"width=\"" + calculatedWidth + "\" height=\"" + calculatedHeight + "\"";
	}

	/**
	 * Retrieve photo from remote location un-scaled
	 * 
	 * This method has not been tested!!
	 * 
	 * @param studentId
	 * @return
	 */
	public static String getRemotePhotoURL(String studentId) {
		return settings.getRemoteURL(studentId);
	}

	/**
	 * Retrieve scaled photo either from local storage or remote location 
	 * 
	 * @param studentId
	 * @param maxDimension
	 * @return
	 */
	public String getScaledPhotoURL(String studentId, int maxDimension) {
		String res = null;
		if (settings.getRemoteLocal().equals("local"))
			res = getLocalScaledPhotoURL(studentId, maxDimension);
		else {
			res = getRemoteScaledPhotoURL(studentId, maxDimension);
		}

		return res;
	}

	/**
	 * Retrieve photo from local storage un-scaled
	 * 
	 * @param studentId
	 * @return
	 */
	public static String getPhotoURL(String studentId) {
		return "<img src=\"../../../../../purdue" + Files.getFileDirectory() + "/" + studentId + ".jpg" + "\">";
	}

	/**
	 * Check if a photo exist for the user based on their Student ID
	 * 
	 * @param studentId
	 * @return
	 */
	public static boolean isThereAPhoto(String studentId) {
		Boolean res = Boolean.valueOf(false);
		URI url = null;
		
		try {
			Files.load();
	
			if (studentId == null || studentId.equalsIgnoreCase("")) {
				logger.warn("Student ID is null or blank for user");
				return res.booleanValue();
			}
			
			if (settings.getRemoteLocal().equals("local")) {
				File diskFile = new File(Files.getFilePath() + directorySep + Files.getFileDirectory()
						+ directorySep + studentId + ".jpg");
	
				if (diskFile.exists()) {
					logger.info("Found photo for user: {}",studentId);
					res = Boolean.valueOf(true);
				} else {
					logger.warn("No photo found for user: {}",studentId);
				}
			} else if (settings.getPhotoCheck().equals("true")) {
				try {
					HttpURLConnection con = (HttpURLConnection)new URL(settings.getRemoteURL(studentId)).openConnection();
	
					con.setRequestMethod("HEAD");
					res = Boolean.valueOf(con.getResponseCode() == 200);
				} catch (IOException e) {
					logger.error("Could not read URL: {}", url, e);
					res = Boolean.valueOf(false);
				}
			}
		} catch (Exception e) {
			logger.error("Error checking for a user photo", e);
		}

		return res.booleanValue();
	}

	/* (non-Javadoc)
	 * @see java.awt.image.ImageObserver#imageUpdate(java.awt.Image, int, int, int, int, int)
	 */
	public boolean imageUpdate(Image image, int flags, int x, int y, int width, int height) {
		if ((flags & 0x2) != 0) {
			logger.debug("Image height = {}", height);
		}
		if ((flags & 0x1) != 0) {
			logger.debug("Image width = {}", width);
		}
		if ((flags & 0x10) != 0) {
			logger.debug("Another frame finished.");
		}
		if ((flags & 0x8) != 0) {
			logger.debug("Image section: {}", new Rectangle(x, y, width, height));
		}
		if ((flags & 0x20) != 0) {
			logger.debug("Image finished!");
			return false;
		}
		if ((flags & 0x80) != 0) {
			logger.debug("Image load aborted...");
			return false;
		}

		return true;
	}
}