package servlets;

import factory.EJBFactory;
import model.Change;
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
 * Created by zhuanggangqing on 2018/4/1.
 */
@WebServlet("/Statistics")
public class Statistics extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        List<Change> list = userService.getChangeList(((User)req.getSession(false).getAttribute("session")).getEmail());
        req.getSession(false).setAttribute("changeList",list);
        System.out.println(((User)req.getSession().getAttribute("session")).getBalance());
        getServletContext().getRequestDispatcher("/jsp/statistics.jsp").forward(req,resp);
    }
}
