package model;

import lombok.Data;

/**
 * Created by zhuanggangqing on 2018/3/13.
 */
public class MapFactory {
    private static String[] mapA ={  //座位图
            "aaaaaaaaaa",
            "aaaaaaaaaa",
            "__________",
            "aaaaaaaa__",
            "aaaaaaaaaa",
            "aaaaaaaaaa",
            "aaaaaaaaaa",
            "aaaaaaaaaa",
            "aaaaaaaaaa",
            "aa__aa__aa"
            };

    public static String[] getMapA() {
        return mapA;
    }
}
