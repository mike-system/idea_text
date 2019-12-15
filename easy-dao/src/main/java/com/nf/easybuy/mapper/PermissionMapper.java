package com.nf.easybuy.mapper;

import com.nf.easybuy.domain.Permission;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-08
 * Time: 18:09
 */
public interface PermissionMapper {

    /**
     *
     * @param roleId
     * @return 权限id
     */
    List<Permission> selectPermissionByRoleId(Integer roleId);

    List<Permission> selectPermissionByUserId(Integer userId);
}
