package kcg.system.t4_design_mng.svc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.mybatis_paginator.domain.PageList;
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
    	List<Integer> selectedIds = new ArrayList<Integer>();
    	
        Object selectedIdsObject = params.get("selectedIds");

        if (selectedIdsObject instanceof List) {
            // List<Integer>로 캐스팅해서 넣어줌
            selectedIds.addAll((List<Integer>) selectedIdsObject);
            
        } else if (selectedIdsObject instanceof Integer) {
            // 단일 Integer인 경우 처리
            selectedIds.add((Integer) selectedIdsObject);
        }
        System.out.println("=====================================");
        System.out.println("==========svc==========");
        System.out.println(selectedIds.toString());

    	
        cmmnDao.update("system.t4_design_mng.subQuitMultiple", selectedIds);
    }

	public int updateSub(CmmnMap params) {
		return cmmnDao.update("updateSub", params);
	}

	public CmmnMap designCusInfo(CmmnMap params) {
		return cmmnDao.selectOne("designCusInfo", params);
	}

	public void saveCalulate(CmmnMap params) {
		
		cmmnDao.insert("saveCalulate", params);
	}

	public PageList<CmmnMap> designListPaging(CmmnMap params, PagingConfig pagingConfig) {
		
		return cmmnDao.selectListPage("getDesignListPaging", params, pagingConfig);
	}

	public CmmnMap moveDesignInfoForm(CmmnMap params) {
		
		return cmmnDao.selectOne("selectOneDes", params);
	}

	public void deleteDesign(CmmnMap params) {
    	List<Integer> selectedIds = new ArrayList<Integer>();
    	
        Object selectedIdsObject = params.get("selectedIds");

        if (selectedIdsObject instanceof List) {
            // List<Integer>로 캐스팅해서 넣어줌
            selectedIds.addAll((List<Integer>) selectedIdsObject);
            System.out.println("svc list에 넣어줄 때 작동");
            
        } else if (selectedIdsObject instanceof Integer) {
            // 단일 Integer인 경우 처리
            selectedIds.add((Integer) selectedIdsObject);
            System.out.println("svc 단일 Integer인 경우 작동");

        }
        
        System.out.println("=====================================");
        System.out.println("==========svc==========");
        System.out.println(selectedIds.toString());

		cmmnDao.delete("system.t4_design_mng.deleteDesigns", selectedIds);
	}	

	public int deleteSingleDesign(CmmnMap params) {
		return cmmnDao.delete("system.t4_design_mng.deleteSingleDesign", params);
	}

	public List<CmmnMap> selectAllDes(CmmnMap params) {
		return cmmnDao.selectList("system.t4_design_mng.selectOneDes" ,params);
	}

	public List<CmmnMap> lumpList(CmmnMap params) {
		return cmmnDao.selectList("lumpList", params);
	}

	public CmmnMap getDsgInfo(CmmnMap params) {
		return cmmnDao.selectOne("system.t4_design_mng.selectUpdateInfo", params);
	}
	
	


}