package servlets;

import beans.PageBean;
import factory.EJBFactory;
import model.Show;
import model.User;
import service.ShowService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by zhuanggangqing on 2018/2/18.
 */
@WebServlet("/UserIndex")
public class UserIndex extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        PageBean pageBean = PageBean.getInstance();
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        if(request.getParameter("page") == null){
            pageBean.setTotalPage(showService.getShowNumbers()/50);
        }
        else {
            page = Integer.parseInt(request.getParameter("page"));
        }
        pageBean.setCurrentPage(page);
        List<Show> showList = showService.findAllShowByPage(page);
        request.setAttribute("pageBean",pageBean);
        request.setAttribute("showList",showList);
        getServletContext().getRequestDispatcher("/jsp/userIndex.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = Integer.parseInt(req.getParameter("page"));
        PageBean pageBean = PageBean.getInstance();
        pageBean.setCurrentPage(page);
        ShowService showService = (ShowService) EJBFactory.getEJB("ShowServiceImpl","service.ShowService");
        List<Show> showList = showService.findAllShowByPage(page);
        req.setAttribute("pageBean",pageBean);
        req.setAttribute("showList",showList);
        getServletContext().getRequestDispatcher("/jsp/userIndex.jsp").forward(req,resp);
    }
}
