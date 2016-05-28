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
        
        //创建主题样式  
        StandardChartTheme standardChartTheme=new StandardChartTheme("CN");  
        //设置标题字体  
        standardChartTheme.setExtraLargeFont(new Font("隶书",Font.BOLD,20));  
        //设置图例的字体  
        standardChartTheme.setRegularFont(new Font("宋书",Font.BOLD,15));  
        //设置轴向的字体  
        standardChartTheme.setLargeFont(new Font("宋书",Font.BOLD,15));  
        //应用主题样式  
        ChartFactory.setChartTheme(standardChartTheme);  
        
        JFreeChart cChart = ChartFactory.createBarChart3D( 
                           "商品销量柱状图", // 图表标题
                           "商品名称", // 目录轴的显示标签
                           "销量", // 数值轴的显示标签
                            cDataset, // 数据集
                            PlotOrientation.VERTICAL, // 图表方向：水平、垂直
                            true,  // 是否显示图例(对于简单的柱状图必须是 false)
                            false, // 是否生成工具
                            false  // 是否生成 URL 链接
                            );
        

   		 JFreeChart pChart = ChartFactory.createPieChart("商品销量饼状图",  // 图表标题
					   		 pDataset, 
					   		 true, // 是否显示图例
					   		 false, 
					   		 false 
					   		 ); 
					   		 // 写图表对象到文件，参照柱状图生成源码
                           
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
