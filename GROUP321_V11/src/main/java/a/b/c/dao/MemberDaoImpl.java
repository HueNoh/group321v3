package a.b.c.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import a.b.c.mybatis.MemberMapper;

@Repository
public class MemberDaoImpl implements MemberDaoInterface {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int loginChk(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.loginChk(map);
	}

	@Override
	public int chkIdDup(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.chkIdDup(map);
	}

	@Override
	public int insertMember(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.insertMember(map);
	}

	@Override
	public int deleteMember(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.deleteMember(map);
	}

	@Override
	public List selectMember() {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectMember();
	}

	@Override
	public int insertBoard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.insertBoard(map);
	}

	@Override
	public int updateBoard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.updateBoard(map);
	}

	@Override
	public int deleteBoard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.deleteBoard(map);
	}

	@Override
	public List selectBoard() {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectBoard();
	}

	@Override
	public List selectBoardMember(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectBoardMember(map);
	}

	@Override
	public int insertList(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.insertList(map);
	}

	@Override
	public int updateList(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.updateList(map);
	}

	@Override
	public int deleteList(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.deleteList(map);
	}

	@Override
	public List selectList(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectList(map);
	}

	@Override
	public int insertCard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.insertCard(map);
	}

	@Override
	public int updateCard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.updateCard(map);
	}

	@Override
	public int deleteCard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.deleteCard(map);
	}

	@Override
	public List selectCard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectCard(map);
	}

	@Override
	public List selectCardDetail(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectCardDetail(map);
	}
	@Override
	public List moveList(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.moveList(map);
	}
	@Override
	public List moveCard(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.moveCard(map);
	}

	@Override
	public int msgInsert(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.msgInsert(map);
	}
	@Override
	public int addCardReply(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.addCardReply(map);
	}

	@Override
	public List msgSelect(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.msgSelect(map);
	}

	@Override
	public List maxCh_num(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.maxCh_num(map);
	}
	@Override
	public List maxCard_Reply(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.maxCard_Reply(map);
	}
	@Override
	public List selectCardReply(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectCardReply(map);
	}

	@Override
	public void insertHistory(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		mapper.insertHistory(map);
	}

	@Override
	public List selectHistory(Map map) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectHistory(map);
	}

}
