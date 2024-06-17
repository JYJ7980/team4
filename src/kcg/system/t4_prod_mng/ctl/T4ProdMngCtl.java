package kcg.system.t4_prod_mng.ctl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_prod_mng.svc.T4ProdMngSvc;

@Controller
@RequestMapping("/system/team4/product")
public class T4ProdMngCtl {
	@Autowired
	T4ProdMngSvc t4ProdMngSvc;
	
	@Autowired
	CommonSvc commonSvc;
	
	@RequestMapping("/list")
	public String pageList(Model model) {
		return "/kcg/system/team4_mng/t4_prod_mng/T4ProdList";
	}
	
	@RequestMapping("/getList")
	public List<CmmnMap> getList(CmmnMap params) {
		List<CmmnMap> dataList = t4ProdMngSvc.getList(params);
		System.out.println(dataList);
		return dataList;
	}
	
	@RequestMapping("/getListPaging")
	public PageList<CmmnMap> getListPaging(CmmnMap params, PagingConfig pagingConfig){
		return t4ProdMngSvc.getListPaging(params, pagingConfig);
	}
	
	@RequestMapping("/insertForm")
	public String insertForm(Model model) {
		return "/kcg/system/team4_mng/t4_prod_mng/T4ProdInsertForm";
	}

}
