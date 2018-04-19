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
import java.util.Set;

/**
 * Created by zhuanggangqing on 2018/3/30.
 */
@WebServlet("/UserPay")
public class UserPay extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/text");          //设置请求以及响应的内容类型以及编码方式
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        String temp = req.getParameter("total");
        double total = Double.parseDouble(temp);
        User user = (User) req.getSession(false).getAttribute("session");
        Show show = (Show) req.getSession(false).getAttribute("Show");
        String type = req.getParameter("t");
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");

        if(null == user){
            out.write("请先登录");
        }
        else {
            switch (type){
                case "choose":
                    if(total*user.getDiscount() > user.getBalance()){
                        out.write("余额不足");
                    }
                    else {
                        String map = req.getParameter("map");
                        String seats = URLDecoder.decode(req.getParameter("seat_s"),"UTF-8");
                        userService.userPay_choose(user,show,total,map,seats);
                        req.getSession(false).setAttribute("session",userService.findUserByEmail(user.getEmail()));
                        out.write("购买成功!\n总共支付"+total*user.getDiscount()+"元");
                    }
                    break;
                case "unChoose":
                    if(total*user.getDiscount() > user.getBalance()){
                        out.write("余额不足");
                    }
                    else {
                        String count = req.getParameter("count");
                        userService.userPay_unChoose(user,show,total,Integer.parseInt(count));
                        out.write("购买成功");
                    }
            }
        }
        out.flush();
    }
}
