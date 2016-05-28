package me.zzx.shopping.dao;

import java.util.List;

import me.zzx.shopping.SalesItem;
import me.zzx.shopping.SalesOrder;
import me.zzx.shopping.User;

public class OrderOracleDAO implements OrderDAO {

	public boolean saveOrder(SalesOrder so) {
		return false;
	}

	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		return 0;
	}

	public SalesOrder loadById(int id) {
		return null;
	}

	public List<SalesItem> getItems(SalesOrder order) {
		return null;
	}

	public void updateStatus(SalesOrder order) {
	}

	public List<SalesOrder> getOrders(User u) {
		return null;
	}

}
