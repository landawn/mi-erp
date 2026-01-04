package net.mi.erp.service;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import net.mi.erp.dao.AccountDAO;
import net.mi.erp.entity.Account;

@Service
public class AccountService {

    private final AccountDAO accountDao;

    public AccountService(final AccountDAO accountDao) {
        this.accountDao = accountDao;
    }

    public Account getById(final int id) {
        return accountDao.gett(id);
    }

    public int create(final Account account) {
        Assert.notNull(account, "account must not be null");
        return accountDao.insert(account);
    }

    public void deleteById(final int id) {
        accountDao.deleteById(id);
    }
}
