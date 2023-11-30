package com.example.demo.ch5;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet{
  @Override
	public void init() throws ServletException {
    //서블릿 초기화 : 서블릿이 생성, 리로딩될 때 단 한 번만 수행됨
    //서블릿이 초기화 될 때 자동 호출되는 메소드. 개발자가 신경쓰지 않아도 됨
		System.out.println("init호출");
	}
  //브라우저에서 새로고침 누르면 service메소드만 호출되고 처리됨(init()이 또 호출되지 않음)
  //호출될 때마다 반복적으로 수행됨
	@Override
	public void service(ServletRequest arg0, ServletResponse arg1) throws ServletException {
    //service 메소드 호출
		System.out.println("service호출");
	}
	@Override
	public void destroy() {
    //서블릿이 제거될 때 단 한 번만 수행됨
    //서블릿이 메모리에서 내려올 때 호출
    //어플리케이션 종료 시 호출
    //주석이라도 수정 후 저장하면 다시 리로딩 됨(init, destroy 둘 다) - 따라서 개발자가 집중 할 곳은 service()
		System.out.println("destroy호출");
	}
}
