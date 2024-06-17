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

}