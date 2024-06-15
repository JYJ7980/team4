package kcg.system.t4_design_mng.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;

@Service
public class DesignService {

	@Autowired
	CmmnDao cmmnDao;

	public List<CmmnMap> getProList(CmmnMap params) {
		List<CmmnMap> productList = cmmnDao.selectList("kcg.system.t4_design_mng.getProInfo", params);
		return productList;
	}
}
