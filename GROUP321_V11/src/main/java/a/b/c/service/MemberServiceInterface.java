package a.b.c.service;

import java.util.List;
import java.util.Map;

public interface MemberServiceInterface {

	public int loginChk(Map map);

	public List searchBoard(Map map);

	public List searchList(Map map);

	public List searchCard(Map map);

	public List selectCardDetail(Map map);

	public List selectBoardMember(Map map);

	public int msgInsert(Map map) throws Exception;

	public List msgSelect(Map map) throws Exception;

	public List insertBoard(Map map);

	public List insertList(Map map);

	public List insertCard(Map map);
	
	public int addCardReply(Map map);

	public List moveList(Map map);

	public List moveCard(Map map);

	public void insertHistory(Map map);

	public List selectHistory(Map map);

	public List updateContent(Map map);

	int insertMember(Map map) throws Exception;

	public int chkIdDup(Map map);

}
