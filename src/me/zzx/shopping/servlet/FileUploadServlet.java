package me.zzx.shopping.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(
		name = "FileUploadServlet",
		urlPatterns = "/FileUploadServlet",
		initParams = {
				@WebInitParam(name = "uploadPath", value="D:\\JavaProject2\\Shopping\\WebContent\\images\\product\\"),
				@WebInitParam(name = "tempPath", value="D:\\temp\\")
		}
)

public class FileUploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
    private String uploadPath = ""; // �ϴ��ļ���Ŀ¼
    private String tempPath = ""; // ��ʱ�ļ�Ŀ¼
    
    
    File tempPathFile;
    File uploadPathFile;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);  
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		// Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();
	 
		// Set factory constraints
		factory.setSizeThreshold(1024*4); // �����ڴ滺������С��������4kb
		factory.setRepository(tempPathFile); // ������������������С������Ӳ�̵�������
	 
        // Create a new file upload handler
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    upload.setHeaderEncoding("UTF-8"); // ���ñ���
	    upload.setSizeMax(1024*1024*40); // Set overall request size constraint ��������ļ��ߴ磬������4MB
	    
	    int id = 0;
	    
	    try {
		    List<FileItem> items = upload.parseRequest(request);// �õ����е��ļ�
		    for(Iterator<FileItem> it = items.iterator(); it.hasNext(); ) {
			    FileItem fi = (FileItem) it.next();
			    
			    if(fi.isFormField()) { // ����Ǳ��ؼ���ȡ������
			    	String value = fi.getString();
				    String fieldName = fi.getFieldName();  //�õ���ǩname
				    if(fieldName.equals("id")) id = Integer.parseInt(fi.getString());
			    	System.out.println("[" + fieldName + "] " + value);
			    	
			    } else { // �����ϴ��ļ�
			    	String fileName = fi.getName(); 	//����ļ�����·��
				    String regex = ".+\\\\(.+)$";		//����ƥ�����·��ȡ�ļ���
				    String [] errorType = {".exe", ".txt", ".jsp", ".html", ".com", ".cgi"};
				    Pattern p = Pattern.compile(regex);
				    long size = fi.getSize(); 			//����ļ���С
				    
			    	if (fileName == null || fileName.trim().equals("") || size == 0) continue;
			    	Matcher m = p.matcher(fileName);
			    	if(m.find()) {
			    		for(int temp = 0; temp < errorType.length; temp++) {
			    			if(m.group(1).endsWith(errorType[temp])) 
			    				throw new IOException(fileName + ": Wrong Type!");
			    		}
			    		
				    	try {
					    	//fi.write(new File(uploadPath + id + "_" + m.group(1))); // д��Ӳ��
				    		fi.write(new File(uploadPath + id + ".jpg"));
				    	} catch(Exception e) {
				    		out.println("Failed To Upload!");
				    		continue;
				    	}
				    }
			    	out.println("Upload Successful!");
			    }
			    
		    }
	    } catch(FileUploadException e) {
	    	out.println(e);
	    }
	}
		 

	public void init(ServletConfig config) throws ServletException {
		uploadPath = config.getInitParameter("uploadPath");
		tempPath = config.getInitParameter("tempPath");
//System.out.println(uploadPath + tempPath);
		uploadPathFile = new File(uploadPath);
		if (!uploadPathFile.exists()) {
			uploadPathFile.mkdirs();
		}
		tempPathFile = new File(tempPath);
		if (!tempPathFile.exists()) {
			tempPathFile.mkdirs();
		}
	}
	
	
}

