package a.b.c.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

@Service
@Aspect
public class MyAdvice {
	
	@Pointcut("execution(* a.b.c.controller.MainController.createList(..)")
	public void advice(){
		System.out.println("AOP test!!");
	}
	
	@Before("advice()")
	public void before(JoinPoint joinPoint) {
		System.out.println("Before...");
	}

	@After("advice()")
	public void after(JoinPoint joinPoint) {
		System.out.println("After...");
	}
}
