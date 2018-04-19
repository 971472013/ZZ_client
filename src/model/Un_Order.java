package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/4/4.
 */
@Data
public class Un_Order implements Serializable{
    private String belong_user;
    private String show_name;
    private String place_name;
    private double total;
    private int count;
    private int index;
}
