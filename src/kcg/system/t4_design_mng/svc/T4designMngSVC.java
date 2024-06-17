package kcg.system.t4_design_mng.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
@Service
public class T4designMngSVC {

	@Autowired
	CmmnDao cmmnDao;
	
	//design 나중에 옮겨야 할 코드

//	public PageList<CmmnMap> getListPaging(CmmnMap params, PagingConfig pagingConfig) {
//		PageList<CmmnMap> rslt = cmmnDao.selectListPage("getSubscriptionList", params, pagingConfig);
//		return rslt;
//	}
	public int deleteProduct(CmmnMap params) {
		return cmmnDao.update("subQuit", params);
	}

    public void deleteProducts(CmmnMap params) {
        cmmnDao.update("system.t4_design_mng.subQuitMultiple", params);
    }
	
	

}
