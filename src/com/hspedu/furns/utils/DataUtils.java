package com.hspedu.furns.utils;

import org.apache.commons.beanutils.BeanUtils;

import java.util.Map;


public class DataUtils {

    //將方法，封裝到靜態方法，方便使用
    public static <T> T copyParamToBean(Map value, T bean) {
        try {
            BeanUtils.populate(bean, value);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bean;
    }

    public static int parseInt(String val, int defaultVal) {
        if (val == null || val.trim().isEmpty()) {
            System.out.println("無法解析整數，提供的值為空或未提供，返回默認值：" + defaultVal);
            return defaultVal;
        }
        try {
            return Integer.parseInt(val);
        } catch (NumberFormatException e) {
            System.out.println("無法解析整數：" + val + "，返回默認值：" + defaultVal);
            return defaultVal;
        }
    }

}

