package servlets;

import factory.EJBFactory;
import model.Order;
import model.Show;
import service.ManagerService;
import service.ShowService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/4/3.
 */
@WebServlet("/M_help")
public class M_help extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/text");          //设置请求以及响应的内容类型以及编码方式
        resp.setCharacterEncoding("UTF-8");
        ManagerService managerService = (ManagerService) EJBFactory.getEJB("ManagerServiceImpl","service.ManagerService");
        List<Order> list = managerService.getEndList();

        String s ="";
        for(Order v:list){
            s= s+v.getBelong_user()+","+v.getShow_name()+","+v.getPlace_name()+".";
        }
        s=s.substring(0,s.length()-1);
        out.write(s);
    }
}
