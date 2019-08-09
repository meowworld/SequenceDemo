package com.example.demo.xxno;

import com.example.demo.xxno.utils.SequenceUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {

    @GetMapping("/getNextNo")
    public String getNo(){
        Logger logger = LoggerFactory.getLogger(getClass());
        String nextNo = SequenceUtils.getSequence();
        logger.info("获取到的下一个序列号为-->"+nextNo);
        return nextNo;
    }

}
