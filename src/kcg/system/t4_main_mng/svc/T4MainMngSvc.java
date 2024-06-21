package kcg.system.t4_main_mng.svc;

import java.time.LocalDate;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;

@Service
public class T4MainMngSvc {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired
	CommonSvc commonSvc;
	
//	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig){
//		return cmmnDao.selectListPage("system.t4_cust_mng.getList", params, pagingConfig);
//	}
//
//
//	public void createManagement(CmmnMap params) {
//		cmmnDao.insert("kcg.system.t4_main_mng.newCreateManagement", params);
//	}
//	
	public CmmnMap birthDay() {
		CmmnMap params = new CmmnMap();
		 UserInfoVO uerInfoVo = commonSvc.getLoginInfo();
	      LocalDate date = LocalDate.now();
	      
	        String month = String.valueOf(date.getMonthValue());
	        if (month.length() == 1) {
		        month = "0" + month; 
		    }
	        String day = String.valueOf(date.getDayOfMonth());
	        if (day.length() == 1) {
		        day = "0" + day; 
		    }
			params.put("user_id", uerInfoVo.getUserId());
			params.put("month",month);
			params.put("day", day);

		
		return cmmnDao.selectOne("system.t4_main_mng.birthDay", params);
	}

	public CmmnMap productEnd() {
		CmmnMap params = new CmmnMap();
		 UserInfoVO uerInfoVo = commonSvc.getLoginInfo();
	      LocalDate date = LocalDate.now();
	        String year = String.valueOf(date.getYear());
	        String month = String.valueOf(date.getMonthValue());
	        if (month.length() == 1) {
		        month = "0" + month;
		    }
	        String day = String.valueOf(date.getDayOfMonth());	        
	        if (day.length() == 1) {
		        day = "0" + day; 
		    }
			params.put("user_id", uerInfoVo.getUserId());
			params.put("month",month);
			params.put("day", day);
			params.put("year", year);
		
		return cmmnDao.selectOne("system.t4_main_mng.ending", params);
	}

	public List<CmmnMap> noticeTop2() {
		return cmmnDao.selectList("system.t4_main_mng.noticeTop2");
	}
	
}