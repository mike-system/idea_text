package com.nf.easybuy.service.impl;

import com.nf.easybuy.domain.Permission;
import com.nf.easybuy.mapper.PermissionMapper;
import com.nf.easybuy.mapper.RoleMapper;
import com.nf.easybuy.mapper.UserMapper;
import com.nf.easybuy.service.IdentificationService;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-08
 * Time: 18:07
 */
public class IdentificationServiceImpl implements IdentificationService {

    private RoleMapper roleMapper;
    private PermissionMapper permissionMapper;

    public RoleMapper getRoleMapper() {
        return roleMapper;
    }

    public void setRoleMapper(RoleMapper roleMapper) {
        this.roleMapper = roleMapper;
    }


    public PermissionMapper getPermissionMapper() {
        return permissionMapper;
    }

    public void setPermissionMapper(PermissionMapper permissionMapper) {
        this.permissionMapper = permissionMapper;
    }

    @Override
    public List<Permission> getPermissionByUserId(Integer userId) {
        return permissionMapper.selectPermissionByUserId(userId);
    }

    @Override
    public List<Permission> getPermissionByRoleId(Integer roleId) {
        return permissionMapper.selectPermissionByRoleId(roleId);
    }
}
