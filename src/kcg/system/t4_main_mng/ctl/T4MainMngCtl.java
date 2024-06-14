package kcg.system.t4_main_mng.ctl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kcg.common.svc.CommonSvc;
import kcg.system.t4_main_mng.svc.T4MainMngSvc;

@Controller
@RequestMapping("t4_main_mng")
public class T4MainMngCtl {
	
	@Autowired
	T4MainMngSvc mainMngSvc;
	
	@Autowired
	CommonSvc commonSvc;

}
