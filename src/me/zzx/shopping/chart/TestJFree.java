package me.zzx.shopping.chart;

import java.awt.Font;
import java.io.*; 
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.*; 
import org.jfree.chart.plot.*; 
/** 
* ����������ʾ��򵥵���״ͼ����
* @author Winter Lau 
*/ 
public class TestJFree { 
    public static void main(String[] args) throws IOException{ 
        CategoryDataset dataset = getDataSet(); 
        
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
        
        JFreeChart chart = ChartFactory.createBarChart3D( 
                           "ˮ������ͼ", // ͼ�����
                           "ˮ��", // Ŀ¼�����ʾ��ǩ
                           "����", // ��ֵ�����ʾ��ǩ
                            dataset, // ���ݼ�
                            PlotOrientation.HORIZONTAL, // ͼ����ˮƽ����ֱ
                            true,  // �Ƿ���ʾͼ��(���ڼ򵥵���״ͼ������ false)
                            false, // �Ƿ����ɹ���
                            false  // �Ƿ����� URL ����
                            ); 
                           
        FileOutputStream fos_jpg = null; 
        try { 
            fos_jpg = new FileOutputStream("D:\\fruit.jpg"); 
            ChartUtilities.writeChartAsJPEG(fos_jpg,1.0f,chart,800,800,null); 
        } finally { 
            try { 
                fos_jpg.close(); 
            } catch (Exception e) {} 
        } 
    } 
    /** 
    * ��ȡһ����ʾ�õļ����ݼ�����
    * @return 
    */ 
    private static CategoryDataset getDataSet() { 
        DefaultCategoryDataset dataset = new DefaultCategoryDataset(); 
        dataset.addValue(100, "", "ƻ��"); 
        dataset.addValue(200, "", "����"); 
        dataset.addValue(300, "", "����"); 
        dataset.addValue(400, "", "�㽶"); 
        dataset.addValue(500, "", "��֦");
		return dataset; 
    } 
    /** 
    * ��ȡһ����ʾ�õ�������ݼ�����
    * @return 
    */ 
    private static CategoryDataset getDataSet2() { 
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        dataset.addValue(100, "����", "ƻ��"); 
        dataset.addValue(100, "�Ϻ�", "ƻ��"); 
        dataset.addValue(100, "����", "ƻ��"); 
        dataset.addValue(200, "����", "����"); 
        dataset.addValue(200, "�Ϻ�", "����"); 
        dataset.addValue(200, "����", "����"); 
        dataset.addValue(300, "����", "����"); 
        dataset.addValue(300, "�Ϻ�", "����"); 
        dataset.addValue(300, "����", "����"); 
        dataset.addValue(400, "����", "�㽶"); 
        dataset.addValue(400, "�Ϻ�", "�㽶"); 
        dataset.addValue(400, "����", "�㽶"); 
        dataset.addValue(500, "����", "��֦"); 
        dataset.addValue(500, "�Ϻ�", "��֦"); 
        dataset.addValue(500, "����", "��֦"); 
        return dataset; 
    } 
}