package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/3/15.
 */
@Data
public class Place extends MainClass implements Serializable{
    private String name;
    private String introduction;
    private String city;
    private String img;
    private String id;
    private String passwd;
    private int state;
    private double balance;
}
