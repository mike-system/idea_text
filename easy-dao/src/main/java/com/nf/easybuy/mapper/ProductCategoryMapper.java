package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.ProductCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductCategoryMapper {

	//获取所有的数据
	List<ProductCategory> getProductCategory();

	//根据条件查询 1 .根据类型查询
	List<ProductCategory> getProductCategoryByTypeAndParentid(@Param("type") int type, @Param("parentid") int parentid);

	int getProductCategoryCount();

	List<ProductCategory> getProductCategoryLimit(@Param("start") int start, @Param("rows") Integer rows);

	ProductCategory getProductCategoryById(int id);

	int updateProductCategoryById(ProductCategory pc);

	int saveProductCategory(ProductCategory pc);

	int delProductCatById(int id);

	int getProductCategoryCountByParentId(int parentId);

	int getProductCategoryByName(String name);

}