package com.example.approval24.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AuthorityDTO {
    private Long authorityId;      // AUTHORITY_ID
    private String authorityName;  // AUTHORITY_NAME
    private Date createDt;         // CREATE_DT
    private Date updateDt;         // UPDATE_DT
    private Long createId;         // CREATE_ID
    private Long updateId;         // UPDATE_ID
    private String delYn;          // DEL_YN
    private String isSystem;       // IS_SYSTEM
    
    
    private String dateType;
	
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

    /** 최초 진입 등 필터가 모두 비었는지 판단 (Date는 null이면 비었다고 간주) */
    public boolean isEmptyFilter() {
        return isBlank(dateType)
            && createDt == null
            && updateDt == null
            && isBlank(delYn)
            && isBlank(authorityName)
            && isBlank(isSystem);
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
