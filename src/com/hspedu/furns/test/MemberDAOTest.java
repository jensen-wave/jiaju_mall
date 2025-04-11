package com.hspedu.furns.test;

import com.hspedu.furns.dao.MemberDAO;
import com.hspedu.furns.dao.impl.MemberDAOImpl;
import com.hspedu.furns.entity.Member;
import org.junit.jupiter.api.Test;


public class MemberDAOTest {

    private MemberDAO memberDAO=new MemberDAOImpl();
    @Test
    public void queryMemberByUsernameAndPassword(){
        Member member = memberDAO.queryMemberByUsernameAndPassword("admin", "admin");

        if (member == null) {
            System.out.println("用戶不存在");
        }else {
            System.out.println("用戶存在");
        }

    }


    @Test
    public void queryMemberByUsername(){
        Member member = memberDAO.queryMemberByUsername("king");

        if (member==null){
            System.out.println("用戶不存在");
        }else {
            System.out.println("用戶存在");
        }

    }
    @Test
    public void saveMember(){
        Member member = new Member(null,"momomo","ppppppp","ttt@ttt.com");
        int i = memberDAO.saveMember(member);

        if (i == 1) {
            System.out.println("成功");
        }else {
            System.out.println("失敗");
        }

    }

}

