package com.ict.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.domain.BoardVO;
import com.ict.domain.Criteria;
import com.ict.domain.PageMaker;
import com.ict.domain.SearchCriteria;
import com.ict.mapper.BoardMapper;
import com.ict.service.BoardService;

import lombok.extern.log4j.Log4j;



@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService service;

	@GetMapping("/boardList")
	public String getboardList(SearchCriteria cri,Model model) {
		List<BoardVO> boardList = service.getList(cri);
		model.addAttribute("boardList",boardList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		pageMaker.setTotalBoard(service.countPageNum(cri));
		model.addAttribute("pageMaker",pageMaker);
		
		
		
		return "board/boardList";
	}
	
	@GetMapping("/boardDetail/{bno}")
	public String getboardDetail(@PathVariable long bno,Model model) {
		model.addAttribute("board",service.select(bno));
		return "board/boardDetail";
	}
	
	@GetMapping("/boardInsert")
	public String getboardInsert() {
		return "/board/boardForm";
	}
	
	@PostMapping("/boardInsert")
	public String getboardInsert2(BoardVO vo) {
		log.info("들어온데이터 : "+vo);
		service.insert(vo);
		return "redirect:/board/boardList";
	}
	
	@PostMapping("/boardDelete")
	public String delete(long bno,SearchCriteria cri,RedirectAttributes rttr) {
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		
		service.delete(bno);
		return "redirect:/board/boardList";
	}
	
	@PostMapping("/boardUpdateForm")
	public String update(long bno,Model model) {
		model.addAttribute("board",service.select(bno));
		return "/board/boardUpdateForm";
	}
	
	@PostMapping("/boardUpdate")
	public String update2(BoardVO vo,SearchCriteria cri,RedirectAttributes rttr) {
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		service.update(vo);
		return "redirect:/board/boardDetail/"+vo.getBno();
	}
}
