package servlets;

import factory.EJBFactory;
import model.MapFactory;
import model.Show;
import net.sf.json.JSONArray;
import service.ShowService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by zhuanggangqing on 2018/3/5.
 */
@WebServlet("/ShowInfo")
public class ShowInfo extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        Show show = showService.findShowByName(name);
        req.setAttribute("Show",show);
        req.getSession(false).setAttribute("Show",show);
        getServletContext().getRequestDispatcher("/jsp/showInfo.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/text");          //设置请求以及响应的内容类型以及编码方式
        resp.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        Show show = showService.findShowByName(name);
        String s = show.getMap();
        out.write(s);

    }
}
