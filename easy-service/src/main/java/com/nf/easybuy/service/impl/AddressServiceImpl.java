package com.nf.easybuy.service.impl;

import com.nf.easybuy.domain.Address;
import com.nf.easybuy.domain.Area;
import com.nf.easybuy.mapper.AddressMapper;
import com.nf.easybuy.service.AddressService;

import java.util.List;

public class AddressServiceImpl implements AddressService {

	private AddressMapper addressMapper;

	public void setAddressMapper(AddressMapper addressMapper) {
		this.addressMapper = addressMapper;
	}


	//通过用户饿id获取地址
	public List<Address> getAddressByUserId(Integer id) {
		return addressMapper.getAddressByUserId(id);
	}

	public Address getAddressById(int id) {
		return addressMapper.getAddressById(id);
	}

	public List<Area> getAreaByParentId(int id) {
		
		return addressMapper.getAreaByParentId(id);
	}

	public boolean update(Address addr, Integer addressId) {
		if(addressMapper.update(addr,addressId)>=1)
			return true;
		return false;
	}

	public boolean add(Address addr, Integer id) {
		if(addressMapper.add(addr,id)>=1)
			return true;
		return false;
	}
	
	public String getAreaNameById(String id) {
		
		return addressMapper.getAreaById(id);
	}

	public boolean setDefaultAddr(Integer addrId) {
		int count1 = addressMapper.updateAllAddressDefaultValueAsZero();

		int count2 = addressMapper.updateDefaultAddressById(addrId);

		if(count1 >= 1 && count2 >=1 ){
			return true;
		}
		return false;
	}

	public boolean delAddr(String addrId) {
		int count = addressMapper.delAddr(addrId);
		if(count >= 1)
			return true;
		return false;
	}

	
}
