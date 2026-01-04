package net.mi.erp.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.mi.erp.model.ResponseDTO;

@RestController
@RequestMapping(ApiConstant.PATH_BASE)
public class ControllerBase {

    static final Logger LOGGER = LoggerFactory.getLogger(ControllerBase.class);

    @GetMapping("/version")
    public String version() {
        return ApiConstant.BASE_VERSION;
    }

    @GetMapping("/sayHello")
    public String sayHello() {
        return "Hello";
    }

    protected ResponseDTO prepareResponse(final Map<String, String> headers, final long requestTime, final Object result, final Throwable error) {
        LOGGER.info("txnId={}, requestor={}", headers.get("txnId"), headers.get("requestor"));

        final ResponseDTO resp = ResponseDTO.builder()
                .responseCode(getResponseCode(error))
                .responseMessage(getResponseMessage(error))
                .requestTime(requestTime)
                .responseTime(System.currentTimeMillis())
                .payload(result)
                .build();

        LOGGER.info("response={}", resp);

        return resp;
    }

    protected int getResponseCode(Throwable error) {
        return error == null ? 200 : 500;
    }

    protected String getResponseMessage(Throwable error) {
        return error == null ? "OK" : error.getMessage();
    }
}
