package kcg.system.t4_event_mng.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;

@Service
public class T4EventMng_Svc {
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	CmmnDao cmmnDao;
	
	public List<CmmnMap> eventFind(CmmnMap params) {
		String year = params.getString("year");
		String month = params.getString("month");
		
	    if (month.length() == 1) {
	        month = "0" + month; // 1자리 수일 경우 앞에 0을 붙임
	    }
	    
	    UserInfoVO uerInfoVo = commonSvc.getLoginInfo();
		params.put("user_id", uerInfoVo.getUserId());
		params.put("year", year);
		params.put("month", month);
		
		System.out.println("------------------------------->>>"+params);
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_event_mng.eventFind",params);	
		return dataList;
	}
	
	public List<CmmnMap> eventFindPlus(CmmnMap params) {
		String year = params.getString("year");
		String month = params.getString("month");
		
	    if (month.length() == 1) {
	        month = "0" + month; // 1자리 수일 경우 앞에 0을 붙임
	    }
	    
	    UserInfoVO uerInfoVo = commonSvc.getLoginInfo();
		params.put("user_id", uerInfoVo.getUserId());
		params.put("year", year);
		params.put("month", month);
		
		System.out.println("------------------------------->>>"+params);
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_event_mng.eventFindPlus",params);	
		return dataList;
	}

}
