package kcg.system.t4_customer_mng.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;
import kcg.system.t4_customer_mng.svc.T4customerMngSvc;

@Controller
@RequestMapping("system/team4")
public class T4customerMngCtl {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	T4customerMngSvc svc;

	@Autowired
	CommonSvc commonSvc;

	@Autowired
	CmmnDao cmmnDao;


	// 고객정보관리 페이지로 이동
	@GetMapping("/customerInfoPage")
	public String customerInfoPage() {
		return "kcg/system/team4_mng/customer_mng/customerInfoPage";
	}

	
	// 전체 조회
	@GetMapping("/getCustInfo")
	public List<CmmnMap> getCustInfo(CmmnMap params) {
        return svc.getAllCustomers(params);
    }
	
	//담당 고객 삭제
	@RequestMapping("/deleteCust")
	public CmmnMap deleteCust(CmmnMap params){
		return svc.deleteCust(params); 
		
	}



	
	
	

}