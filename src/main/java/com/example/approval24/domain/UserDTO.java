package com.example.approval24.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserDTO {
    private String userResidentNo; // 주민등록번호
    private Long userNo;           // 사용자 번호 (PK)
    private String userName;       // 사용자 이름
    private String userEmail;      // 이메일
    private String userTel;        // 전화번호
    private String userPhone;      // 휴대전화
    private String userPositionCd; // 직급 코드
    private String delYn;          // 삭제 여부
    private Date createDt;         // 생성일
    private Date updateDt;         // 수정일
    private Long createId;         // 생성자 ID
    private Long updateId;         // 수정자 ID
    private Long instId;		   //기관 ID
    
    private String accountStatusCd;
    
    //추가사항
    private String userPositionName; //직급 이름
    
    
    private String dateType;
    
    private List<Long> userNoList;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }
    
    /** 컨트롤러에서 전달한 원시 문자열을 안전하게 파싱해서 Date 필드에 세팅 */
    public void applyDateStrings(String createDtStr, String updateDtStr) {
        this.createDt = parseYmdOrNull(createDtStr);
        this.updateDt = parseYmdOrNull(updateDtStr);
    }
    
    

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && createDt==null && updateDt==null
                && isBlank(delYn) && isBlank(userName) && isBlank(userPositionName)
                && isBlank(userEmail) && isBlank(userPhone));
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
    private static Date parseYmdOrNull(String s) {
        if (isBlank(s)) return null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false);
            return sdf.parse(s.trim());
        } catch (ParseException e) {
            return null; // 잘못된 값은 과감히 무시(기간 필터 미적용)
        }
    }
}
