package com.nf.easybuy.domain;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Description:
 * User: nongfu 农夫
 * Date: 2019-11-08
 * Time: 17:55
 */
public class Permission {
    private Integer  id;
    private String name;
    private String url;
    private String type;
    private String percode;
    private Integer parent;
    private List<Role> roles;  //权限所分配的角色的集合

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getPercode() {
        return percode;
    }

    public void setPercode(String percode) {
        this.percode = percode;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
}
