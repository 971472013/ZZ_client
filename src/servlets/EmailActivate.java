package servlets;

import factory.EJBFactory;
import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;

/**
 * Created by zhuanggangqing on 2018/2/21.
 */
@WebServlet("/EmailActivate")
public class EmailActivate extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String email = request.getParameter("email");
        String acti_code = request.getParameter("acti_code");
        Calendar calendar = Calendar.getInstance();
        long cTime = calendar.getTimeInMillis();

        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl", "service.UserService");
        User foundUser = userService.findUserByEmail(email);
        if(null == foundUser){
            System.out.println("用户不存在");
        }
        else{
            String a_code = foundUser.getActi_code();
            if(a_code.equals(acti_code)){
                long token_exptime = Long.parseLong(foundUser.getToken_exptime());
                if(token_exptime > cTime){
                    User user = userService.activate(email);
                    HttpSession session = request.getSession(false);
                    session.setAttribute("session",user);
                    getServletContext().getRequestDispatcher("/UserIndex").forward(request,response);
                }
                else{
                    System.out.println("超时");
                }
            }
            else{
                System.out.println("错误");
            }
        }
    }
}
