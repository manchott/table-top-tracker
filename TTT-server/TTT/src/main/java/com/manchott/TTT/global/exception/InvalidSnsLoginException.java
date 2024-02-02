package com.manchott.TTT.global.exception;

public class InvalidSnsLoginException extends RuntimeException{
    public InvalidSnsLoginException(String message){
        super(message);
    }
}
