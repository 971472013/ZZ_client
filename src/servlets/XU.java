package servlets;

import factory.EJBFactory;
import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by zhuanggangqing on 2018/4/3.
 */
@WebServlet("/XU")
public class XU extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        userService.XU(((User)req.getSession(false).getAttribute("session")).getEmail());
        resp.sendRedirect("/Logout");
    }
}
