package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/2/18.
 */
@Data
public class User extends MainClass implements Serializable{
    private static final long serialVersionUID = 1L;
//    private static final long serialVersionUID = -558553967080513790L;

    private String email;
    private String passwd;
    private int mark;           //标记是否为有效用户
    private int level;
    private double balance;
    private double discount;
    private int state;

    private String acti_code;

    private String token_exptime;

    private String nickname;

    private String real_name;

    private double consume;

    private String gender;

    private String birthday;

    private String home_place;
    private int credit;

    public String getY(){
        return birthday.split("-")[0];
    }
    public String getM(){
        return birthday.split("-")[1];
    }
    public String getD(){
        return birthday.split("-")[2];
    }
}
