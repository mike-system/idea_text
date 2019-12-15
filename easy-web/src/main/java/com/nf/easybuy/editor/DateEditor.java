package com.nf.easybuy.editor;

import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.propertyeditors.PropertiesEditor;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * Description:  自定义多日期类型转换器
 * User: nongfu 农夫
 * Date: 2019-11-11
 * Time: 22:55
 */
public class DateEditor extends PropertiesEditor {
    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        SimpleDateFormat sdf = getSimpleDateFormat(text);
        Date date = null;
        try {
            date = sdf.parse(text);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        setValue(date);
    }

    private SimpleDateFormat getSimpleDateFormat(String source) {
        SimpleDateFormat sdf = new SimpleDateFormat();
        if (source.matches("\\d{4}-\\d{2}-\\d{2}")) {
            sdf = new SimpleDateFormat("yyyy-MM-dd");
        } else if (source.matches("\\d{4}/\\d{2}/\\d{2}")) {
            sdf = new SimpleDateFormat("yyyy/MM/dd");
        } else if (source.matches("\\d{8}")) {
            sdf = new SimpleDateFormat("yyyyMMdd");
        } else {
            throw new TypeMismatchException("", Date.class);
        }
        return sdf;
    }

}
