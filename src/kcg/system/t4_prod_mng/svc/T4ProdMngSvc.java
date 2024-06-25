package kcg.system.t4_prod_mng.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
public class T4ProdMngSvc {

	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	HttpServletRequest request;

	@Autowired
	CmmnDao cmmnDao;

	@Autowired
	CommonSvc commonSvc;

	public List<CmmnMap> getList(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_prod_mng.getList", params);
		return dataList;
	}

	public PageList<CmmnMap> getListPaging(CmmnMap params, PagingConfig pagingConfig) {
		cmmnDao.update("system.t4_prod_mng.updateStatus");
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t4_prod_mng.getList", params, pagingConfig);
		return pageList;
	}
	
	public PageList<CmmnMap> getEndListPaging(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> pageList = cmmnDao.selectListPage("system.t4_prod_mng.getEndList", params, pagingConfig);
		return pageList;
	}

	public CmmnMap save(CmmnMap params) {
		UserInfoVO userInfoVO = commonSvc.getLoginInfo();
		params.put("user_id", userInfoVO.getUserId());
		if ("insert".equals(params.getString("save_mode"))) {
			cmmnDao.insert("system.t4_prod_mng.insertInfo", params);
		} else {
			cmmnDao.update("system.t4_prod_mng.updateInfo", params);
		}
		return new CmmnMap().put("product_id", params.getString("product_id"));
	}

	public void delete(CmmnMap params) {
		cmmnDao.delete("system.t4_prod_mng.deleteInfo", params);
		
	}

	public CmmnMap getInfo(CmmnMap params) {
		CmmnMap resultInfo = cmmnDao.selectOne("system.t4_prod_mng.getInfo", params);
		return resultInfo;
	}

	public CmmnMap checkName(CmmnMap params) {
		CmmnMap resultInfo = cmmnDao.selectOne("system.t4_prod_mng.checkName", params);
		return resultInfo;
	}
	
	public CmmnMap checkId(CmmnMap params) {
		CmmnMap resultInfo = cmmnDao.selectOne("system.t4_prod_mng.checkId", params);
		return resultInfo;
	}

}
