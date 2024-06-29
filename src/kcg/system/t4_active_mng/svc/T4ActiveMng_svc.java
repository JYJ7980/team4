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
	public String findDeptId() {
		UserInfoVO userInfoVO = commonSvc.getLoginInfo();
		CmmnMap params = new CmmnMap();
		String dept_nm = userInfoVO.getDept();
		params.put("dept_nm", dept_nm);
		
		return cmmnDao.selectOne("system.t4_active_mng.findDeptId", params);
	}
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

	public CmmnMap updateCalender(CmmnMap params) {
		int bn_cal_id = params.getInt("update_id");
		String cal_title = params.getString("update_title");
		String cal_content = params.getString("update_content");
		String cal_date = params.getString("update_date");
		
		params.put("bn_cal_id", bn_cal_id);
		params.put("cal_title", cal_title);
		params.put("cal_content", cal_content);
		params.put("cal_date", cal_date);
		
		cmmnDao.update("system.t4_active_mng.updateCalender",params);
		return  new CmmnMap().put("status", "OK");
	}

	public CmmnMap deleteCalender(CmmnMap params) {
		int bn_cal_id = params.getInt("delete_id");
		System.out.println("====================================" + bn_cal_id);
		params.put("bn_cal_id", bn_cal_id);
		
		cmmnDao.delete("system.t4_active_mng.deleteCalender", params);
		return new CmmnMap().put("status", "OK");
	}
	
	public int findCalId() {
		CmmnMap params = new CmmnMap();
		String manager_id = commonSvc.getLoginInfo().getUserId();
		params.put("manager_id", manager_id);
		
		return cmmnDao.selectOne("system.t4_active_mng.findCalId",params);
	}

	public CmmnMap saveCalender(CmmnMap params) {
		String cal_date = params.getString("date");
		String cal_title = params.getString("title");
		String cal_content = params.getString("content");
		int cal_id = findCalId();
		
		params.put("cal_date", cal_date);
		params.put("cal_title", cal_title);
		params.put("cal_content", cal_content);
		params.put("cal_id", cal_id);
		
		cmmnDao.insert("system.t4_active_mng.saveCalender",params);
		
		
		return new CmmnMap().put("status", "OK");
	}
	public List<CmmnMap> findDept(CmmnMap params) {
		String year = params.getString("year");
		String month = params.getString("month");
		
	    if (month.length() == 1) {
	        month = "0" + month; // 1자리 수일 경우 앞에 0을 붙임
	    }
	    String dept_cal_id = findDeptId();
		params.put("dept_cal_id", dept_cal_id);
		params.put("year", year);
		params.put("month", month);
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_active_mng.findDept",params);
		return dataList;
		
	}
	
	public CmmnMap teamSaveCalender(CmmnMap params) {
		String cal_date = params.getString("date");
		String cal_title = params.getString("title");
		String cal_content = params.getString("content");
		String dept_cal_id = findDeptId();
		
		params.put("dept_cal_id", dept_cal_id);
		
		params.put("cal_date", cal_date);
		params.put("cal_title", cal_title);
		params.put("cal_content", cal_content);
		
		
		cmmnDao.insert("system.t4_active_mng.saveTeamCalender",params);
		
		
		return new CmmnMap().put("status", "OK");
	}

}
