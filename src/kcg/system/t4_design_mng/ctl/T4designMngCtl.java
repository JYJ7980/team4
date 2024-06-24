package kcg.system.t4_design_mng.ctl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_design_mng.svc.Calculator;
import kcg.system.t4_design_mng.svc.T4designMngSVC;

@Controller
@RequestMapping("team4")
public class T4designMngCtl {

	@Autowired
	T4designMngSVC svc;
	
	@Autowired
	Calculator cal;
	
	@Autowired
	CommonSvc commonSvc;

	@Autowired
	CmmnDao cmmnDao;

	
	
	//상품가입 및 리스트 출력 CRUD
	
	@GetMapping("subscriptionForm")
	public String subsciptionForm(Model model) {
		return "kcg/system/team4_mng/t4_design_mng/SubscriptionForm";
	}
	
	
	@RequestMapping("productList")
	public List<CmmnMap> productList(CmmnMap params){
		
		List<CmmnMap> productList = cmmnDao.selectList("getProductList", params);
		return productList;
	}
	
	@RequestMapping("proSelectOne")
	public CmmnMap proSelectOne(CmmnMap params) {
		CmmnMap getOne = cmmnDao.selectOne("selectOneProduct", params);
		return getOne;
	}
	
	@RequestMapping("typeProductList")
	public List<CmmnMap> typeProductList(CmmnMap params){
		
		List<CmmnMap> productList = cmmnDao.selectList("selectTypeProductList", params);
		return productList;
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

		cmmnDao.insert("insertProduct", params);
		
		return "kcg/system/team4_mng/t4_design_mng/SubscriptionList";
	}
	@GetMapping("subscriptionList")
	public String subscriptionList() {
		
		return "kcg/system/team4_mng/t4_design_mng/SubscriptionList";
	}
	
	@RequestMapping("/getListPaging")
	public PageList<CmmnMap> getListPaging(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> rslt = cmmnDao.selectListPage("getSubscriptionList", params, pagingConfig);
		return rslt;
	}
	
    @PostMapping("/deleteProduct")
    public List<CmmnMap> deleteProduct(CmmnMap params) {
        return cmmnDao.selectList("system.t4_design_mng.selectAllList", params);
    }
	
    @PostMapping("/deleteSingleItem")
    public List<CmmnMap> deleteSingleItem(CmmnMap params) {

    	svc.deleteProduct(params);
        return cmmnDao.selectOne("selectAllList", params);
    }
    
    @PostMapping("/moveUpdateForm")
    public CmmnMap moveUpdateForm(CmmnMap params) {

        CmmnMap rslt = cmmnDao.selectOne("selectOneSub", params);
        return rslt;
    }
    
    @PostMapping("updateSubscription")
    public String updateSub(CmmnMap params) {
    	svc.updateSub(params);
    	
		return "kcg/system/team4_mng/t4_design_mng/SubscriptionList";
    }
    
    
	@RequestMapping("/calculate")
	public String openPageDtl(Model model, CmmnMap params) {
		
		String sProdTyCd = params.getString("prod_ty_cd", "1");
		model.addAttribute("prod_ds_sn", params.getString("prod_ds_sn", ""));			// 설계설계번호
		model.addAttribute("cust_mbl_telno", params.getString("cust_mbl_telno", ""));	// 고객KEY
		model.addAttribute("prod_ty_cd", sProdTyCd);	
		// 설계타입코드 : 1.적금설계, 2.목돈마련설계, 3.예금설계, 4.대출설계
		model.addAttribute("design_id", params.getString("design_id", ""));	// 고객KEY
		model.addAttribute("product_id", params.getString("product_id", ""));	// 고객KEY
		model.addAttribute("customer_id", params.getString("customer_id", ""));	// 고객KEY

		
		String sRsltUrl = "";
		if("1".equals(sProdTyCd)) {
			sRsltUrl = "kcg/system/team4_mng/t4_design_mng/CalculateSavings"; //적금
		}else if("2".equals(sProdTyCd)) { 
			sRsltUrl = "kcg/system/team4_mng/t4_design_mng/CalculateLump"; //목돈
		}else if("3".equals(sProdTyCd)) {
			sRsltUrl = "kcg/system/team4_mng/t4_design_mng/CalculateDeposit"; //예금
		}else if("4".equals(sProdTyCd)) {
			sRsltUrl = "kcg/system/team4_mng/t4_design_mng/CalculateLoan"; //대출
		}
		
		return sRsltUrl;
	}
    
	@RequestMapping("designCusInfo")
	public CmmnMap designCusInfo(CmmnMap params) {

		return svc.designCusInfo(params);	 
	}
	
	@RequestMapping("saveCalulate")
	public String saveCalulate(CmmnMap params) {
		System.out.println("===========================================");
		System.out.println("params: " + params.toString());
		

		svc.saveCalulate(params);
		return "kcg/system/team4_mng/t4_design_mng/CalculateDeposit";
	}
	
	@GetMapping("designList")
	public String designList() {
		return "kcg/system/team4_mng/t4_design_mng/DesignList";
	}
	
	@RequestMapping("/designListPaging")
	public PageList<CmmnMap> designListPaging(CmmnMap params, PagingConfig pagingConfig) {
		
		return svc.designListPaging(params, pagingConfig);
	}
	
	
    @PostMapping("/moveDesignInfoForm")
    public CmmnMap moveDesignInfoForm(CmmnMap params) {
    	
        return svc.moveDesignInfoForm(params);
    }
    
    @PostMapping("/deleteDesign")
    public List<CmmnMap> deleteDesign(CmmnMap params) {
    	
        svc.deleteDesign(params);
    	return svc.selectAllDes(params);
    }
	
    
    @PostMapping("/deleteSingleDesign")
    public List<CmmnMap> deleteSingleDesign(CmmnMap params) {

    	System.out.println("==========================");
    	System.out.println("=params: " + params.toString());

    	svc.deleteSingleDesign(params);
    	return svc.selectAllDes(params);
    }
    
	@RequestMapping("/calculator")
	public List<CmmnMap> calculator(CmmnMap params) {
		
		String sProdTyCd = params.getString("prod_ty_cd");
		List<CmmnMap> list = new ArrayList<>();
		
		System.out.println("===========================");
		System.out.println("sProdTyCd: " + sProdTyCd);
		System.out.println("params: " + params.toString());

		if("1".equals(sProdTyCd)) {
			
			list = cal.calculateSavings(params);
			return list;
		}else if("2".equals(sProdTyCd)) {
			
			list = cal.calculateLump(params);
			return list;
		}else if("3".equals(sProdTyCd)) {

			list = cal.calculateDeposit(params);
			return list;
			
		}else{
			list = cal.calculateLoan(params);
			return list;
		}
	}
	
	

}