package com.ict.mapper;

import com.ict.domain.MemberVO;

public interface MemberMapper{
	
	public MemberVO read(String userId);
	
	public void insertMemberTbl(MemberVO vo); // 회원정보 기입
	
	public void insertMemberAuth(MemberVO vo); // 권한목록 기입
}