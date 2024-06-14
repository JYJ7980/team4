package kcg.system.t4_main_mng.ctl;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kcg.common.svc.CommonSvc;
import kcg.system.t4_main_mng.svc.T4MainMngSvc;

@Controller
@RequestMapping("system/team4")
public class T4MainMngCtl {
	
	@Autowired
	T4MainMngSvc mainMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@GetMapping("/main")
	public String team4Main() {
		return "kcg/system/team4_mng/main";
	}
	
	@GetMapping("notice_main")
	public String noticeMain() {
		return "kcg/system/team4_mng/notice/notice_main";
	}

}
