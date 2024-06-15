package kcg.system.t4_design_mng.ctl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import common.utils.common.CmmnMap;
import kcg.system.t4_design_mng.svc.DesignService;

@Controller
@RequestMapping("design")
public class DesignController {
		
	@Autowired
	DesignService designService;
	
	@GetMapping("subscriptionForm")
	public String subsciptionForm(Model model) {
		return "kcg/system/t4_design_mng/SubscriptionForm";
	}
		
	@RequestMapping("productList")
	public List<CmmnMap> productList(CmmnMap params){

//		System.out.println(params.toString()); param값은 제대로 받아옴 
		List<CmmnMap> productList = designService.getProList(params);
		System.out.println(productList);
		return productList;
	}
}
