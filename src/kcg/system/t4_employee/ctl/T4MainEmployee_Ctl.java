package kcg.system.t4_employee.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_employee.svc.T4Employee_Svc;

@Controller
@RequestMapping("system/team4/employee")
public class T4MainEmployee_Ctl {

	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	T4Employee_Svc t4Employee_Svc;
	
	@Autowired
	CmmnDao cmmnDao;
	

	@PostMapping("/save")
	public CmmnMap createEmployee(CmmnMap params) {
		return t4Employee_Svc.insertEmployee(params);
	}
}

