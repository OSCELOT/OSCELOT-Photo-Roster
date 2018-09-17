package org.oscelot.utils;

/* Nothing in this class has been tested

import java.io.File;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
*/

public class Uploader {
/*	
	Hashtable files = new Hashtable();
	Hashtable parameters = new Hashtable();
	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(this.factory);
	String directorySep = System.getProperty("file.separator");

	public String getParameter(String key) {
		return (String)this.parameters.get(key);
	}

	public boolean doFilePost(HttpServletRequest request, ServletContext context) {
		if (request.getContentType() == null) {
			return false;
		}
		if (!request.getContentType().startsWith("multipart/form-data")) {
			return false;
		}

		this.upload.setSizeMax(10 * Files.MB);
		this.factory.setSizeThreshold(4 * Files.KB);
		
		try {
			List fileItems = this.upload.parseRequest(request);

			Iterator i = fileItems.iterator();
			while (i.hasNext()) {
				FileItem file = (FileItem)i.next();

				String fileName = file.getName();
				fileName = getFileName(fileName);
				if (file.isFormField()) {
					this.parameters.put(file.getFieldName(), file.getString());
				} else {
					this.files.put(fileName, file);
					File file2upload = new File(Files.getUploadPath() + this.parameters.get("student_id") + ".jpg");

					file.write(file2upload);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return true;
	}

	public static String getFileName(String in) {
		String result = in;
		if (result != null) {
			if (result.indexOf("\\") > 0) {
				result = result.substring(result.lastIndexOf("\\") + 1, result.length());
			}

			if (result.indexOf("/") > 0) {
				result = result.substring(result.lastIndexOf("/") + 1, result.length());
			}

		}

		return result;
	}
*/
}