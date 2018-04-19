package servlets;

import factory.EJBFactory;
import model.Order;
import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/4/1.
 */
@WebServlet("/Order_normal")
public class Order_normal extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession(false).getAttribute("session");
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        List<Order> list = userService.getNormalOrderByEmail(user.getEmail());
        String[] seats;
        String s="";
        for(int i=0; i < list.size() ;i++){
            seats = list.get(i).getSeats().split("\\*");
            for(String v:seats){
                s = s + v + ",";
            }
            s = s.substring(0,s.length()-1);
            list.get(i).setSeats(s);
            s="";
        }
        req.getSession(false).setAttribute("orderList",list);
        getServletContext().getRequestDispatcher("/jsp/order_normal.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession(false).getAttribute("session");
        String showName = URLDecoder.decode(req.getParameter("showName"),"UTF-8");
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        userService.cancelOrderByShowName(user.getEmail(),showName);
        req.getSession(false).setAttribute("session",userService.findUserByEmail(user.getEmail()));
    }
}
