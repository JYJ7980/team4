package kcg.system.t4_design_mng.ctl;

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
import kcg.system.t4_design_mng.svc.T4designMngSVC;

@Controller
@RequestMapping("team4")
public class T4designMngCtl {

	@Autowired
	T4designMngSVC svc;

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
    
    //계산기파트
    @GetMapping("calculate")
    public String calculate(CmmnMap params) {
    	if (params.get("product_type") == "예금") {
    		return "kcg/system/team4_mng/t4_design_mng/CalculateDeposit";
    	} else if(params.get("product_type") == "적금"){
    		return "kcg/system/team4_mng/t4_design_mng/CalculateSavings";
    	} else if(params.get("product_type") == "대출") {
    		return "kcg/system/team4_mng/t4_design_mng/CalculateLoan";
    	} else {
    		return "kcg/system/team4_mng/t4_design_mng/CalculateDeposit";
    	}
    }
    
	@RequestMapping("designCusInfo")
	public CmmnMap designCusInfo(CmmnMap params) {

		return svc.designCusInfo(params);
		 
	}



}
