package kcg.system.t4_main_mng.svc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
import kcg.common.svc.CommonSvc;

@Service
public class T4MainMngSvc {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired
	CommonSvc commonSvc;
	
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig){
		return cmmnDao.selectListPage("system.t4_cust_mng.getList", params, pagingConfig);
	}
	
}
