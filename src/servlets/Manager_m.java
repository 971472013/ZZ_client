package servlets;

import factory.EJBFactory;
import model.Change_m;
import service.ManagerService;

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
@WebServlet("/Manager_m")
public class Manager_m extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        List<Change_m> list = managerService.getMChangeList();
        req.getSession(false).setAttribute("list",list);
        getServletContext().getRequestDispatcher("/jsp/manager_m.jsp").forward(req,resp);
    }
}
