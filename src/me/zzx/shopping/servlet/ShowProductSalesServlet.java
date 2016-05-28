package me.zzx.shopping.servlet;

import java.awt.Font;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.Dataset;
import org.jfree.data.general.DefaultPieDataset;

import me.zzx.shopping.ProductMgr;

/**
 * Servlet implementation class ShowProductSalesServlet
 */
@WebServlet("/ShowProductSalesServlet")

public class ShowProductSalesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowProductSalesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDataset cDataset = (CategoryDataset) getDatasets().get(0); 
  		DefaultPieDataset pDataset = (DefaultPieDataset) getDatasets().get(1); 
        
        //����������ʽ  
        StandardChartTheme standardChartTheme=new StandardChartTheme("CN");  
        //���ñ�������  
        standardChartTheme.setExtraLargeFont(new Font("����",Font.BOLD,20));  
        //����ͼ��������  
        standardChartTheme.setRegularFont(new Font("����",Font.BOLD,15));  
        //�������������  
        standardChartTheme.setLargeFont(new Font("����",Font.BOLD,15));  
        //Ӧ��������ʽ  
        ChartFactory.setChartTheme(standardChartTheme);  
        
        JFreeChart cChart = ChartFactory.createBarChart3D( 
                           "��Ʒ������״ͼ", // ͼ�����
                           "��Ʒ����", // Ŀ¼�����ʾ��ǩ
                           "����", // ��ֵ�����ʾ��ǩ
                            cDataset, // ���ݼ�
                            PlotOrientation.VERTICAL, // ͼ����ˮƽ����ֱ
                            true,  // �Ƿ���ʾͼ��(���ڼ򵥵���״ͼ������ false)
                            false, // �Ƿ����ɹ���
                            false  // �Ƿ����� URL ����
                            );
        

   		 JFreeChart pChart = ChartFactory.createPieChart("��Ʒ������״ͼ",  // ͼ�����
					   		 pDataset, 
					   		 true, // �Ƿ���ʾͼ��
					   		 false, 
					   		 false 
					   		 ); 
					   		 // дͼ������ļ���������״ͼ����Դ��
                           
        FileOutputStream cJpg = null;
        FileOutputStream pJpg = null; 
        try { 
            cJpg = new FileOutputStream("D:\\JavaProject2\\Shopping\\WebContent\\images\\chart\\categorychart.jpg");
            pJpg = new FileOutputStream("D:\\JavaProject2\\Shopping\\WebContent\\images\\chart\\piechart.jpg"); 
            ChartUtilities.writeChartAsJPEG(cJpg,1.0f,cChart,800,800,null);
            ChartUtilities.writeChartAsJPEG(pJpg,1.0f,pChart,800,800,null); 
            this.getServletContext().getRequestDispatcher("/admin/ShowProductSales.jsp").forward(request, response);
            //response.sendRedirect("admin/ShowProductSales.jsp"); 
        } finally { 
            try { 
                cJpg.close();
                pJpg.close();
            } catch (Exception e) {} 
        } 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

    private List<Dataset> getDatasets() { 
        return ProductMgr.getInstance().getDatasets();
    } 
}
