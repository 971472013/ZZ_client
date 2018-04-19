package servlets;

import factory.EJBFactory;
import model.Un_Order;
import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/4/4.
 */
@WebServlet("/Ordering")
public class Ordering extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        List<Un_Order> list = userService.getUOrder(((User)req.getSession(false).getAttribute("session")).getEmail());
        req.getSession(false).setAttribute("orderList",list);
        getServletContext().getRequestDispatcher("/jsp/waitting.jsp").forward(req,resp);
    }
}
