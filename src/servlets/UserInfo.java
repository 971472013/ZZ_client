package servlets;

import factory.EJBFactory;
import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by zhuanggangqing on 2018/2/24.
 */
@WebServlet("/UserInfo")
public class UserInfo extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getSession(false).getAttribute("session") != null){
            getServletContext().getRequestDispatcher("/jsp/userInfo.jsp").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req. setCharacterEncoding("UTF-8");
        String nickname = req.getParameter("nickname");
        String real_name = req.getParameter("real_name");
        String gender = req.getParameter("gender");
        String birthY = req.getParameter("birthY");
        String birthM = req.getParameter("birthM");
        String birthD = req.getParameter("birthD");
        String home_place = req.getParameter("home_place");
        UserService userService = (UserService) EJBFactory.getEJB("UserServiceImpl","service.UserService");
        User user = (User)req.getSession().getAttribute("session");
        user.setNickname(nickname);
        user.setReal_name(real_name);
        user.setGender(gender);
        user.setBirthday(birthY+"-"+birthM+"-"+birthD);
        user.setHome_place(home_place);

        if(userService.changeInfo(user)){
            resp.setContentType("text/html;charset=utf-8");
            PrintWriter writer = resp.getWriter();
            writer.write("<script>alert('信息修改成功');window.location.href='/UserInfo';</script>");
            writer.flush();
            writer.close();
        }
        getServletContext().getRequestDispatcher("jsp/uerInfo.jsp").forward(req,resp);
    }
}
