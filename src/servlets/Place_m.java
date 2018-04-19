package servlets;

import factory.EJBFactory;
import model.Change_m;
import model.Place;
import service.ManagerService;
import service.PlaceService;

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
@WebServlet("/Place_m")
public class Place_m extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
        List<Change_m> list = placeService.getPChangeList(((Place)(req.getSession(false).getAttribute("session"))).getName());
        req.getSession(false).setAttribute("list",list);
        getServletContext().getRequestDispatcher("/jsp/place_m.jsp").forward(req,resp);
    }
}
