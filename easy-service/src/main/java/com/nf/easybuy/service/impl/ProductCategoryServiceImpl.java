package com.nf.easybuy.service.impl;


import com.nf.easybuy.domain.ProductCategory;
import com.nf.easybuy.mapper.ProductCategoryMapper;
import com.nf.easybuy.service.ProductCategoryService;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public class ProductCategoryServiceImpl implements ProductCategoryService {
	private ProductCategoryMapper productCategoryMapper;

	public void setProductCategoryMapper(ProductCategoryMapper productCategoryMapper) {
		this.productCategoryMapper = productCategoryMapper;
	}

	/**
	 *
	 * @param type
	 * @param parentid
	 * @return
	 */
	public List<ProductCategory> getProductCategoryByTypeAndParentid(int type, int parentid){
		return productCategoryMapper.getProductCategoryByTypeAndParentid(type, parentid);
	}

	/**
	 *
	 * @return
	 */
	public List<ProductCategory> getProductCategory() {
		return productCategoryMapper.getProductCategory();
	}

	/**
	 * 获取记录数
	 * @return
	 */
	public int getProductCategoryCcount() {
		return productCategoryMapper.getProductCategoryCount();
	}
	public List<ProductCategory> getProductCategoryLimit(PagingUtil<ProductCategory> paging) {
		//获取到当前的每一页要显示的个数
		Integer rows = paging.getRows();
		int start = paging.getStart();
		return  productCategoryMapper.getProductCategoryLimit(start,rows);
	}
	public ProductCategory getProductCategoryById(int id) {
		return productCategoryMapper.getProductCategoryById(id);
	}
	public boolean updateProductCategoryById(ProductCategory pc) {
		int count = 0;
		count =  productCategoryMapper.updateProductCategoryById(pc);
		if(count > 0)		
			return true;
		return false;
	}
	public boolean saveProductCategory(ProductCategory pc) {
		int count = 0;
		count =  productCategoryMapper.saveProductCategory(pc);
		if(count > 0)		
			return true;
		return false;
	}
	public boolean delProductCatById(int id) {
		int count = 0;
		count =  productCategoryMapper.delProductCatById(id);
		if(count > 0)		
			return true;
		return false;
	}
	public int getProductCategoryCcountByParentId(int id) {
		return productCategoryMapper.getProductCategoryCountByParentId(id);
	}
	public boolean getProductCategoryByName(String name) {
		int count = productCategoryMapper.getProductCategoryByName(name);
		if(count > 0)
			return true;
		else
			return false;
	}
}
