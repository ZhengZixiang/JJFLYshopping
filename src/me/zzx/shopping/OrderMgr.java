package me.zzx.shopping;

import java.util.List;

import me.zzx.shopping.dao.OrderDAO;
import me.zzx.shopping.dao.OrderMysqlDAO;

public class OrderMgr {
	private OrderDAO dao;

	private static OrderMgr om = null;
	
	static {
		if(om == null) {
			om = new OrderMgr();
			om.setDao(new OrderMysqlDAO());
		}
	}
	
	public static OrderMgr getInstance() {
		return om;
	}
	
	public OrderDAO getDao() {
		return dao;
	}

	public void setDao(OrderMysqlDAO dao) {
		this.dao = dao;
	}
	
	public boolean saveOrder(SalesOrder so) {
		return dao.saveOrder(so);
	}
	
	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		return dao.getOrders(orders, pageNo, pageSize);
	}
	
	public SalesOrder loadById(int id) {
		return dao.loadById(id);
	}

	public List<SalesItem> getItems(SalesOrder order) {
		return dao.getItems(order);
	}


	public void updateStatus(SalesOrder so) {
		dao.updateStatus(so);
	}
	
	public List<SalesOrder> getOrders(User u) {
		return dao.getOrders(u);
	}
}
