package kcg.system.t4_main_mng.ctl;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kcg.common.svc.CommonSvc;
import kcg.system.t4_main_mng.svc.T4MainMngSvc;
import kcg.system.t4_notice_mng.svc.T4NoticeMng_Svc;

@Controller
@RequestMapping("system/team4")
public class T4MainMng_Ctl {
	
	@Autowired
	T4MainMngSvc mainMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	T4NoticeMng_Svc t4NoticeMng_Svc;
	
	@GetMapping("/main")
	public String team4Main() {
		return "kcg/system/team4_mng/main";
	}
	

	@GetMapping("notice_main")
	public String noticeMain() {
		return "kcg/system/team4_mng/notice/notice_main";
	}
	
	@GetMapping("/employee/emcreateform")
	public String newCreateManagementForm(){
		return "kcg/system/team4_mng/employee/emcreateform";
	}
	
	@GetMapping("/employee/employeelist")
	public String employeeList(){
		return "kcg/system/team4_mng/employee/employeelist";
	}
	
}


