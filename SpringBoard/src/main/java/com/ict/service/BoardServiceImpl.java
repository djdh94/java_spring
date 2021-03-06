package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.domain.BoardVO;
import com.ict.domain.Criteria;
import com.ict.domain.SearchCriteria;
import com.ict.mapper.BoardMapper;
import com.ict.mapper.ReplyMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ReplyMapper replymapper;

	@Override
	public List<BoardVO> getList(SearchCriteria cri) {

		return boardMapper.getList(cri);
	}

	@Override
	public void insert(BoardVO vo) {
		boardMapper.insert(vo);
		
	}

	@Override
	public BoardVO select(long bno) {
		
		return boardMapper.select(bno);
	}
	
	@Transactional
	@Override
	public void delete(long bno) {
		replymapper.deleteAllReplies(bno);
		boardMapper.delete(bno);
		
	}

	@Override
	public void update(BoardVO vo) {
		boardMapper.update(vo);
		
	}

	@Override
	public int countPageNum(SearchCriteria cri) {
		
		return boardMapper.countPageNum(cri);
	}
	
	
}
