package com.nf.easybuy.service.impl;

import com.nf.easybuy.domain.User;
import com.nf.easybuy.mapper.UserMapper;
import com.nf.easybuy.service.UserService;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserMapper userMapper;

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    /**
     * 登录
     *
     * @param loginname
     * @param password
     * @return 当前登录成功的用户
     */
    public User login(String loginname, String password) {
        System.out.println("用户 = " + userMapper.login(loginname, password).getRoles());
        return userMapper.login(loginname, password);
    }

    public boolean checkloginranme(String loginname, Integer userId) {

        if (userMapper.checkloginranme(loginname, userId) > 0)
            return true;
        return false;
    }

    public boolean checkemail(String email, Integer userId) {
        if (userMapper.checkemail(email, userId) > 0)
            return true;
        return false;
    }

    public boolean checkmobile(String mobile, Integer userId) {
        if (userMapper.checkmobile(mobile, userId) > 0)
            return true;
        return false;

        //判断assert是否为null，如果为null
    }

    public boolean save(User user) {
        if (userMapper.save(user) > 0)
            return true;
        return false;
    }

    public boolean update(User user) {
        int count = userMapper.update(user);
        if (count >= 1)
            return true;
        return false;
    }

    public Integer getUserCount() {

        return userMapper.getUserCount();
    }

    public List<User> getUsertLimit(PagingUtil<User> pageUser) {

        return userMapper.getUsertLimit(pageUser.getStart(), pageUser.getRows());
    }

    public User getUserById(int id) {
        return userMapper.getUserById(id);
    }

    public boolean updateByAdmin(User user) {
        int count = userMapper.updateByAdmin(user);
        if (count >= 1)
            return true;
        return false;
    }

    public boolean saveByAdmin(User user) {

        if (userMapper.saveByAdmin(user) > 0)
            return true;
        return false;

    }

    public boolean delUserByid(int id) {
        int count = userMapper.delUserByid(id);
        if (count >= 1)
            return true;
        return false;
    }

    public boolean checkIdentityCode(String identityCode, Integer userId) {
        int count = userMapper.checkIdentityCode(identityCode, userId);
        if (count > 0)
            return true;
        return false;
    }

    /**
     * 根据用户名获取到该用户， 认证用户
     *
     * @param username
     * @return 当前用户对象
     */
    @Override
    public User getUserByUserName(String username) {
        return userMapper.selectUserByUserName(username);
    }

}
