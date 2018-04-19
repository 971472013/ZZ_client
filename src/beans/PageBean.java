package beans;

import lombok.Data;

/**
 * Created by zhuanggangqing on 2018/3/6.
 */
@Data
public class PageBean {
    private int currentPage;
    private int totalPage;

    private static PageBean pageBean;
    private PageBean(){}
    public static PageBean getInstance(){
        if(null == pageBean){
            pageBean = new PageBean();
            pageBean.setCurrentPage(1);
            return pageBean;
        }
        return pageBean;
    }
}
