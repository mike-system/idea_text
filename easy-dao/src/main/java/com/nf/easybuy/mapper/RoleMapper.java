package com.nf.easybuy.mapper;

import com.nf.easybuy.domain.Role;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-08
 * Time: 18:09
 */
public interface RoleMapper {
    /**
     * 通过id 获取到role的集合
     * @return role集合
     */
    List<Role> selectRoleByPerMissionId(Integer permissionId);

    /**
     * 通过用户的id查询到用户的所有的角色
     * @param userId 用户id
     * @return 角色
     */
    List<Role> selectRolesByUserId(Integer userId);

}
