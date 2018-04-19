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
 * Created by zhuanggangqing on 2018/3/21.
 */
@WebServlet("/PlaceInfo")
public class PlaceInfo extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/jsp/placeInfo_change.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req. setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        PlaceService placeService = (PlaceService) EJBFactory.getEJB("PlaceServiceImpl","service.PlaceService");
        Place place = (Place) req.getSession(false).getAttribute("session");
        Place p = new Place();
        p.setName(req.getParameter("name"));
        p.setCity(req.getParameter("city"));
        p.setIntroduction(req.getParameter("introduction"));
        if(req.getSession(false).getAttribute("c_p")==null){
            p.setImg(place.getImg());
        }
        else{
            p.setImg(req.getSession(false).getAttribute("c_p").toString());
        }
        p.setId(place.getId());
        p.setPasswd(place.getPasswd());
        p.setState(place.getState());
        p.setBalance(place.getBalance());
        if(placeService.apply_change(p)){
            writer.write("<script>alert('申请更改信息成功，以加入等待队列，待管理员确认后即可更改信息');window.location.href='/PlaceInfo'</script>");
        }
        else {
            writer.write("<script>alert('更改信息失败');window.location.href='/PlaceInfo'</script>");
        }
        writer.flush();
        writer.close();
    }
}
