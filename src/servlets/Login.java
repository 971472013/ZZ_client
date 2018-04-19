package servlets;
import factory.EJBFactory;
import model.*;
import service.ManagerService;
import service.PlaceService;
import service.ShowService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/2/11.
 */
@WebServlet("/Login")
public class Login extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
//        String login="";
//        HttpSession session = request.getSession(false);
//        Cookie cookie = null;
//        Cookie[] cookies = request.getCookies();
//
//        if (null != cookies) {
//            for (int i = 0; i < cookies.length; i++) {
//                cookie = cookies[i];
//                if (cookie.getName().equals("LoginCookie")) {
//                    login=cookie.getValue();
//                    break;
//                }
//            }
//        }
//        if (null != request.getParameter("Logout")) {
//            if (null != session) {
//                session.invalidate();
//                session = null;
//            }
//        }
//        request.setAttribute("login",login);
        response.sendRedirect("/jsp/login.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl", "service.UserService");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if(password==null){
            password="";
        }
        User user = userService.findUserByEmail(email);
        if(null != user){
            if(user.getPasswd().equals(password)){
                if(user.getState()==1){
                    if(user.getMark()==1){
                        user.setType(Type.User);
                        request.getSession(false).setAttribute("session",user);
                        response.sendRedirect("/UserIndex");
                    }
                    else {
                        response.setContentType("text/html;charset=UTF-8");
                        PrintWriter writer = response.getWriter();
                        writer.write("<script>alert('此用户已销户');window.location.href='/UserIndex'</script>");
                        writer.flush();
                        writer.close();
                    }
                }
                else{
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter writer = response.getWriter();
                    writer.write("<script>alert('非法用户');window.location.href='/UserIndex'</script>");
                    writer.flush();
                    writer.close();
                }
            }
            else {
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter writer = response.getWriter();
                writer.write("<script>alert('账号密码错误');window.location.href='/UserIndex'</script>");
                writer.flush();
                writer.close();
            }
        }
        else {
            PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
            Place place = placeService.getPlaceById(email);
            if(null != place){
                if(place.getPasswd().equals(password)){
                    if(place.getState()==1){
                        place.setType(Type.Place);
                        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
                        List<Show> showList = showService.findAllShowsByPlace(place.getName());
                        request.getSession(false).setAttribute("session",place);
                        request.getSession(false).setAttribute("showList",showList);
                        response.sendRedirect("/PlaceIndex");
                    }
                    else {
                        response.setContentType("text/html;charset=UTF-8");
                        PrintWriter writer = response.getWriter();
                        writer.write("<script>alert('非法用户');window.location.href='/UserIndex'</script>");
                        writer.flush();
                        writer.close();
                    }
                }
                else {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter writer = response.getWriter();
                    writer.write("<script>alert('账号密码错误');window.location.href='/UserIndex'</script>");
                    writer.flush();
                    writer.close();
                }
            }
            else {
                ManagerService managerService = (ManagerService)EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
                Manager manager = managerService.findManagerByEmail(email);
                if(null != manager){
                    if(manager.getPassword().equals(password)){
                        manager.setType(Type.Manager);
                        request.getSession(false).setAttribute("session",manager);
                        response.sendRedirect("/Manager_p_r");
                    }
                    else {
                        response.setContentType("text/html;charset=UTF-8");
                        PrintWriter writer = response.getWriter();
                        writer.write("<script>alert('账号密码错误');window.location.href='/UserIndex'</script>");
                        writer.flush();
                        writer.close();
                    }
                }
                else {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter writer = response.getWriter();
                    writer.write("<script>alert('账号不存在');window.location.href='/UserIndex'</script>");
                    writer.flush();
                    writer.close();
                }
            }
        }
    }
}
