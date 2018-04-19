package servlets;

import factory.EJBFactory;
import service.ManagerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by zhuanggangqing on 2018/3/30.
 */
@WebServlet("/Manager_info_sure")
public class Manager_info_sure extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        String id = req.getParameter("id");
        switch (method){
            case "sure":
                sure(id);
                break;
            case "unSure":
                unSure(id);
                break;
        }
    }
    private void sure(String id){
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        managerService.sure(id);

    }
    private void unSure(String id){
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        managerService.unSure(id);
    }
}
