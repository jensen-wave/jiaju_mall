package com.hspedu.furns.service;

import com.hspedu.furns.entity.Member;


public interface MemberService {

    //註冊用戶
    public boolean registerMember(Member member);

    //判斷用戶名是否存在
    public boolean isExistsUsername(String username);

    /**
     * 根據登錄傳入的member資訊，返回對應的在DB中的member物件
     * @param member 是根據使用者登錄構建一個member
     * @return 返回的是對應的db中的member物件，如果不存在,返回null
     */
    public Member login(Member member);
}

