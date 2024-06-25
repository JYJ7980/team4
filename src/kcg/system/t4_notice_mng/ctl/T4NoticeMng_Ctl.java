package kcg.system.t4_notice_mng.ctl;

import java.util.List;

import org.apache.hadoop.hive.metastore.api.ThriftHiveMetastore.AsyncProcessor.put_file_metadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import kcg.common.svc.CommonSvc;
import kcg.system.t4_notice_mng.svc.T4NoticeMng_Svc;

@Controller
@RequestMapping("system/team4/notice")
public class T4NoticeMng_Ctl {
	
	@Autowired
	CommonSvc commonSvc;
	
	@Autowired
	T4NoticeMng_Svc t4NoticeMng_Svc;
	
	@Autowired
	CmmnDao cmmnDao;

	
	/*
	 * @GetMapping("/") public String noticeMain(Model model) {
	 * 
	 * List<CmmnMap> noticeList = t4NoticeMng_Svc.getNoticeList();
	 * 
	 * System.out.println(noticeList.toString());
	 * model.addAttribute("noticeList",noticeList); return
	 * "kcg/system/team4_mng/notice/NoticeMain"; }
	 */
	
	@GetMapping("/insert")
	public String noticeInsert(Model model,CmmnMap params) {
		return "kcg/system/team4_mng/notice/NoticeInsert";
	}
	
	   @GetMapping("/")
	   public String customerInfoPage() {
	      return "kcg/system/team4_mng/notice/NoticeMain";
	   }

	
	
	@GetMapping("/show")
	public List<CmmnMap> getNoticeList() {
		 List<CmmnMap> dataList = cmmnDao.selectList("getNoticeList", null);
		 
	      return dataList;
	}
	
	@PostMapping("/save")
	public CmmnMap noticeInsertPost(CmmnMap params) {
		System.out.println("controller log = "+ params);
		return t4NoticeMng_Svc.insertNotice(params);
	}
	
	@PostMapping("/delete")
	public CmmnMap noticeDelete(CmmnMap params) {
		System.out.println(" ===================================== controller delete log = " +params);
		return t4NoticeMng_Svc.deleteNotice(params);
	}
	
	@PostMapping("/update")
	public CmmnMap noticeUpdate(CmmnMap params) {
		System.out.println(" ===================================== controller update log = " +params);
		return t4NoticeMng_Svc.updateNotice(params);
	}
	
}
