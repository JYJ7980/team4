package kcg.system.t4_employee.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_employee.svc.T4Employee_Svc;

@Controller
@RequestMapping("system/team4/employee")
public class T4MainEmployee_Ctl {

	@Autowired
	CommonSvc commonSvc;

	@Autowired
	T4Employee_Svc t4Employee_Svc;

	@Autowired
	CmmnDao cmmnDao;
	
	@GetMapping("/employeeList")
	public String employeeListMain() {
		return "kcg/system/team4_mng/employee/employeelist";
	}
	
	@GetMapping("/emp")
	public String emp() {
		return "kcg/system/team4_mng/employee/emcreateform";
	}
	@GetMapping("/employeeInsert")
	public String employeeInsert() {
		return "kcg/system/team4_mng/employee/emcreateform";
	}
	
	/* 신규 계정 저장 */
	@PostMapping("/save")
	public CmmnMap createEmployee(CmmnMap params) {
		return t4Employee_Svc.insertEmployee(params);
	}

	/* 담당자 전체 리스트 가져오기 */
	@RequestMapping("/list")
	public List<CmmnMap> getList(CmmnMap params) {
		List<CmmnMap> dataList = t4Employee_Svc.employeelist(params);
		return dataList;
	}

	/* 담당자 정보 가져오기 */
	@RequestMapping("/info")
	public CmmnMap employeeInfo(CmmnMap params) {
		CmmnMap dataList = t4Employee_Svc.employeeOne(params);
		return dataList;
	}

	/* 이름으로 조건검색 */
	@RequestMapping("/search")
	public List<CmmnMap> employeeSearch(CmmnMap params) {
		List<CmmnMap> selectList = t4Employee_Svc.employeeSearch(params);
		return selectList;
	}

	/* 담당자의 전체 검색 */
	@RequestMapping("/searchAll")
	public List<CmmnMap> searchAll(CmmnMap params) {
		List<CmmnMap> dataList = t4Employee_Svc.employeeSearchAll(params);
		return dataList;
	}

	/* 담당자의 정보 수정 */
	@RequestMapping("/update")
	public CmmnMap updateEmployee(CmmnMap params) {
		CmmnMap data = t4Employee_Svc.updateEmployee(params);
		return data;
	}

	/* 담당자의 정보 삭제 */
	@RequestMapping("/delete")
	public CmmnMap deleteEmployee(CmmnMap params) {
		CmmnMap data = t4Employee_Svc.deleteEmployee(params);
		return data;
	}

	/* 신규 담당자의 ID 확인 */
	@RequestMapping("/checkId")
	public CmmnMap checkId(CmmnMap params) {
		CmmnMap data = t4Employee_Svc.checkId(params);
		return data;
	}
	
	/* 비밀번호만 저장 */
	@RequestMapping("/updatePw")
	public CmmnMap updatePw(CmmnMap params) {
        CmmnMap data = t4Employee_Svc.updatePw(params);
         return data;
    }
	
	@RequestMapping("/status")
	public CmmnMap status(CmmnMap params) {
		CmmnMap data = t4Employee_Svc.status(params);
		return data;
	}
	@RequestMapping("/st")
	public List<CmmnMap> statusSearch(CmmnMap params) {
		List<CmmnMap> dataList = t4Employee_Svc.statusSearch(params);
		return dataList;
	}
	
	
	// 퇴직자 리스트 페이지로 이동
	@GetMapping("/quitUserInfoPage")
	public String quitCustomerInfoPage() {
		return "kcg/system/team4_mng/employee/quitUserInfoPage";
	}
	
	
	// 퇴직자 리스트 정보 전체 조회
	@RequestMapping("/getQuitUser")
		public PageList<CmmnMap> getQuitUser(CmmnMap params, PagingConfig pagingConfig) {
			PageList<CmmnMap> pageList = t4Employee_Svc.getQuitUser(params, pagingConfig);
			return pageList;
		}
	
	//재직자 리스트 조회
	@GetMapping("/getCurrentUserInfo")
	public List<CmmnMap> getCurrentUserInfo(CmmnMap params) {
		return t4Employee_Svc.getCurrentUserInfo(params);
	}
	
	
	//퇴직자 담당 고객 조회
	@GetMapping("/getQuitUserCustomerInfo")
	public List<CmmnMap> getQuitUserCustomerInfo(CmmnMap params) {
		return t4Employee_Svc.getQuitUserCustomerInfo(params);
	}
	
	//퇴직자 담당 고객 관리자 지정
	@RequestMapping("/changeQuitUser")
	public CmmnMap changeQuitUser(CmmnMap params) {
		return t4Employee_Svc.changeQuitUser(params);
	}
	
	@RequestMapping("/newEmployeeID")
	public CmmnMap newEmployeeID(CmmnMap params) {
		CmmnMap data = t4Employee_Svc.newEmployeeID(params);
		System.out.println("---------------------------------------------------------------------------------------------------------------");
		System.out.println(data.toString());
		return data;

	}
}
