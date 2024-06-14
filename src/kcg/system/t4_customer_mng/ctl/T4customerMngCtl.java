package kcg.system.t4_customer_mng.ctl;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kcg.common.svc.CommonSvc;
import kcg.system.t4_main_mng.svc.T4MainMngSvc;

@Controller
@RequestMapping("system/team4")
public class T4customerMngCtl {
	
	@Autowired
	T4MainMngSvc mainMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@GetMapping("/customerInfoPage")
	public String customerInfoPage() {
		return "kcg/system/team4_mng/test";
	}

}
