package servlets;

import factory.EJBFactory;
import model.Reduce;
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
 * Created by zhuanggangqing on 2018/4/3.
 */
@WebServlet("/Exchange")
public class Exchange extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        List<Reduce> list = userService.getReduceList(((User)req.getSession(false).getAttribute("session")).getEmail());
        req.getSession(false).setAttribute("reduce",list);
        getServletContext().getRequestDispatcher("/jsp/reduce.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        User user = (User) req.getSession(false).getAttribute("session");
        userService.forReduce(user);
        req.getSession(false).setAttribute("session",userService.findUserByEmail(user.getEmail()));
        resp.sendRedirect("/Exchange");
    }
}
