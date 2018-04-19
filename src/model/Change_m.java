package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/4/3.
 */
@Data
public class Change_m implements Serializable{
    private String belong_user;
    private String show_name;
    private String place_name;
    private String time;
    private String op;
    private String change;
    private double total;
    private int index;
}
