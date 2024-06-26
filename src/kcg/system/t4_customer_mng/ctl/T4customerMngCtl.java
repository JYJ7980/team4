package kcg.system.t4_customer_mng.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;
import kcg.system.t4_customer_mng.svc.T4customerMngSvc;

@Controller
@RequestMapping("system/team4")
public class T4customerMngCtl {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	T4customerMngSvc svc;

	@Autowired
	CommonSvc commonSvc;

	@Autowired
	CmmnDao cmmnDao;

	// 고객정보관리 페이지로 이동
	@GetMapping("/customerInfoPage")
	public String customerInfoPage() {
		return "kcg/system/team4_mng/customer_mng/customerInfoPage";
	}

	// 고객 정보 전체 조회
	@GetMapping("/getCustInfo")
	public List<CmmnMap> getCustInfo(CmmnMap params) {
		return svc.getAllCustomers(params);
	}

	
	//관리자 정보 전체 조회
	@GetMapping("/getUserInfo")
	public List<CmmnMap> getUserInfo(CmmnMap params) {
		return svc.getUserInfo(params);
	}
	
	//고객정보+담당 관리자정보 전체 조회
	@GetMapping("/getCustAndUserInfo")
	public List<CmmnMap> getCustAndUserInfo(CmmnMap params) {
		return svc.getCustAndUserInfo(params);
	}
	
	
	//고객 가입 상품 조회
	@GetMapping("/getSubProductInfo")
	public List<CmmnMap> getSubProductInfo(CmmnMap params) {
		return svc.getSubProductInfo(params);
	}
	
	//고객 설계 상품 조회
	@GetMapping("/getDesignProductInfo")
	public List<CmmnMap> getDesignProductInfo(CmmnMap params) {
		return svc.getDesignProductInfo(params);
	}

	// 고객 주민번호 중복 확인용 조회
	@GetMapping("/getCustIdNumber")
	public List<CmmnMap> getCustIdNumber(CmmnMap params) {
		return svc.getCustIdNumber(params);
	}

	// 탈퇴 회원 주민번호 중복 확인용 조회
	@GetMapping("/getQuitCustIdNumber")
	public List<CmmnMap> getQuitCustIdNumber(CmmnMap params) {
		return svc.getQuitCustIdNumber(params);
	}

	
	//고객 전화번호 중복 확인용 고객 조회
	@GetMapping("/getCustPhone")
	public List<CmmnMap> getCustPhone(CmmnMap params) {
		return svc.getCustPhone(params);
	}

	
	

	// 고객 추가
	@RequestMapping("/addCust")
	public CmmnMap addCust(CmmnMap params) {
		return svc.addCust(params);

	}

	//고객 삭제
	@RequestMapping("/deleteCust")
	public CmmnMap deleteCust(CmmnMap params) {
		return svc.deleteCust(params);

	}

	// 담당 고객정보 변경
	@RequestMapping("updateCust")
	public CmmnMap updateCust(CmmnMap params) {
		return svc.updateCust(params);
	}
	

	//관리자 수정
	@RequestMapping("/updateUser")
	public CmmnMap updateUser(CmmnMap params) {
		return svc.updateUser(params);
	}
	

	// 고객 상담내역 페이지로 이동
	@GetMapping("/consultListPage")
	public String consultListPage() {
		return "kcg/system/team4_mng/customer_mng/consultListPage";
	}

	// 상담내역 전체 조회
	@RequestMapping("/getAllconsult")
	public PageList<CmmnMap> getAllconsult(CmmnMap params,PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = svc.getAllconsult(params,pagingConfig);
		return pageList;
	}
	
	
	//상담 내역 조회 필터링(내 담당 고객만)
	@RequestMapping("/getAllMyconsult")
	public PageList<CmmnMap> getAllMyconsult(CmmnMap params,PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = svc.getAllMyconsult(params,pagingConfig);
		return pageList;
	}
	
	
	//고객 별 상담내역 
	@GetMapping("/getCustConsult")
	public List<CmmnMap> getCustConsult(CmmnMap params) {
		return svc.getCustConsult(params);
	}
	
	
	
	
	// 상담내역 추가 페이지로 이동
	@GetMapping("/insertConsult")
	public String insertConsultPage() {
		return "kcg/system/team4_mng/customer_mng/insertConsultPage";
	}

	// 상담내역 추가
	@RequestMapping("/addConsult")
	public CmmnMap addConsult(CmmnMap params) {
		return svc.addConsult(params);

	}

	// 탈퇴고객 조회 페이지로 이동
	@GetMapping("/quitCustomerInfoPage")
	public String quitCustomerInfoPage() {
		return "kcg/system/team4_mng/customer_mng/quitCustomerInfoPage";
	}

	// 탈퇴 고객 정보 전체 조회[부장급 사원용]
	@RequestMapping("/getQuitCustInfo")
	public PageList<CmmnMap> getQuitCustInfo(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = svc.getQuitCustInfo(params, pagingConfig);
		return pageList;
	}
	
	// 탈퇴 고객 복구
	@RequestMapping("/releaseQuitCust")
	public CmmnMap releaseQuitCust(CmmnMap params) {
		return svc.releaseQuitCust(params);

	}
	
	//부장용 고객관리 페이지 이동
	@GetMapping("/customerInfoPageForLeader")
	public String customerInfoPageForLeader() {
		return "kcg/system/team4_mng/customer_mng/customerInfoPageForLeader";
	}
	
	

	

}