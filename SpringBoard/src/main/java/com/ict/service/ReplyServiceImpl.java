package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.domain.ReplyVO;
import com.ict.mapper.BoardMapper;
import com.ict.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		
		return mapper.getList(bno);
	}
	
	@Transactional
	@Override
	public void addReply(ReplyVO vo) {

		mapper.create(vo);
		boardMapper.updateReplyCount(vo.getBno(),1);
		
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
		
	}
	
	@Transactional
	@Override
	public void removeRely(Long rno) {
		Long bno = mapper.getBno(rno);
		mapper.delete(rno);
		boardMapper.updateReplyCount(bno, -1);
		
	}
	
	

	
}
