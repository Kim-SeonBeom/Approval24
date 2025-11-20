package com.example.approval24.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class AlarmDTO {
    private Long seqNo;          
    private Long senderId;     
    private Long receiverId;   
    private String message;    
    private String url;          
    private String readYn;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
    private Date createdDt;      
}
