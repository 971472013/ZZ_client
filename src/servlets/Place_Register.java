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
import java.io.PrintWriter;

/**
 * Created by zhuanggangqing on 2018/3/16.
 */
@WebServlet("/Place_Register")
public class Place_Register extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/jsp/Place_Register.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String city = req.getParameter("city");
        String pass = req.getParameter("password");
        Place place = new Place();
        place.setName(name);
        place.setCity(city);
        place.setPasswd(pass);
        place.setImg("src/other/暂无图片.jpg");
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
       if( placeService.registerPlace(place)){
           resp.setContentType("text/html;charset=UTF-8");
           PrintWriter writer = resp.getWriter();
           writer.write("<script>alert('场馆注册成功,请等待审核');window.location.href='/UserIndex'</script>");
       }
    }
}
