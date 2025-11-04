package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.DeptDAO;
import com.example.approval24.dao.DeptInstDAO;
import com.example.approval24.dao.InstDAO;
import com.example.approval24.domain.DeptDTO;
import com.example.approval24.domain.DeptInstDTO;
import com.example.approval24.domain.InstDTO;

@Service
public class DeptService {

    @Autowired
    private InstDAO instdao;

    @Autowired
    private DeptInstDAO deptinstdao;

    @Autowired
    private DeptDAO deptdao;

    // 전체 부서
    public List<DeptDTO> getAllDept() {
        return deptdao.getAllDept();
    }

    // 부서 상세 조회
    public DeptDTO deptInfo(long deptId) {
        return deptdao.deptInfo(deptId);
    }

    // 특정 부서의 매핑 기관명
    public List<DeptInstDTO> instByDept(long deptId) {
        return deptinstdao.instByDept((long) deptId);
    }
    
    // 전체 기관 리스트
    public List<InstDTO> getAllInst() {
        return instdao.getAllInst();
    }

    // 부서 수정: 기본정보 업데이트 + 매핑(삭제 후 재등록 - 원래 물리삭제가 아닌 논리삭제여야 됨. 리팩토링 필요)
    @Transactional
    public int updateDept(long deptId, String deptName, String deptPhone, List<Long> instIds) {
        // 부서 기본 정보 업데이트
        DeptDTO dto = new DeptDTO();
        dto.setDeptId(deptId);
        dto.setDeptName(deptName);
        dto.setDeptPhone(deptPhone);
        int a = deptdao.updateDept(dto);

        // 기존 매핑 삭제
        int d = deptinstdao.deleteDI((long) deptId);

        // 단일 매핑을 for문으로 반복 등록
        int i = 0;
        if (instIds != null && !instIds.isEmpty()) {
            for (Long instId : instIds) {
                if (instId == null) continue;
                i += deptinstdao.insertDI((long) deptId, instId.longValue());
            }
        }

        return a + d + i;
    }

    // 부서 삭제
    public int deleteDept(long deptId) {
        return deptdao.deleteDept(deptId);
    }

    // 부서 등록 + 매핑(삭제 후 재등록 - 원래 물리삭제가 아닌 논리삭제여야 됨. 리팩토링 필요)
    @Transactional
    public int insertDept(String deptName, String deptPhone, List<Long> instIds) {
        // 부서 기본 저장
        DeptDTO dto = new DeptDTO();
        dto.setDeptName(deptName);
        dto.setDeptPhone(deptPhone);
        int d = deptdao.insertDept(dto);

        long deptId = dto.getDeptId();

        int i = 0;
        if (instIds != null && !instIds.isEmpty()) {
            for (Long instId : instIds) {
                if (instId == null) continue;
                i += deptinstdao.insertDI((long) deptId, instId.longValue());
            }
        }

        return d + i;
    }
}
