package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

	User login(@Param("loginname") String loginname, @Param("password") String password);

	int checkloginranme(@Param("loginname") String loginname, @Param("userId") Integer userId);

	int checkemail(@Param("email") String email, @Param("userId") Integer userId);

	int checkmobile(@Param("mobile") String mobile, @Param("userId") Integer userId);

	int save(User user);

	int saveByAdmin(User user);

	int updateByAdmin(User user);

	int update(User user);

	Integer getUserCount();

	List<User> getUsertLimit(@Param("start") int start, @Param("rows") int rows);

	User getUserById(int id);

	int delUserByid(int id);

	int checkIdentityCode(@Param("identityCode") String identityCode, @Param("userId") Integer userId);

    User selectUserByUserName(String username);
}