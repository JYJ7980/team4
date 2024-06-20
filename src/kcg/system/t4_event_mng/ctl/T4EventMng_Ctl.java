package kcg.system.t4_event_mng.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import kcg.system.t4_event_mng.svc.T4EventMng_Svc;

@Controller
@RequestMapping("/system/team4/event")
public class T4EventMng_Ctl {
	
	@Autowired
	T4EventMng_Svc t4EventMng_Svc;
	
	@GetMapping("/eventCalender")
	public String eventCalender() {
		return "kcg/system/team4_mng/event/eventCalender";
	}
	
	@PostMapping("/eventFind")
	public List<CmmnMap> calenderDateCal(CmmnMap params) {
		return t4EventMng_Svc.eventFind(params);
	}
	
	@PostMapping("/eventFindPlus")
	public List<CmmnMap> calenderDateCalPlus(CmmnMap params) {
		return t4EventMng_Svc.eventFindPlus(params);
	}
}
