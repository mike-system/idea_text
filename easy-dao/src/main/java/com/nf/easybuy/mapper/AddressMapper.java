package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.Address;
import com.nf.easybuy.domain.Area;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AddressMapper {


	/**
	 *
	 * @param id
	 * @return
	 */
	Address getAddressById(int id);

	List<Area> getAreaByParentId(int parentid);

	int update(@Param("addr") Address addr, @Param("addressId") Integer addressId);

	int add(@Param("addr") Address addr, @Param("userId") Integer userId);

	//通过id获取到区域名
	String getAreaById(String id);

	/**
	 *
 	 * @return
	 */
	int updateAllAddressDefaultValueAsZero();

	/**
	 *
	 * @param addrId
	 * @return
	 */
	int updateDefaultAddressById(Integer addrId);


	//删除地址
	int delAddr(String addrId);

	/**
	 * 通过用户的id,获取所有的地址信息
	 * @param id
	 * @return
	 */
	List<Address> getAddressByUserId(Integer id);

}