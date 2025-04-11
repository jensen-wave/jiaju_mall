package com.hspedu.furns.service.impl;

import com.hspedu.furns.dao.MemberDAO;
import com.hspedu.furns.dao.impl.MemberDAOImpl;
import com.hspedu.furns.entity.Member;
import com.hspedu.furns.service.MemberService;


public class MemberServiceImpl implements MemberService {
    //定義一個MemberDao屬性
    private MemberDAO memberDAO=new MemberDAOImpl();

    @Override
    public boolean registerMember(Member member) {
        return memberDAO.saveMember(member)==1 ? true:false;

    }

    /**
     * 判斷用戶名是否存在
     *
     * @param username 用戶名
     * @return 如果存在返回true, 否則返回false
     */
    @Override
    public boolean isExistsUsername(String username) {
        return memberDAO.queryMemberByUsername(username)==null ? false:true;

    }

    @Override
    public Member login(Member member) {
        //返回對象
        return memberDAO.queryMemberByUsernameAndPassword
                (member.getUsername(), member.getPassword());
    }
}

