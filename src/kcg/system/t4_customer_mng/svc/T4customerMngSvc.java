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
	
	
	public List<CmmnMap> getCustInfo(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("getCustInfo", params);
		
		return dataList;
	}


	
	

}
