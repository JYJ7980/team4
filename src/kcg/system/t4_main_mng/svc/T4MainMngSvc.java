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
	
<<<<<<< HEAD
	public PageList<CmmnMap> getList(CmmnMap params, PagingConfig pagingConfig){
		return cmmnDao.selectListPage("system.t4_cust_mng.getList", params, pagingConfig);
	}

	public PageList<CmmnMap> getAllNotice(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t4_main_mng.getAllNotice", params, pagingConfig);
		return pageList;
	}
=======

>>>>>>> 23b3514df8f0f58caeda31bdbc964c8281449e23
}
