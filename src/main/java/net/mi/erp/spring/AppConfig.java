package net.mi.erp.spring;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.landawn.abacus.jdbc.JdbcUtil;

import net.mi.erp.dao.AccountDAO;

@Configuration
public class AppConfig {

    @Autowired
    private DataSource dataSource;

    @Bean
    public AccountDAO accountDAO() {
        return JdbcUtil.createDao(AccountDAO.class, dataSource);
    }
}