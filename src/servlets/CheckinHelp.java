package servlets;

import factory.EJBFactory;
import model.Show;
import model.User;
import service.ShowService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

/**
 * Created by zhuanggangqing on 2018/4/2.
 */
@WebServlet("/CheckinHelp")
public class CheckinHelp extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/text");          //设置请求以及响应的内容类型以及编码方式
        resp.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        Show show = showService.findShowByName(name);
        String s = show.getCheckmap();
        out.write(s);
    }

    //现场购票的接口
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/text");          //设置请求以及响应的内容类型以及编码方式
        resp.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String pass = req.getParameter("pass");
        String seats = URLDecoder.decode(req.getParameter("seats"),"UTF-8");
        String map = req.getParameter("map");
        double total = Double.parseDouble(req.getParameter("total"));
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        User user = userService.findUserByEmail(email);
        Show show = (Show) req.getSession(false).getAttribute("checkShow");
        if(user==null){
            out.write("此账号不存在");
        }
        else {
            if(user.getPasswd().equals(pass)){
                if(user.getBalance()<total){
                    out.write("购买失败，账号余额不足");
                }
                else {
                    userService.userPay_choose(user,show,total,map,seats);
                    out.write("购买成功，请直接入场");
                }
            }
            else{
                out.write("账号密码错误");
            }
        }
        out.flush();
    }
}
