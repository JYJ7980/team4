package kcg.system.t4_active_mng.ctl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("system/team4/active")
public class T4ActiveMng_ctl {
	
	
	@GetMapping("/calender")
	public String calenderMain() {
		return"kcg/system/team4_mng/active/Calender";
	}
}
