package kcg.system.t4_main_mng.ctl;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
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
	
	@GetMapping("/emcreateform")
	public String newCreateManagementForm(Model model){
		LocalDate currentDate = LocalDate.now();
        model.addAttribute("currentDate", currentDate);
		return "kcg/system/team4_mng/emcreateform";
	}
	
	@PostMapping("/emcreateform")
	public String newCreateManagement(@ModelAttribute CmmnMap params) {
			mainMngSvc.createManagement(params);
		return "kcg/system/team4_mng/emcreateform";
	}
}


