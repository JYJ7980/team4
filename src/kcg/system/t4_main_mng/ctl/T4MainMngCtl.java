package kcg.system.t4_main_mng.ctl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.annotation.JsonAnyGetter;

import kcg.common.svc.CommonSvc;
import kcg.system.t4_main_mng.svc.T4MainMngSvc;


@Controller
@RequestMapping("system/team4")
public class T4MainMngCtl {

	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	T4MainMngSvc t4MainMngSvc;
	
	@GetMapping("/main")
	public String t4Main() {
		return "kcg/system/team4_main_mng/team4_main";
	}
	
	@GetMapping("/notice")
	public String t4Notice() {
		return "kcg/system/team4_notice_mng/team4_notice";
	}

}
