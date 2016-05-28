package me.zzx.shopping.dao;

import java.util.List;

import me.zzx.shopping.SalesItem;
import me.zzx.shopping.SalesOrder;
import me.zzx.shopping.User;

public interface OrderDAO {
	public boolean saveOrder(SalesOrder so);

	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize);

	public SalesOrder loadById(int id);

	public List<SalesItem> getItems(SalesOrder order);

	public void updateStatus(SalesOrder order);

	public List<SalesOrder> getOrders(User u);
}
