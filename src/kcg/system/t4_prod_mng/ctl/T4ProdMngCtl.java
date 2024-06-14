package kcg.system.t4_prod_mng.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_prod_mng.svc.T4ProdMngSvc;

@Controller
@RequestMapping("/t4_prod_mng")
public class T4ProdMngCtl {
	@Autowired
	T4ProdMngSvc t4ProdMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@RequestMapping("/list")
	public String PageList(Model model) {
		return "/kcg/system/team4_mng/t4_prod_mng/T4ProdList";
	}
	
	@RequestMapping("/getList")
	public List<CmmnMap> GetList(CmmnMap params) {
		return t4ProdMngSvc.getList(params);
	}

}
