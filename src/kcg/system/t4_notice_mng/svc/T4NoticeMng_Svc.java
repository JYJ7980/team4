package kcg.system.t4_notice_mng.svc;

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

@Service
public class T4NoticeMng_Svc {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired
	CommonSvc commonSvc;
	
	public List<CmmnMap> getNoticeList(CmmnMap params){
		List<CmmnMap> dataList = cmmnDao.selectList("getNoticeList", params);
		 return dataList;
	}

	  public CmmnMap insertNotice(CmmnMap params) {
		  System.out.println("======================================== insert first log = "+params);
	        String notice_title = params.getString("title");
	        String notice_content = params.getString("content");

	        params.put("notice_title", notice_title);
	        params.put("notice_content", notice_content);
	        
	        cmmnDao.insert("system.t4_notice_mng.insertNotice", params);

	        return new CmmnMap().put("status", "OK");
	    }

	public CmmnMap deleteNotice(CmmnMap params) {
		  Long notice_id = params.getLong("delete_id");
	      params.put("notice_id", notice_id);
		cmmnDao.delete("system.t4_notice_mng.deleteNotice",params);
	      return new CmmnMap().put("status", "OK");

	}

	public CmmnMap updateNotice(CmmnMap params) {
		
		Long notice_id = params.getLong("update_id");
		String notice_title = params.getString("update_title");
		String notice_content = params.getString("update_content");
		
		params.put("notice_title", notice_title);
		params.put("notice_content", notice_content);
		params.put("notice_id", notice_id);
		System.out.println("======================================== update log = "+params);
		cmmnDao.update("system.t4_notice_mng.updateNotice",params);
		
	      return new CmmnMap().put("status", "OK");

	}

	public PageList<CmmnMap> getAllNotice(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t4_notice_mng.getAllNotice", params, pagingConfig);
		return pageList;
	}

}
