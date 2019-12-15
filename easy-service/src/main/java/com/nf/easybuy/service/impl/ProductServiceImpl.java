package com.nf.easybuy.service.impl;

import com.nf.easybuy.domain.Product;
import com.nf.easybuy.mapper.ProductMapper;
import com.nf.easybuy.service.ProductService;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public class ProductServiceImpl implements ProductService {
	private ProductMapper productMapper;
	public void setProductMapper(ProductMapper productMapper) {
		this.productMapper = productMapper;
	}

	public Product getProductById(int isDelete, int id) {
		return productMapper.getProductById(isDelete,id);
	}
	public List<Product> getProducts(int isDelete) {
		return productMapper.getAllProducts(isDelete);
	}
	public int getProductsByCategoryLevel1IdCount(int isDelete,Integer id) {
		return productMapper.getProductsByCategoryLevel1IdCount(isDelete,id);
	}
	public List<Product> getProductsByCategoryLevel1Id(int isDelete,int id, PagingUtil<Product> pagingInfo) {
		return productMapper.getProductsByCategoryLevel1Id(isDelete,id,pagingInfo.getStart(),pagingInfo.getRows());
	}
	public int getProductsByCategoryLevel3IdCount(int isDelete,int id) {
		return productMapper.getProductsByCategoryLevel3IdCount(isDelete,id);
	}
	public List<Product> getProductsByCategoryLevel3Id(int isDelete,int id, PagingUtil<Product> pagingInfo) {
		return productMapper.getProductsByCategoryLevel3Id(isDelete,id,pagingInfo.getStart(),pagingInfo.getRows());
	}
	public int getProductCountByProductCategory(int id, int flagIsDel) {
		return productMapper.getProductCountByProductCategory(id,flagIsDel);
	}
	public List<Product> getProductLimit(int isDel, PagingUtil<Product> pageProduct) {
		int start = pageProduct.getStart();
		Integer rows = pageProduct.getRows();
		return productMapper.getProductLimit(isDel,start,rows);
	}
	public Integer getProductCountCount(int isDel) {
		return productMapper.getProductCountCount(isDel);
	}
	public boolean updateProductById(Product product) {
		if(productMapper.updateProductById(product) > 0)
			return true;
		return false;
	}
	public boolean addProduct(Product product) {
		if(productMapper.addProduct(product) > 0)
			return true;
		return false;
	}
	public boolean update2delProductById(int id,int isDelete) {
		if(productMapper.update2delProductById(id,isDelete) > 0)
			return true;
		return false;
	}
	public int getProductListBySeekCount(String val) {
		return productMapper.getProductListBySeekCount(val);
	}
	public List<Product> getProductListBySeek(String val, PagingUtil<Product> productList) {
		return productMapper.getProductListBySeek(val,productList.getStart(),productList.getRows());
	}


}
