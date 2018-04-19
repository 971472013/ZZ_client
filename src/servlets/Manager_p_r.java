package servlets;

import factory.EJBFactory;
import model.Place;
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
 * Created by zhuanggangqing on 2018/2/22.
 */
@WebServlet("/Manager_p_r")
public class Manager_p_r extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        List<Place> list = managerService.getAllPlace_registering();
        req.setAttribute("list",list);
        getServletContext().getRequestDispatcher("/jsp/manager_p_r.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        managerService.accept_register(URLDecoder.decode(req.getParameter("name"), "UTF-8"));
    }
}
