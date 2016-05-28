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
	
    private String uploadPath = ""; // 上传文件的目录
    private String tempPath = ""; // 临时文件目录
    
    
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
		factory.setSizeThreshold(1024*4); // 设置内存缓冲区大小，这里是4kb
		factory.setRepository(tempPathFile); // 如果超过这个缓冲区大小，就拿硬盘当缓冲区
	 
        // Create a new file upload handler
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    upload.setHeaderEncoding("UTF-8"); // 设置编码
	    upload.setSizeMax(1024*1024*40); // Set overall request size constraint 设置最大文件尺寸，这里是4MB
	    
	    int id = 0;
	    
	    try {
		    List<FileItem> items = upload.parseRequest(request);// 得到所有的文件
		    for(Iterator<FileItem> it = items.iterator(); it.hasNext(); ) {
			    FileItem fi = (FileItem) it.next();
			    
			    if(fi.isFormField()) { // 如果是表单控件，取出内容
			    	String value = fi.getString();
				    String fieldName = fi.getFieldName();  //得到标签name
				    if(fieldName.equals("id")) id = Integer.parseInt(fi.getString());
			    	System.out.println("[" + fieldName + "] " + value);
			    	
			    } else { // 否则上传文件
			    	String fileName = fi.getName(); 	//获得文件完整路径
				    String regex = ".+\\\\(.+)$";		//正则匹配过滤路径取文件名
				    String [] errorType = {".exe", ".txt", ".jsp", ".html", ".com", ".cgi"};
				    Pattern p = Pattern.compile(regex);
				    long size = fi.getSize(); 			//获得文件大小
				    
			    	if (fileName == null || fileName.trim().equals("") || size == 0) continue;
			    	Matcher m = p.matcher(fileName);
			    	if(m.find()) {
			    		for(int temp = 0; temp < errorType.length; temp++) {
			    			if(m.group(1).endsWith(errorType[temp])) 
			    				throw new IOException(fileName + ": Wrong Type!");
			    		}
			    		
				    	try {
					    	//fi.write(new File(uploadPath + id + "_" + m.group(1))); // 写入硬盘
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

