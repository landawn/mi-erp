package net.mi.erp.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "net.mi.erp")
public class ERPApplication {
    public static void main(String[] args) {
        SpringApplication.run(ERPApplication.class, args);
    }
}