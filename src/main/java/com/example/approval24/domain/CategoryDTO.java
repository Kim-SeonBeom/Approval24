package com.example.approval24.domain;

import lombok.Data;

@Data
public class CategoryDTO {

	private long complainCategoryId;
	
	private String categoryName;
	
	private String categoryCd;
	
	private String createDt;
	
	private String updateDt;
	
	private Integer dueDt;
	private Integer dueStart;
	private Integer dueEnd;
	
	private long createId;
	
	private long updateId;
	
	private String delYn;
	
	private String categoryUrl;	
	
	private String codeId;
	
	private String codeName;
	
	
	private String dateType;
	
	private int page = 1;          
    private int size = 10;         

    public int getOffset() {
        return (page - 1) * size;
    }

    public boolean isEmptyFilter() {
        return (isBlank(dateType) && isBlank(createDt) && isBlank(updateDt)
                && isBlank(delYn) && isBlank(categoryName) && isBlank(categoryCd)
                && isNullOrEmpty(dueDt) && isBlank(categoryUrl) && isBlank(codeId) && isBlank(codeName)
                && isNullOrEmpty(dueStart) && isNullOrEmpty(dueEnd));
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
    
    private boolean isNullOrEmpty(Object o) {
        return o == null || o.toString().trim().isEmpty();
    }

}



 

