package com.ict.service;

import java.util.List;

import com.ict.domain.ReplyVO;

public interface ReplyService {
	
	public List<ReplyVO> listReply(Long bno);
	
	public void modifyReply(ReplyVO vo);
	
	public void removeRely(Long rno);

	public void addReply(ReplyVO vo);
	
	
}
