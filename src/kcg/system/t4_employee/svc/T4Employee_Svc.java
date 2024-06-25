package kcg.system.t4_employee.svc;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;

@Service
public class T4Employee_Svc {
	
	@SuppressWarnings("unused")
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	CmmnDao cmmnDao;
	
	@Autowired
	CommonSvc commonSvc;

	public CmmnMap insertEmployee(CmmnMap params) {
		 System.out.println("======================================== insert first log = "+params);
		 
		 String email = params.getString("user_id")+"@team4.com";
		 String auth_cd = "admin";
		 
		 params.put("email", email);
		 params.put("auth_cd", auth_cd);
		 params.put("iam_yn", "y");
		cmmnDao.insert("system.t4_employee.insertEmp", params);
		return new CmmnMap().put("status", "OK");
	}
	

}
