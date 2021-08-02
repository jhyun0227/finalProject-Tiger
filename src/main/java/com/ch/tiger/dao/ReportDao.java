package com.ch.tiger.dao;

import java.util.List;

import com.ch.tiger.model.Report;

public interface ReportDao {

	int getMaxNum();

	int RPinsert(Report report);

	int getRpTotal(Report report); // 전체 신고내역 갯수

	List<Report> rpList(Report report);	// 관리자 신고 목록

	int adminRpDelete(int RP_num);	// 관리자 신고 내역 삭제 

	List<Report> rpAllList(Report report); // 전체 신고 리스트 - 관리자메인


}
