package com.hspedu.furns.test;

import com.hspedu.furns.entity.Member;
import com.hspedu.furns.service.MemberService;
import com.hspedu.furns.service.impl.MemberServiceImpl;
import org.junit.jupiter.api.Test;


public class MemberServiceTest {

    private MemberService memberService = new MemberServiceImpl();


    @Test
    public void login() {
        Member member = new Member(null, "admin", "admin", null);
        System.out.println(memberService.login(member));
    }

    @Test
    public void isExistsUsername() {
        if(memberService.isExistsUsername("king")) {
            System.out.println("用戶名存在...");
        } else {
            System.out.println("用戶名不存在...");
        }
    }

    @Test
    public void registerMember() {
        //構建一個Member物件
        Member member = new Member(null, "mary", "mary", "mary@qq.com");
        if(memberService.registerMember(member)) {
            System.out.println("註冊用戶成功...");
        } else {
            System.out.println("註冊用戶失敗...");
        }
    }

}

