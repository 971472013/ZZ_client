package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/2/22.
 */
@Data
public class Manager extends MainClass implements Serializable{
    private String email;
    private String password;
    private double balance;
}
