<%@page pageEncoding="UTF-8"%>
<div class="card shadow mb-4">
	<div class="card-header py-3 d-flex align-items-center">
		<h6 class="m-0 font-weight-bold text-primary">신청인 정보</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered mb-0" style="width: 100%">
				<colgroup>
					<col style="width: 18%">
					<col style="width: 32%">
					<col style="width: 18%">
					<col style="width: 32%">
				</colgroup>
				<tbody>
					<tr>
						<th>성명</th>
						<td><input type="text" class="form-control"
							name="complainuserName" required></td>
						<th>주민등록번호</th>
						<td><input type="text" class="form-control" id="complainuserResiNoFront" name="complainuserResiNoFront"
							maxlength="6"  pattern="[0-9]*"
							placeholder="생년월일 6자리" style="width: 40%; display: inline-block;" required>
							<span class="mx-1">-</span> <input type="password"  class="form-control" 
							id="complainuserResiNoBack" name="complainuserResiNoBack" maxlength="7" 
							pattern="[0-9]*" placeholder="뒤 7자리"
							style="width: 50%; display: inline-block;" required></td>
					</tr>
					<tr>
						<th scope="col" class="text-dark bg-light font-weight-bold"
							style="vertical-align: middle;">주소</th>
						<td colspan="3">
							<div class="d-flex mb-2">
								<input type="text" class="form-control form-postal-code mr-2"
									placeholder="우편번호" name="complainuserPost"
									id="complainuserPost" readonly style="width: 150px;">

								<button type="button" class="btn btn-secondary"
									onclick="openDaumPostcode()">주소 검색</button>
							</div> <input type="text" class="form-control mb-2" placeholder="기본 주소"
							name="complainuserAddress" id="complainuserAddress" readonly>
							<input type="text" class="form-control"
							placeholder="상세 주소 (건물명, 동/호수 등)" name="complainuserAddrDetail"
							id="complainuserAddrDetail" required>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="tel" class="form-control"
							name="complainuserTel"></td>
						<th>휴대전화번호</th>
						<td><input type="tel" class="form-control"
							name="complainuserPhone" required></td>

					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3"><input type="email" class="form-control"
							name="complainuserEmail"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>