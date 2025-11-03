package com.example.approval24.domain;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuDTO {
    private Long menuId;           // MENU_ID
    private String menuName;       // MENU_NAME
    private String menuUrl;        // MENU_URL
    private Long parentMenuId;     // PARENT_MENU_ID
    private Long seq;            // SEQ
    private String popupYn;        // POPUP_YN
    private Date createDt;         // CREATE_DT
    private Date updateDt;         // UPDATE_DT
    private Long createId;         // CREATE_ID
    private Long updateId;         // UPDATE_ID
    private String delYn;          // DEL_YN
    
    private String parentMenuName; //부모 이름
}
