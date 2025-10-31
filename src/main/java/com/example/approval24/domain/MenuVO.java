package com.example.approval24.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuVO {
    private Long menuId;           // 메뉴 ID
    private String menuName;       // 메뉴 이름
    private String menuUrl;        // 메뉴 URL
    private Long parentMenuId;     // 부모 메뉴 ID
    private Long seq;            // 메뉴 순서
    private String popupYn;        // 팝업 여부

    // 권한 정보
    private String readYn;         // 조회 권한
    private String createYn;       // 등록 권한
    private String updateYn;       // 수정 권한
    private String deleteYn;       // 삭제 권한
    private String approveYn;      // 승인 권한
}
