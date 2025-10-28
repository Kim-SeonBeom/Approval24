package com.example.approval24.domain;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthorityMenuDTO {
    private Long authorityId;   // AUTHORITY_ID
    private Long menuId;        // MENU_ID
    private String readYn;      // READ_YN
    private String createYn;    // CREATE_YN
    private String updateYn;    // UPDATE_YN
    private String deleteYn;    // DELETE_YN
    private String approveYn;   // APPROVE_YN
    private Date createDt;      // CREATE_DT
    private Date updateDt;      // UPDATE_DT
    private Long createId;      // CREATE_ID
    private Long updatedId;     // UPDATED_ID
    private String delYn;       // DEL_YN
}
