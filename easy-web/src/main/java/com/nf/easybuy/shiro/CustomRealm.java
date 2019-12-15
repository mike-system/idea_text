package com.nf.easybuy.shiro;

import com.nf.easybuy.domain.User;
import com.nf.easybuy.service.UserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.util.HashSet;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * Description: 自定义realm
 * User: nongfu 农夫
 * Date: 2019-11-07
 * Time: 16:08
 */
public class CustomRealm extends AuthorizingRealm {

    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    //授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        //从principal中获取用户登录信息
        User primaryPrincipal = (User) principalCollection.getPrimaryPrincipal();

        //利用登录信息来验证当前用户的角色和权限
        Set<String> roles = new HashSet<>();
        roles.add("user");
        if("admin".equals(primaryPrincipal.getLoginName())){
            roles.add("admin");
        }

        //创建SimpleAuthorizationInfo对象，
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo(roles);

        return authorizationInfo;
    }

    //认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        String username = (String) authenticationToken.getPrincipal();


        //根据用户名再数据库中查找
        User user = userService.getUserByUserName(username);

        //获取到用户的密码
        String password = user.getPassword();

        if (user != null) {//密码盐

            SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user, password, ByteSource.Util.bytes(username), this.getName());

            return authenticationInfo;
        } else {
            return null;
        }

    }
}
