package a.b.c.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import a.b.c.dao.MemberDaoInterface;

@Component
public class MemberServiceImpl implements MemberServiceInterface {

	@Autowired
	MemberDaoInterface memberDao;

	@Override
	public int loginChk(Map map) {
		// TODO Auto-generated method stub
		return memberDao.loginChk(map);
	}

	@Override
	public List searchBoard(Map map) {
		// TODO Auto-generated method stub

		// 보더 전체검색
		return memberDao.selectBoard();
	}

	@Override
	public List selectBoardMember(Map map) {

		return memberDao.selectBoardMember(map);
	}

	@Override
	public List searchCard(Map map) {
		// TODO Auto-generated method stub
		return memberDao.selectCard(map);
	}

	@Override
	public List selectCardDetail(Map map) {
		// TODO Auto-generated method stub
		return memberDao.selectCardDetail(map);
	}

	@Override
	public List searchList(Map map) {
		// TODO Auto-generated method stub
		return memberDao.selectList(map);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List insertBoard(Map map) {
		// TODO Auto-generated method stub
		int result = memberDao.insertBoard(map);
		List list = new ArrayList<>();
		if (-1 != result) {
			list = memberDao.selectBoard();
		}
		return list;
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List insertList(Map map) {
		// TODO Auto-generated method stub
		int result = memberDao.insertList(map);
		List list = new ArrayList<>();
		if (-1 != result) {
			list = memberDao.selectList(map);
		}
		return list;
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public List insertCard(Map map) {
		// TODO Auto-generated method stub
		int result = memberDao.insertCard(map);
		List list = new ArrayList<>();
		if (-1 != result) {
			list = memberDao.selectCard(map);
		}
		return list;
	}

	public List selectBoard() {
		return memberDao.selectBoard();
	}

	public List moveList(Map map) {
		return memberDao.moveList(map);
	}
	public List moveCard(Map map) {
		return memberDao.moveCard(map);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int msgInsert(Map map) throws Exception {
		int result = 0;
		try {
			List list_maxCh = memberDao.maxCh_num(map);
			System.out.println("list_maxCh.size() : " + list_maxCh.size());
			if (0 < list_maxCh.size()) {
				Map map_maxSeq = new HashMap<>();

				map_maxSeq = (Map) list_maxCh.get(0);

				int seq = ((int) map_maxSeq.get("seq"))+1;
				map.put("seq", seq);
				result = memberDao.msgInsert(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("seq", 1);
			result = memberDao.msgInsert(map);
		}

		return result;
	}

	@Override
	public List msgSelect(Map map) throws Exception {

		return memberDao.msgSelect(map);
	}
}
