package net.mi.erp.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseDTO {

    private int responseCode;
    private String responseMessage;

    private long requestTime;
    private long responseTime;

    private Object payload;
}
