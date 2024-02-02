package com.manchott.TTT.domain.user.entity;

import com.fasterxml.jackson.annotation.JsonCreator;

public enum Sns {
    GOOGLE, APPLE;

    @JsonCreator
    public static Sns from(String s) {
        return Sns.valueOf(s.toUpperCase());
    }
}
