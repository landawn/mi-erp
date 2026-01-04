package net.mi.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.landawn.abacus.util.Beans;

import net.mi.erp.dao.AccountDAO;
import net.mi.erp.entity.Account;
import net.mi.erp.model.AccountDTO;

@Service
public class AccountService {

    @Autowired
    private AccountDAO accountDao;

    public Account getById(final int id) {
        return accountDao.gett(id);
    }

    public int create(final AccountDTO accountDTO) {
        Assert.notNull(accountDTO, "account must not be null");
        Account account = Beans.copy(accountDTO, Account.class);
        return accountDao.insert(account);
    }

    public void deleteById(final int id) {
        accountDao.deleteById(id);
    }
}
