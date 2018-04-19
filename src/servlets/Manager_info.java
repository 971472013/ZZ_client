package servlets;

import factory.EJBFactory;
import model.Place;
import service.ManagerService;
import service.PlaceService;

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
@WebServlet("/Manager_info")
public class Manager_info extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        List<Place> list = managerService.getAllPlace_changeInfo();
        req.setAttribute("list",list);
        getServletContext().getRequestDispatcher("/jsp/manager_info.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = URLDecoder.decode(req.getParameter("name"), "UTF-8");
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
        Place temp = placeService.getPlaceByName(name);
        List<Place> list = managerService.getChangeInfoByID(temp.getId());
        req.getSession(false).setAttribute("list",list);
//        getServletContext().getRequestDispatcher("/jsp/manager_info_sure.jsp").forward(req,resp);
    }
}
