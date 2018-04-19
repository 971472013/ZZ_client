package servlets;

import factory.EJBFactory;
import model.Order;
import org.apache.xpath.operations.Or;
import service.ManagerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/3/28.
 */
@WebServlet("/Manager_pay")
public class Manager_pay extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        List<Order> list = managerService.getEndList();
        req.getSession(false).setAttribute("orderList",list);
        getServletContext().getRequestDispatcher("/jsp/manager_pay.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = URLDecoder.decode(req.getParameter("user"),"UTF-8");
        String show = URLDecoder.decode(req.getParameter("show"),"UTF-8");
        String place = URLDecoder.decode(req.getParameter("place"),"UTF-8");
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        managerService.end(user,place,show);
    }
}
