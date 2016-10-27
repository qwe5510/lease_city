package leasecity.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionCheckInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		Object userObj = session.getAttribute("LoginUser");
		Object adminObj = session.getAttribute("admin");
		
		if(userObj ==null && adminObj == null){
			response.sendRedirect(request.getContextPath()+"/login");
		}

		return true;
	}
	

}
