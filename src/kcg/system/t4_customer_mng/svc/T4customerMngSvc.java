package kcg.system.t4_customer_mng.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;

@Service
public class T4customerMngSvc {

	@Autowired
	CmmnDao cmmnDao;

	public List<CmmnMap> getAllCustomers(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("getAllCustomers", params);
//		System.out.println(dataList);
		return dataList;
	}

	public CmmnMap deleteCust(CmmnMap params) {
		String customer_id = params.getString("customer_id");
		params.put("customer_id", customer_id);
		cmmnDao.update("system.t4_customer_mng.deleteCust", params);
		return new CmmnMap().put("status", "OK");

	}

	public CmmnMap updateCust(CmmnMap params) {
		String customer_id = params.getString("customer_id");
		String customer_name = params.getString("customer_name");
		String customer_level = params.getString("customer_level");
		String customer_phone = params.getString("customer_phone");
		String customer_sub_tel = params.getString("customer_sub_tel");
		String customer_email = params.getString("customer_email");
		String customer_job = params.getString("customer_job");
		String customer_addr = params.getString("customer_addr");
		
		params.put("customer_id", customer_id);
		params.put("customer_name", customer_name);
		params.put("customer_level", customer_level);
		params.put("customer_phone", customer_phone);
		params.put("customer_sub_tel", customer_sub_tel);
		params.put("customer_email", customer_email);
		params.put("customer_job", customer_job);
		params.put("customer_addr", customer_addr);
		
		cmmnDao.update("system.t4_customer_mng.updateCust", params);
		return new CmmnMap().put("status", "OK");
	}

	public CmmnMap addCust(CmmnMap params) {
	
		String customer_name = params.getString("customer_name");
		String customer_id_number = params.getString("customer_id_number");
		String customer_level = params.getString("customer_level");
		String customer_phone = params.getString("customer_phone");
		String customer_sub_tel = params.getString("customer_sub_tel");
		String customer_email = params.getString("customer_email");
		String customer_job = params.getString("customer_job");
		String customer_addr = params.getString("customer_addr");
		String user_id = params.getString("user_id");

		
		params.put("customer_name", customer_name);
		params.put("customer_id_number", customer_id_number);
		params.put("customer_level", customer_level);
		params.put("customer_phone", customer_phone);
		params.put("customer_sub_tel", customer_sub_tel);
		params.put("customer_email", customer_email);
		params.put("customer_job", customer_job);
		params.put("customer_addr", customer_addr);
		params.put("user_id", user_id);

		cmmnDao.insert("system.t4_customer_mng.addCust", params);
		return new CmmnMap().put("status", "OK");
	}

}