package com.nf.easybuy.service;


import com.nf.easybuy.domain.Address;
import com.nf.easybuy.domain.Area;

import java.util.List;

public interface AddressService {

	//通过用户饿id获取地址
	List<Address> getAddressByUserId(Integer id);

	Address getAddressById(int id);

	List<Area> getAreaByParentId(int id);

	boolean update(Address addr, Integer addressId);

	boolean add(Address addr, Integer id);

	String getAreaNameById(String id);

	boolean setDefaultAddr(Integer addrId);

	boolean delAddr(String addrId);


}