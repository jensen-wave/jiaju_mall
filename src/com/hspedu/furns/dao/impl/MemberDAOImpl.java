package com.hspedu.furns.dao.impl;

import com.hspedu.furns.dao.BasicDAO;
import com.hspedu.furns.dao.MemberDAO;
import com.hspedu.furns.entity.Member;


public class MemberDAOImpl extends BasicDAO<Member> implements MemberDAO {

    /**
     * 通過用戶名返回對應的Member
     *
     * @param username 用戶名
     * @return 對應的Member, 如果沒有該Member, 返回 null
     */
    @Override
    public Member queryMemberByUsername(String username) {
        //老師提示，sql 先在sqlyog 測試，然後再拿到程式中
        //這裡可以提高我們的開發效率，減少不必要的bug
        String sql="SELECT `username`,`password`,`email` FROM member WHERE `username`=?";
        return querySingle(sql, Member.class,username);
    }

    /**
     * 保存一個會員
     *
     * @param member 傳入Member對象
     * @return 返回-1 就是失敗，返回其它的數位就是受影響的行數
     */
    @Override
    public int saveMember(Member member) {
        String sql="INSERT INTO member (`username`,`password`,`email`) VALUES(?,MD5(?),?)";
        return update(sql,member.getUsername(),member.getPassword(),member.getEmail());
    }

    @Override
    public Member queryMemberByUsernameAndPassword(String username, String password) {

        String sql = "SELECT `id`,`username`,`password`,`email` FROM `member` " +
                " WHERE `username`=? and `password`=md5(?)";
        return querySingle(sql, Member.class, username, password);
    }


}

