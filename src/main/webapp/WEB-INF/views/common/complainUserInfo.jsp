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
							name="complainuser_name"></td>
						<th>주민등록번호</th>
						<td><input type="text" id="complainuser_resi_no_front"
							maxlength="6" inputmode="numeric" pattern="[0-9]*"
							placeholder="생년월일 6자리" style="width: 40%; display: inline-block;">
							<span class="mx-1">-</span> <input type="text"
							id="complainuser_resi_no_back" maxlength="7" inputmode="numeric"
							pattern="[0-9]*" placeholder="뒤 7자리"
							style="width: 50%; display: inline-block;"></td>
					</tr>
					<tr>
						<th scope="col" class="text-dark bg-light font-weight-bold"
							style="vertical-align: middle;">주소</th>
						<td colspan="3">
							<div class="d-flex mb-2">
								<input type="text" class="form-control form-postal-code mr-2"
									placeholder="우편번호" name="complainuser_post"
									id="complainuser_post" readonly style="width: 150px;">

								<button type="button" class="btn btn-secondary"
									onclick="openDaumPostcode()">주소 검색</button>
							</div> <input type="text" class="form-control mb-2" placeholder="기본 주소"
							name="complainuser_addr1" id="complainuser_addr1" readonly>
							<input type="text" class="form-control"
							placeholder="상세 주소 (건물명, 동/호수 등)" name="complainuser_addr2"
							id="complainuser_addr2">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="tel" class="form-control"
							name="complainuser_tel"></td>
						<th>휴대전화번호</th>

						<td><input type="tel" class="form-control"
							name="complainuser_phone"></td>

					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3"><input type="email" class="form-control"
							name="complainuser_email"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>