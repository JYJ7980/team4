package kcg.system.t4_main_mng.ctl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_main_mng.svc.T4MainMngSvc;
import kcg.system.t4_notice_mng.svc.T4NoticeMng_Svc;

@Controller
@RequestMapping("system/team4")
public class T4MainMng_Ctl {
	
	@Autowired
	T4MainMngSvc t4mainMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	T4NoticeMng_Svc t4NoticeMng_Svc;
	
	@GetMapping("/main")
	public String team4Main() {
		return "kcg/system/team4_mng/main";
	}
	
	@GetMapping("/birthDay")
	public CmmnMap birthDay() {
		return t4mainMngSvc.birthDay();
	}
	
	@GetMapping("/end")
	public CmmnMap ending() {
		return t4mainMngSvc.productEnd();
	}

	@GetMapping("/noticeTop2")
	public List<CmmnMap> noticeList(){
		return t4mainMngSvc.noticeTop2();
	}
	
	@GetMapping("/deposit")
	public CmmnMap deposit(){
		return t4mainMngSvc.deposit();
	}
	
	@GetMapping("/savings")
	public CmmnMap savings(){
		return t4mainMngSvc.savings();
	}
	
	@GetMapping("/loan")
	public CmmnMap loan(){
		return t4mainMngSvc.loan();
	}
	
	@GetMapping("/event")
	public CmmnMap event(){
		return t4mainMngSvc.event();
	}

	@GetMapping("/popular")
	public CmmnMap popular() {
		return t4mainMngSvc.popular();

	}
	
}

