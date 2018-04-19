package servlets;

import factory.EJBFactory;
import model.Place;
import model.Show;
import service.PlaceService;
import service.ShowService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/3/16.
 */
@WebServlet("/PlaceIndex")
public class PlaceIndex extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        String name;
        Place place = (Place) req.getSession(false).getAttribute("session");
        if(req.getParameter("place")==null){
            name = place.getName();
        }
        else {
            name = req.getParameter("place");
            place = placeService.getPlaceByName(name);
        }

        List<Show> list = showService.findAllShowsByPlace(name);
        req.setAttribute("place",place);
        req.setAttribute("showList",list);
        getServletContext().getRequestDispatcher("/jsp/placeIndex.jsp").forward(req,resp);
    }
}
