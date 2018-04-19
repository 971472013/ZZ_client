package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/4/3.
 */
@Data
public class Reduce implements Serializable{
    private int id;
    private String belong_user;
    private String de;
    private double tot;
    private double sub;
}
