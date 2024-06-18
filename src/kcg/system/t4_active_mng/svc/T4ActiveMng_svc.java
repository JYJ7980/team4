package kcg.system.t4_active_mng.svc;

import java.util.List;

import org.eclipse.jetty.plus.jaas.spi.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.login.vo.UserInfoVO;

@Service
public class T4ActiveMng_svc {

	@Autowired
	CommonSvc commonSvc;
	@Autowired
	CmmnDao cmmnDao;
	
	public List<CmmnMap> findToDoList(CmmnMap params) {
		String year = params.getString("year");
		String month = params.getString("month");
		
	    if (month.length() == 1) {
	        month = "0" + month; // 1자리 수일 경우 앞에 0을 붙임
	    }
	    
		UserInfoVO uerInfoVo = commonSvc.getLoginInfo();
		params.put("user_id", uerInfoVo.getUserId());
		params.put("year", year);
		params.put("month", month);
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_active_mng.findToDoList",params);
		return dataList;
	}

}
