package model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by zhuanggangqing on 2018/4/1.
 */
@Data
public class Change implements Serializable{
    private String email;
    private String time;
    private String op;
    private String change;
    private double total;
    private int index;
}
