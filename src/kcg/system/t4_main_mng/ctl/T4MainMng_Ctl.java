package kcg.system.t4_main_mng.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	T4MainMngSvc mainMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	T4NoticeMng_Svc t4NoticeMng_Svc;
	
	@GetMapping("/main")
	public String team4Main() {
		return "kcg/system/team4_mng/main";
	}
	


}