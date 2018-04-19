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
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/4/1.
 */
@WebServlet("/Order_cancel")
public class Order_cancel extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession(false).getAttribute("session");
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        List<Order> list = userService.getCancelOrderByEmail(user.getEmail());
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
        getServletContext().getRequestDispatcher("/jsp/order_cancel.jsp").forward(req,resp);
    }
}
