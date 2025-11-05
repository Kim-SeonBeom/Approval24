<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="content-wrapper" class="d-flex flex-column">
	<div id="approval-editor-area">
		<div class="container-fluid mb-4">

			<div class="card shadow mb-4">
				<div class="card-header py-3 d-flex align-items-center justify-content-between">
					<h3 class="m-0">결재 라인 편집기</h3>
					<button type="button" class="btn btn-primary btn-sm" id="addLineBtn">결재자 추가</button>
				</div>
				<div class="card-body">
					<table class="table table-bordered mb-0  text-center" width="100%">
						<colgroup>
							<col style="width: 5%">
							<!-- 부서 -->
							<col style="width: 20%">
							<!-- 부서 select -->
							<col style="width: 5%">
							<!-- 계정 -->
							<col style="width: 20%">
							<!-- 계정 select -->
							<col style="width: 10%">
							<!-- 승인자 유형 -->
							<col style="width: 40%">
							<!-- 승인자 select -->
						</colgroup>
						<tbody>
							<tr>
								<th>부서 선택</th>
								<td><select class="form-control w-auto" id="deptSelect">
										<option value="">-- 부서 선택 --</option>
								</select></td>
								<th>계정 선택</th>
								<td><select class="form-control w-auto" id="accountSelect">
										<option value="">-- 계정 선택 --</option>
								</select></td>
								<th>승인자 유형</th>
								<td><select class="form-control w-auto" id="approverTypeSelect">
										<option value="">-- 승인자 유형 선택 --</option>
								</select></td>
							</tr>

						</tbody>
					</table>
					<table class="table table-bordered mb-0  text-center" width="100%" id="approvalLineTable">
						<colgroup>
							<col style="width: 25%">
							<col style="width: 25%">
							<col style="width: 25%">
							<col style="width: 25%">

						</colgroup>
						<thead>
							<tr>
								<th>부서</th>
								<th>계정</th>
								<th>승인자 유형</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>

					<div class="text-right">
						<button type="button" class="btn btn-primary mt-3" id="submitApprovalBtn">결재 등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {

    const deptSel = document.getElementById("deptSelect");
    const accSel = document.getElementById("accountSelect");
    const typeSel = document.getElementById("approverTypeSelect");
    const tableBody = document.querySelector("#approvalLineTable tbody");

    // 부서 목록 불러오기
    fetch("/approval24/api/common/depts")
        .then(res => res.json())
        .then(list => {
            list.forEach(d => {
                const opt = document.createElement("option");
                opt.value = d.deptId;
                opt.text = d.deptName;
                deptSel.appendChild(opt);
            });
        });

    // 부서 선택 시 계정 목록 갱신
    deptSel.addEventListener("change", () => {
        const deptId = deptSel.value;
        accSel.innerHTML = '<option value="">-- 계정 선택 --</option>';

        if (!deptId) return;

        fetch(`/approval24/api/common/accounts?deptId=\${deptId}`)
            .then(res => {
                if (!res.ok) throw new Error("계정 목록 조회 실패");
                return res.json();
            })
            .then(list => {
                list.forEach(a => {
                    const opt = document.createElement("option");
                    opt.value = a.accountId;
                    opt.text = a.userName;
                    accSel.appendChild(opt);
                });
            })
            .catch(err => console.error(err));
    });

    // 승인자 유형 코드 목록 불러오기 (그룹ID: F0)
    fetch("/approval24/api/common/codes?groupId=F0")
        .then(res => res.json())
        .then(list => {
            list.forEach(c => {
                const opt = document.createElement("option");
                opt.value = c.codeId;
                opt.text = c.codeName;
                typeSel.appendChild(opt);
            });
        });

    // 결재자 추가
    document.getElementById("addLineBtn").addEventListener("click", () => {
        if (!deptSel.value || !accSel.value || !typeSel.value) {
            alert("부서, 계정, 승인자 유형을 모두 선택하세요.");
            return;
        }

        const tr = document.createElement("tr");
        tr.innerHTML = `
            <td data-id="\${deptSel.value}">\${deptSel.options[deptSel.selectedIndex].text}</td>
            <td data-id="\${accSel.value}">\${accSel.options[accSel.selectedIndex].text}</td>
            <td data-id="\${typeSel.value}">\${typeSel.options[typeSel.selectedIndex].text}</td>
            <td><button type="button" class="btn btn-danger btn-sm btn-del">삭제</button></td> 
        `;
        tableBody.appendChild(tr);
    });

    // 삭제 버튼 이벤트
    tableBody.addEventListener("click", (e) => {
        if (e.target.classList.contains("btn-del")) {
            e.target.closest("tr").remove();
        }
    });

    // 결재 등록
    document.getElementById("submitApprovalBtn").addEventListener("click", () => {
        const rows = tableBody.querySelectorAll("tr");
        if (rows.length === 0) {
            alert("결재 라인을 추가하세요.");
            return;
        }

        const approvalLineData = Array.from(rows).map(tr => ({
            deptId: tr.children[0].dataset.id,
            accountId: tr.children[1].dataset.id,
            approverTypeCd: tr.children[2].dataset.id 
        }));
        
        const complainIdString = $('input[name="complainId"]').val();
        
        if (!complainIdString || isNaN(complainIdString)) {
            return console.error("민원 ID가 유효하지 않습니다. HTML input[id='complain-id']의 value를 확인하세요.");
        }

        const complainIdInt = parseInt(complainIdString, 10);
        
        const requestBody = {
            complainId: complainIdInt, 
            contextUrl: window.location.href,
            approvalLineData: approvalLineData
        };

        console.log("보내는 데이터:", JSON.stringify(requestBody, null, 2));

        fetch("/approval24/api/approval/create", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(requestBody)
        })
        .then(res => res.json())
        .then(result => {
            alert(result.message || "결재 등록 완료");
        })
        .catch(err => {
            console.error(err);
            alert("결재 등록 중 오류가 발생했습니다.");
        });
    });

});
</script>