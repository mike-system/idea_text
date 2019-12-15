package com.nf.easybuy.service;


import com.nf.easybuy.domain.ProductCategory;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public interface ProductCategoryService {

	List<ProductCategory> getProductCategoryByTypeAndParentid(int type, int parentid);

	List<ProductCategory> getProductCategory();

	int getProductCategoryCcount();

	List<ProductCategory> getProductCategoryLimit(PagingUtil<ProductCategory> paging);

	ProductCategory getProductCategoryById(int id);

	boolean updateProductCategoryById(ProductCategory pc);

	boolean saveProductCategory(ProductCategory pc);

	boolean delProductCatById(int id);

	int getProductCategoryCcountByParentId(int id);

	boolean getProductCategoryByName(String name);

}