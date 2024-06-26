package kcg.system.t4_employee.svc;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.hadoop.hdfs.server.datanode.dataNodeHome_jsp;
import org.checkerframework.checker.units.qual.C;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import common.dao.CmmnDao;
import common.utils.common.CmmnMap;
import common.utils.common.PagingConfig;
import common.utils.crypt.CryptUtil;
import common.utils.mybatis_paginator.domain.PageList;
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

	// 신규계정 생성을 위한 메서드
	public CmmnMap insertEmployee(CmmnMap params) {
		System.out.println("======================================== insert first log = " + params);
		String email = params.getString("user_id") + "@team4.com";
		String auth_cd = "admin";
		String del_yn = "N";
		String jikgub_cd = "";
		String tdept_nm = "";
		String gis_auth = "";
		Timestamp reg_dt = new Timestamp(new Date().getTime());

		String userPw = params.getString("user_pw");
		if (userPw == null || userPw.isEmpty()) {
			throw new IllegalArgumentException("Password cannot be null or empty");
		}

		String hashedPw = CryptUtil.hashSHA512HexString(userPw);

		params.put("user_pw", hashedPw); // PW 암호화
		params.put("email", email);
		params.put("auth_cd", auth_cd);
		params.put("iam_yn", "N");
		params.put("reg_dt", reg_dt);
		params.put("del_yn", "N");
		params.put("jikgub_cd", jikgub_cd);
		params.put("tdept_nm", tdept_nm);
		params.put("gis_auth", gis_auth);
		cmmnDao.insert("system.t4_employee.insertEmp", params);
		cmmnDao.insert("system.t4_employee.insertCal", params);
		return new CmmnMap().put("status", "OK");
	}

	/* 담당자의 리스트 */
	public List<CmmnMap> employeelist(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_employee.employeelist", params);
		return dataList;
	}

	/* 담당자 정보를 확인 */
	public CmmnMap employeeOne(CmmnMap params) {
		String user_id = params.getString("user_id");
		params.put("user_id", user_id);
		CmmnMap result = cmmnDao.selectOne("system.t4_employee.selectOne", params);
		return result;
	}

	/* 조건검색 */
	public List<CmmnMap> employeeSearch(CmmnMap params) {
		List<CmmnMap> searchList = cmmnDao.selectList("system.t4_employee.searchEmployee", params);
		return searchList;
	}

	/* 전체검색 */
	public List<CmmnMap> employeeSearchAll(CmmnMap params) {
		List<CmmnMap> searchAllList = cmmnDao.selectList("system.t4_employee.employeelist", params);
		return searchAllList;
	}

	/* 담당자 계정에 대한 수정 */
	public CmmnMap updateEmployee(CmmnMap params) {
		String del_yn = params.getString("del_yn");
		String iam_yn = params.getString("iam_yn");
		String status_cd = params.getString("status_cd");

		switch (status_cd) {
		case "재직":
			params.put("iam_yn", "N");
			params.put("del_yn", "N");
			params.put("status_cd", "재직");
			break;
		case "휴가":
			params.put("iam_yn", "N");
			params.put("del_yn", "N");
			params.put("status_cd", "휴가");
			break;
		case "퇴사":
			params.put("iam_yn", "Y");
			params.put("del_yn", "Y");
			params.put("status_cd", "퇴사");
			break;
		default:
			return null;
		}
		cmmnDao.update("system.t4_employee.updateEmployee", params);
		return new CmmnMap().put("status", "OK");
	}

	/* 담당자 계정에 대한 삭제 */
	public CmmnMap deleteEmployee(CmmnMap params) {
		cmmnDao.delete("system.t4_employee.deleteEmployee", params);
		return new CmmnMap().put("status", "OK");
	}

	/* 담당자 계정 생성시 중복계정 확인 */
	public CmmnMap checkId(CmmnMap params) {
		CmmnMap data = cmmnDao.selectOne("system.t4_employee.selectOne", params);
		return data;
	}

	/* 담당자 계정 수정시 비밀번호만 수정 / 해시를 이용하여 암호화 */
	public CmmnMap updatePw(CmmnMap params) {
		String user_pw = params.getString("user_pw");
		if (user_pw == null || user_pw.isEmpty()) {
			throw new IllegalArgumentException("Password cannot be null or empty");
		}
		String hashedPw = CryptUtil.hashSHA512HexString(user_pw);
		params.put("user_pw", hashedPw);
		cmmnDao.update("system.t4_employee.updatePw", params);
		return new CmmnMap().put("status", "OK");
	}

	// 퇴직자 리스트 불러오기
	public PageList<CmmnMap> getQuitUser(CmmnMap params, PagingConfig pagingConfig) {
		PageList<CmmnMap> rslt = cmmnDao.selectListPage("system.t4_employee.getQuitUser", params, pagingConfig);
		return rslt;
	}

	public List<CmmnMap> getQuitUserCustomerInfo(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_employee.getQuitUserCustomerInfo", params);
//		System.out.println(dataList);
		String user_id = params.getString("user_id");
		params.put("user_id", user_id);
		return dataList;
	}

	public List<CmmnMap> getCurrentUserInfo(CmmnMap params) {
		List<CmmnMap> dataList = cmmnDao.selectList("system.t4_employee.getCurrentUserInfo", params);
		return dataList;
	}

	public CmmnMap changeQuitUser(CmmnMap params) {
		String customer_id = params.getString("customer_id");
		String user_id = params.getString("user_id");

		params.put("customer_id", customer_id);
		params.put("user_id", user_id);

		cmmnDao.update("system.t4_employee.changeQuitUser", params);
		return new CmmnMap().put("status", "OK");
	}
}
