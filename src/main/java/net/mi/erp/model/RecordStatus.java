package net.mi.erp.model;

public enum RecordStatus {

    DEFAULT(0), DELETED(1), SUSPENDED(2);

    private int code;

    RecordStatus(int code) {
        this.code = code;
    }

    public int code() {
        return code;
    }

}
