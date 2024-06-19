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

	
	// 고객 정보 전체 조회
	@GetMapping("/getCustInfo")
	public List<CmmnMap> getCustInfo(CmmnMap params) {
        return svc.getAllCustomers(params);
    }
	
	
	//고객 전체 주민번호 조회
	@GetMapping("/getCustIdNumber")
	public List<CmmnMap> getCustIdNumber(CmmnMap params){
		return svc.getCustIdNumber(params);
	}
	

	
	//고객 추가
	@RequestMapping("/addCust")
	public CmmnMap addCust(CmmnMap params){
		return svc.addCust(params); 
		
	}
	
	//담당 고객 삭제
	@RequestMapping("/deleteCust")
	public CmmnMap deleteCust(CmmnMap params){
		return svc.deleteCust(params); 
		
	}
	
	//담당 고객정보 변경
	@RequestMapping("updateCust")
	public CmmnMap updateCust(CmmnMap params) {
		return svc.updateCust(params);
	}
	
	
	//고객 상담내역 페이지로 이동
	@GetMapping("/consultListPage")
	public String consultListPage() {
		return "kcg/system/team4_mng/customer_mng/consultListPage";
	}
	

	
	//상담내역 전체 조회
	@GetMapping("/getAllconsult")
	public List<CmmnMap> getAllconsult(CmmnMap params) {
        return svc.getAllconsult(params);
    }
	
	//상담내역 추가 페이지로 이동
	@GetMapping("/insertConsult")
	public String insertConsultPage() {
		return "kcg/system/team4_mng/customer_mng/insertConsultPage";
	}
	
	//상담내역 추가
	@RequestMapping("/addConsult")
	public CmmnMap addConsult(CmmnMap params){
		return svc.addConsult(params); 
		
	}
	

	
	
	

}