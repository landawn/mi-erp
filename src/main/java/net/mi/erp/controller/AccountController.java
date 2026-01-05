package net.mi.erp.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.landawn.abacus.exception.ObjectNotFoundException;

import net.mi.erp.dao.AccountDAO;
import net.mi.erp.exception.ApplicationException;
import net.mi.erp.model.AccountDTO;
import net.mi.erp.model.ResponseDTO;
import net.mi.erp.service.AccountService;

@RestController
@RequestMapping(ApiConstant.PATH_BASE + "/account")
public class AccountController extends ControllerBase {

    @Autowired
    private AccountDAO accountDao;

    @Autowired
    private AccountService accountService;

    @GetMapping("/{id}")
    public ResponseDTO getById(@RequestHeader Map<String, String> headers, @PathVariable("id") final int id) {
        final long requestTime = System.currentTimeMillis();
        Object result = null;
        Throwable error = null;

        try {
            result = accountService.getById(id);
        } catch (Throwable e) {
            error = e;
        }

        if (result == null) {
            error = new ObjectNotFoundException("No account found by id: " + id);
        }

        return prepareResponse(headers, requestTime, result, error);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseDTO create(@RequestHeader Map<String, String> headers, @RequestBody final AccountDTO account) {
        final long requestTime = System.currentTimeMillis();
        int newAccountId = 0;
        Throwable error = null;

        try {
            newAccountId = accountService.create(account);
        } catch (Throwable e) {
            error = e;
        }

        Object result = null;

        if (newAccountId <= 0 && error == null) {
            error = new ApplicationException("Failed to create ccount with email: " + account.getEmailAddress());
        } else {
            result = Map.of("id", newAccountId);
        }

        return prepareResponse(headers, requestTime, result, error);
    }

    @DeleteMapping("/{id}")
    // @ResponseStatus(HttpStatus.NO_CONTENT)
    public ResponseDTO deleteById(@RequestHeader Map<String, String> headers, @PathVariable final int id) {
        final long requestTime = System.currentTimeMillis();
        boolean found = false;
        Throwable error = null;

        try {
            found = accountDao.exists(id);

            if (found) {
                accountService.deleteById(id);
            }
        } catch (Throwable e) {
            error = e;
        }

        Object result = Map.of("deleted", found);

        return prepareResponse(headers, requestTime, result, error);
    }
}
