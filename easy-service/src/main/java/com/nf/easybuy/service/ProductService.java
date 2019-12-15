package com.nf.easybuy.service;


import com.nf.easybuy.domain.Product;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public interface ProductService {

	Product getProductById(int isDelete, int id);

	List<Product> getProducts(int isDelete);

	int getProductsByCategoryLevel1IdCount(int isDelete, Integer id);

	List<Product> getProductsByCategoryLevel1Id(int isDelete, int id, PagingUtil<Product> pagingInfo);

	int getProductsByCategoryLevel3IdCount(int isDelete, int id);

	List<Product> getProductsByCategoryLevel3Id(int isDelete, int id, PagingUtil<Product> pagingInfo);

	int getProductCountByProductCategory(int id, int flagIsDel);

	List<Product> getProductLimit(int isDel, PagingUtil<Product> pageProduct);

	Integer getProductCountCount(int isDel);

	boolean updateProductById(Product product);

	boolean addProduct(Product product);

	boolean update2delProductById(int id, int isDelete);

	int getProductListBySeekCount(String val);

	List<Product> getProductListBySeek(String val, PagingUtil<Product> productList);


}