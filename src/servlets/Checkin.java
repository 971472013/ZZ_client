package servlets;

import factory.EJBFactory;
import model.Show;
import service.PlaceService;
import service.ShowService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by zhuanggangqing on 2018/4/2.
 */
@WebServlet("/Checkin")
public class Checkin extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String showName = req.getParameter("name");
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        Show show = showService.findShowByName(showName);
        req.getSession(false).setAttribute("checkShow",show);
        getServletContext().getRequestDispatcher("/jsp/checkin.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String map = req.getParameter("map");
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
        placeService.checkin(((Show)req.getSession(false).getAttribute("checkShow")).getName(),map);
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        Show show = showService.findShowByName(((Show) req.getSession(false).getAttribute("checkShow")).getName());
        req.getSession(false).setAttribute("checkShow",show);
    }
}
