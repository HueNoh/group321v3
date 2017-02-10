package a.b.c.dao;

import java.util.List;
import java.util.Map;

public interface MemberDaoInterface {
	public int loginChk(Map map);

	public int chkIdDup(Map map);

	public int insertMember(Map map);

	public int deleteMember(Map map);

	public List selectMember();

	public int insertBoard(Map map);

	public int updateBoard(Map map);

	public int deleteBoard(Map map);

	public List selectBoard();

	public List selectBoardMember(Map map);

	public int insertList(Map map);

	public int updateList(Map map);

	public int deleteList(Map map);

	public List selectList(Map map);

	public int insertCard(Map map);

	public int updateCard(Map map);

	public int deleteCard(Map map);

	public List selectCard(Map map);

	public List selectCardDetail(Map map);

	public List moveList(Map map);

	public List moveCard(Map map);

	public int msgInsert(Map map);

	public int addCardReply(Map map);

	public List msgSelect(Map map);

	public List maxCh_num(Map map);

	public void insertHistory(Map map);

	public List selectHistory(Map map);

	public List maxCard_Reply(Map map);

	public List selectCardReply(Map map);

	public List updateContent(Map map);

	public List updateLabel(Map map);
}
