package net.mi.erp.controller;

import java.util.Map;

import org.junit.jupiter.api.Test;

import com.landawn.abacus.http.HttpHeaders.Names;
import com.landawn.abacus.http.HttpHeaders.Values;
import com.landawn.abacus.http.HttpRequest;
import com.landawn.abacus.util.N;

import net.mi.erp.model.AccountDTO;
import net.mi.erp.model.ResponseDTO;
import net.mi.erp.model.UnifiedStatus;

public class AccountControllerTest {

    static final String url = "http://localhost:8080/api/v1/account";

    @Test
    public void createAccount_01() {
        AccountDTO accountDTO = AccountDTO.builder()
                .firstName("testFirstName01")
                .lastName("testLastName01")
                .emailAddress("testEmail01@emal.com")
                .status(UnifiedStatus.ACTIVE)
                .build();

        ResponseDTO resp = HttpRequest.url(url).header(Names.CONTENT_TYPE, Values.APPLICATION_JSON).body(accountDTO).post(ResponseDTO.class);
        N.println(resp);

        Map<String, Object> payload = (Map<String, Object>) resp.getPayload();

        int id = (Integer) payload.get("id");

        resp = HttpRequest.url(url + "/" + id).get(ResponseDTO.class);
        N.println(resp);

        resp = HttpRequest.url(url + "/" + id).delete(ResponseDTO.class);
        N.println(resp);
    }

}
