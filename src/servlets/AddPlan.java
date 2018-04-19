package servlets;

import factory.EJBFactory;
import model.Place;
import service.PlaceService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by zhuanggangqing on 2018/3/23.
 */
@WebServlet("/AddPlan")
public class AddPlan extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/jsp/add.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req. setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String type = req.getParameter("city");
        String birthY = req.getParameter("birthY");
        String birthM = req.getParameter("birthM");
        String birthD = req.getParameter("birthD");
        String intro = req.getParameter("introduction");
        String img;
        if(req.getSession(false).getAttribute("iimg")==null){
            img = "src/other/暂无图片.jpg";
        }
        else {
            img = req.getSession(false).getAttribute("iimg").toString();
        }

        Place p = (Place) req.getSession(false).getAttribute("session");
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
        placeService.addShow(name,birthY+"-"+birthM+"-"+birthD,type,intro,img,p);
        resp.sendRedirect("/PlaceIndex");
    }
}
