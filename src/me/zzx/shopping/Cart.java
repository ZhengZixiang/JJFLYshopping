package me.zzx.shopping;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<CartItem> items = new ArrayList<CartItem>();
	
	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}

	public boolean add(CartItem ci) {
		for(int i = 0; i < items.size(); i++) {
			CartItem item = items.get(i);
			 if(ci.getProductId() == item.getProductId()) {
				 item.setCount(item.getCount() + 1);
				 return true;
			 }
		}
		items.add(ci);
		return true;
	}
}
