package kcg.system.t4_customer_mng.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
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

	
	@GetMapping("/getCustInfo")
	public List<CmmnMap> getCustInfo() {
	    List<CmmnMap> dataList = cmmnDao.selectList("getAllCustomers", null); // 여기서 params에 null을 전달하거나 필요한 경우 적절한 파라미터를 전달하세요.
	    System.out.println(dataList);
	    return dataList;
	}
	
	
	
	
	
	
	
	
	//design 폴더에서 오류나서 일단 되는 곳에서 코드들 정상 작동하는지 확인용 코드들 나중에 복사해서 폴더 옮기기
	
	@GetMapping("subscriptionForm")
	public String subsciptionForm(Model model) {
		return "kcg/system/team4_mng/t4_design_mng/SubscriptionForm";
	}

	
	@RequestMapping("productList")
	public List<CmmnMap> productList(CmmnMap params){
		
		List<CmmnMap> productList = cmmnDao.selectList("getProductList", params);
		System.out.println(productList.toString());
		return productList;
	}
	
	@RequestMapping("proSelectOne")
	public CmmnMap proSelectOne(CmmnMap params) {
		CmmnMap getOne = cmmnDao.selectOne("selectOneProduct", params);
		return getOne;
	}

	@RequestMapping("customerList")
	public List<CmmnMap> customerList(CmmnMap params){

		List<CmmnMap> customerList = cmmnDao.selectList("getCustomerList", params);
		System.out.println(customerList.toString());
		return customerList;
	}
	
	@RequestMapping("cusSelectOne")
	public CmmnMap cusSelectOne(CmmnMap params) {
		CmmnMap getOne = cmmnDao.selectOne("selectOneCustomer", params);
		System.out.println(getOne.toString());
		return getOne;
	}
	
	@PostMapping("subscription")
	public String insert(CmmnMap params) {
		System.out.println("==========================================");
		System.out.println("==========================================");
		System.out.println("==========================================");
		cmmnDao.insert("insertProduct", params);
		

//	    params.put("start_money", Integer.parseInt((String) params.get("start_money")));
//	    params.put("cycle_money", Integer.parseInt((String) params.get("cycle_money")));
//	    params.put("loan", Integer.parseInt((String) params.get("loan")));
//	    params.put("product_id", Integer.parseInt((String) params.get("product_id")));
//	    params.put("customer_id", Integer.parseInt((String) params.get("customer_id")));

		return "kcg/system/team4_mng/t4_design_mng/SubscriptionForm";
	}
	

}
