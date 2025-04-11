package com.hspedu.furns.dao;

import com.hspedu.furns.entity.Member;


public interface MemberDAO {

    //自己分析，需要哪些方法
    //提供一個通過用戶名返回對應的Member
    public Member queryMemberByUsername(String username);

    //提供一個保存Member物件到資料庫/表member表
    public int saveMember(Member member);

    /**
     * 根據用戶名和密碼返回Member
     * @param username 用戶名
     * @param password 密碼
     * @return 返回的對象，如果不存在，返回null
     *
     */
    public Member queryMemberByUsernameAndPassword
    (String username, String password);
}

