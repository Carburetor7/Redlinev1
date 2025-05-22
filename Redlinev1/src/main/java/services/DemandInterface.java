package services;

import java.util.List;

import models.Demand;

public interface DemandInterface {
	public boolean addProduct(String userId, String prodId, int demandQty);

	public boolean addProduct(Demand userDemandBean);

	public boolean removeProduct(String userId, String prodId);

	public List<Demand> haveDemanded(String prodId);
}
