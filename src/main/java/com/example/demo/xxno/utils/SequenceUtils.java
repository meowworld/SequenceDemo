package com.example.demo.xxno.utils;


import com.example.demo.xxno.dao.SequenceDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import javax.annotation.PostConstruct;

/**
 * 在静态方法中调用非静态的的bean，这是不允许的，可以下面这样做
 * 被@PostConstruct修饰的方法会在服务器加载Servlet的时候运行，并且只会被服务器调用一次，
 * 类似于Serclet的inti()方法。被@PostConstruct修饰的方法会在构造函数之后，init()方法之前运行。
 *
 * @Component 注解 在向容器中注入的时候，会调用构造方法,再调用被@PostConstruct标注的方法，在调用init()方法
 */

@Component
public class SequenceUtils {

    @Autowired
    private SequenceDao sequenceDao;

    private static SequenceUtils sequenceUtils;

    @PostConstruct
    public void construct(){
        sequenceUtils = this;
        sequenceUtils.sequenceDao = this.sequenceDao;
    }

    public static String getSequence(){
        String sequenceNo = sequenceUtils.sequenceDao.nextNo();
        return sequenceNo;
    }

}
