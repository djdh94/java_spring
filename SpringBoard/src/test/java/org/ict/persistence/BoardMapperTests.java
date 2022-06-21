package org.ict.persistence;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ict.domain.BoardVO;
import com.ict.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Autowired
	private BoardMapper boardMapper;
	
	//@Test
	public void test() {
		log.info(boardMapper.getList());
	}
	
	//@Test
	public void test2() {
		BoardVO vo = new BoardVO();
		log.info(vo);
		vo.setTitle("아리");
		vo.setContent("글내용아리");
		vo.setWriter("쉐글");
		log.info(vo);
		boardMapper.insert(vo);
	}
	
	//@Test
	public void test3() {
		
		boardMapper.select(3159);
	}
	
	//@Test
	public void test4() {
		boardMapper.delete(99);
		
	}
	
	//@Test
	public void test5() {
		BoardVO vo = new BoardVO();
		vo.setBno(98);
		vo.setTitle("수정글");
		vo.setContent("수정내용");
		boardMapper.update(vo);
	}
}
