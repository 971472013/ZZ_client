package servlets;

import factory.EJBFactory;
import model.User;
import service.UserService;
import sun.security.krb5.EncryptedData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

/**
 * Created by zhuanggangqing on 2018/2/15.
 */
@WebServlet("/Register")
public class Register extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/jsp/register.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl", "service.UserService");
        User foundUser = userService.findUserByEmail(request.getParameter("email"));
        if(null==foundUser){
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            Calendar calendar = Calendar.getInstance();
            long time = calendar.getTimeInMillis();
            calendar.add(Calendar.DATE,1);
            String acti_code = email+time;
            String token_exptime=""+calendar.getTimeInMillis();

            User user = new User();
            user.setEmail(email);
            user.setPasswd(password);
            user.setActi_code(acti_code);
            user.setToken_exptime(token_exptime);

            user = userService.registerUser(user);
            if(null==user){
                System.out.println("注册失败");
            }
            else{
                response.sendRedirect("/UserIndex");
            }
        }
        else{
            System.out.println("用户已存在");
        }
    }
}
