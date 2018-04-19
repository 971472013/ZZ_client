package model;

import lombok.Data;
import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/2/23.
 */
@Data
public class Show implements Serializable{
    private String name;
    private String time;
    private String place;
    private String price;
    private String type;
    private String introduction;
    private String img;
    private String city;
    private String map;
    private String checkmap;
//    private String mark;
}
