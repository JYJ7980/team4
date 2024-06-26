package kcg.system.t4_active_mng.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import kcg.system.t4_active_mng.svc.T4ActiveMng_svc;

@Controller
@RequestMapping("system/team4/active")
public class T4ActiveMng_ctl {
	
	@Autowired
	T4ActiveMng_svc t4ActiveMng_svc;
	
	@GetMapping("/calender")
	public String calenderMain() {
		return"kcg/system/team4_mng/active/Calender";
	}
	
	@PostMapping("/calenderDateCal")
	public List<CmmnMap> calenderDateCal(CmmnMap params) {
		return t4ActiveMng_svc.findToDoList(params);
	}
	
	@PostMapping("/calUpdate")
	public CmmnMap calUpdate(CmmnMap params) {
		return t4ActiveMng_svc.updateCalender(params);
	}
	
	@PostMapping("/calDelete")
	public CmmnMap calDelete(CmmnMap params) {
		return t4ActiveMng_svc.deleteCalender(params);
	}
	
	@PostMapping("/save")
	public CmmnMap saveCalender(CmmnMap params) {
		return t4ActiveMng_svc.saveCalender(params);
	}
	
	@PostMapping("/teamSave")
	public CmmnMap teamSave(CmmnMap params) {
		return t4ActiveMng_svc.teamSaveCalender(params);
	}
	
	@PostMapping("/calenderDept")
	public List<CmmnMap> calenderDept(CmmnMap params) {
		return t4ActiveMng_svc.findDept(params);
	}
}
