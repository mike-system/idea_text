package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {

	Product getProductById(@Param("isDelete") int isDelete, @Param("id") int id);

	List<Product> getAllProducts(int isDelete);

	//获取整体的记录数
	int getProductsByCategoryLevel1IdCount(@Param("isDelete") int isDelete, @Param("id") Integer id);

	//返回list集合
	List<Product> getProductsByCategoryLevel1Id(@Param("isDelete") int isDelete, @Param("id") int id, @Param("currentPage") Integer currentPage, @Param("rows") Integer rows);

	int getProductsByCategoryLevel3IdCount(@Param("isDelete") int isDelete, @Param("id") int id);

	List<Product> getProductsByCategoryLevel3Id(@Param("isDelete") int isDelete, @Param("id") int id, @Param("currentPage") Integer currentPage, @Param("rows") Integer rows);

	int getProductCountByProductCategory(@Param("id") int id, @Param("flagIsDel") int flagIsDel);

	List<Product> getProductLimit(@Param("isDel") int isDel, @Param("start") Integer start, @Param("rows") Integer rows);

	Integer getProductCountCount(int isDel);

	int updateProductById(Product product);

	int addProduct(Product product);

	int update2delProductById(@Param("id") int id, @Param("isDelete") int isDelete);

	int getProductListBySeekCount(String val);

	List<Product> getProductListBySeek(@Param("val") String val, @Param("start") int start, @Param("rows") Integer rows);

}