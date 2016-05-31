package me.zzx.shopping.tag;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import me.zzx.shopping.Product;
import me.zzx.shopping.ProductMgr;

public class ProductListTag extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		List<Product> products = ProductMgr.getInstance().getProducts();
		for(Iterator<Product> it = products.iterator(); it.hasNext(); ) {
			Product p = it.next();
			this.getJspContext().getOut().write(p.getName() + " гд" + p.getNormalPrice() + "<br>");
		}
	}
	
}
