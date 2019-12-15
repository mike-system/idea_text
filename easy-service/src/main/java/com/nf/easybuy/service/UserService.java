package com.nf.easybuy.service;


import com.nf.easybuy.domain.User;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public interface UserService {

	User login(String loginname, String password);

	boolean checkloginranme(String loginname, Integer userId);

	boolean checkemail(String email, Integer userId);

	boolean checkmobile(String mobile, Integer userId);

	boolean save(User user);

	boolean update(User user);

	Integer getUserCount();

	List<User> getUsertLimit(PagingUtil<User> pageUser);

	User getUserById(int id);

	boolean updateByAdmin(User user);

	boolean saveByAdmin(User user);

	boolean delUserByid(int id);

	boolean checkIdentityCode(String identityCode, Integer userId);

    User getUserByUserName(String username);
}