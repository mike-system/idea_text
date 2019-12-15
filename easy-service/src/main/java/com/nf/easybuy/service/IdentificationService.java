package com.nf.easybuy.service;

import com.nf.easybuy.domain.Permission;
import com.nf.easybuy.domain.Role;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-08
 * Time: 17:54
 */
public interface IdentificationService {


    /**
     * 通过用户id查询到用户的所有的权限
     * @param  userId
     * @return 权限的集合
     */
    List<Permission> getPermissionByUserId(Integer userId);

    /**
     * 通过角色查询该角色的所有的权限
     *
     * @param roleId
     * @return 权限的集合
     *
     */
    List<Permission> getPermissionByRoleId(Integer roleId);


}
