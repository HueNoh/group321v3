package a.b.c.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import a.b.c.service.MemberServiceInterface;

@RequestMapping(value = "/main")
@Controller
public class MainController {

	@Autowired
	MemberServiceInterface memberService;
	InBoardMember inBoardMember;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, @RequestParam Map map, HttpServletRequest request, HttpSession session) {

		return loginChk(map, request, session, "board");
	}

	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String board(Model model, @RequestParam Map map, HttpServletRequest request, HttpSession session) {

		return loginChk(map, request, session, "board");
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @RequestParam Map map, HttpServletRequest request, HttpSession session) {
		session = request.getSession(false);

		Map inBoardMemberMap = inBoardMember.getInstanceMap();
		Set inBoardMemberSet = inBoardMember.getInstanceSet();
		String userId = (String) session.getAttribute("id");
		int b_num = Integer.valueOf((String) map.get("b_num"));
		
		System.out.println("list map: "+map);
		session.setAttribute("b_num", b_num);
		model.addAttribute("b_num", b_num);
		
		model.addAttribute("title", memberService.selectBoardOne(map).get("title"));
		
		map.put("id", userId);
		map.put("b_num", b_num);

		if (null != session.getAttribute("id")) {
			if (inBoardMemberSet.contains(userId)) {
				inBoardMemberMap.remove(userId);
				inBoardMemberSet.add(userId);
				inBoardMemberMap.put(userId, b_num);
			} else {
				inBoardMemberSet.add(userId);
				inBoardMemberMap.put(userId, b_num);
			}
		}

		List list2 = new ArrayList<>();
		Iterator it = inBoardMemberMap.keySet().iterator();
		while (it.hasNext()) {
			String id = (String) it.next();
			// if (b_num == (int) inBoardMemberMap.get(id)) {
			// list2.add(id);
			// }
			if (b_num == (int) inBoardMemberMap.get(id) && !userId.equals(id)) {
				list2.add(id);
			}
		}
		model.addAttribute("users", new Gson().toJson(list2));

		List list = memberService.selectBoardMember(map);

		if (0 < list.size()) {

			return loginChk(map, request, session, "list");
		} else {
			return loginChk(map, request, session, "list");
		}

	}
	
	@RequestMapping(value = "/deleteBoard", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public int deleteBoard(@RequestParam Map map){
		int result = memberService.deleteBoard(map);
		System.out.println("deleteBoard map: "+map);
		System.out.println(result);
		return result;
		
	}
	
	
	@RequestMapping(value = "/searchBoard", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String searchBoard(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		session = request.getSession(false);
		map.put("id", session.getAttribute("id"));
		List list = memberService.searchBoard(map);
		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/searchList", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String searchList(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {

		List list = memberService.searchList(map);
		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/searchCard", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String searchCard(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {

		List list = memberService.searchCard(map);

		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/createBoard", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String createBoard(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {

		List list = memberService.insertBoard(map);
		Map lastList = (Map) list.get(list.size() - 1);
		return new Gson().toJson(lastList);
	}

	@RequestMapping(value = "/createList", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String createList(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		List list = memberService.insertList(map);
		Map lastBoard = (Map) list.get(list.size() - 1);
		return new Gson().toJson(lastBoard);
	}

	@RequestMapping(value = "/createCard", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String createCard(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		List list = memberService.insertCard(map);
		Map lastBoard = (Map) list.get(list.size() - 1);
		return new Gson().toJson(lastBoard);
	}

	@RequestMapping(value = "/selectCardDetail", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String selectCardDetail(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		session = request.getSession(false);

		session.setAttribute("l_num", map.get("l_num"));
		session.setAttribute("c_num", map.get("c_num"));

		System.out.println(map);

		List list = memberService.selectCardDetail(map);
		System.out.println(list);
		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/selectLink", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String selectLink(@RequestParam Map map) {

		List list = memberService.selectLink(map);

		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/insertLink", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String insertLink(@RequestParam Map map) {
		System.out.println("insertLinkMap: " + map);
		int result = memberService.insertLink(map);
		List list = memberService.selectLink(map);

		return new Gson().toJson(list.get(0));
	}

	@RequestMapping(value = "/moveList", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String moveList(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		map.put("listArr", map.get("data"));
		List list = memberService.moveList(map);
		return new Gson().toJson(map);
	}

	@RequestMapping(value = "/moveCard", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String moveCard(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		map.put("cardArr", map.get("msg"));
		List list = memberService.moveCard(map);
		System.out.println(map);
		return new Gson().toJson(map);
	}

	@RequestMapping(value = "/addCardReply", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String addCardReply(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		int result = memberService.addCardReply(map);
		JsonObject obj = new JsonObject();

		obj.addProperty("m_id", (String) map.get("m_id"));
		obj.addProperty("content", (String) map.get("content"));
		obj.addProperty("seq", (int) map.get("seq"));

		return new Gson().toJson(obj);
	}

	@RequestMapping(value = "/updateContent", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String updateContent(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		List list = memberService.updateContent(map);

		return "";
	}

	@RequestMapping(value = "/selectLabel", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String selectLabel(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		String str = memberService.selectLabel(map);

		if (str == null) {
			str = "0,0,0,0,0,0,0";
		}

		JsonObject obj = new JsonObject();
		obj.addProperty("label", str);

		return new Gson().toJson(obj);
	}

	@RequestMapping(value = "/updateLabel", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String updateLabel(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		List list = memberService.updateLabel(map);
		JsonObject obj = new JsonObject();
		obj.addProperty("label", (String) map.get("label"));
		//
		return new Gson().toJson(obj);
	}

	public String loginChk(@RequestParam Map map, HttpServletRequest request, HttpSession session, String route) {
		session = request.getSession(false);
		String id = (String) session.getAttribute("id");
		String loginChk = null;
		if (null == id) {
			loginChk = "home";

		} else {
			loginChk = route;
		}
		return loginChk;
	}

	@RequestMapping(value = "/selectHistory", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String selectHistory(Model model, @RequestParam Map map) {

		List list = memberService.selectHistory(map);
		System.out.println("히스토리가져오기:" + list);
		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/inUsers", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String inUsers(Model model, @RequestParam Map map) {

		List list = memberService.selectBoardMembers(map);

		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/searchUser", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String searchUser(Model model, @RequestParam Map map) {

		List list = memberService.searchMembers(map);
		return new Gson().toJson(list);
	}

	@RequestMapping(value = "/inviteUser", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String inviteUser(Model model, @RequestParam Map map) {

		int result = memberService.addMembers(map);
		return new Gson().toJson(result);
	}

	@RequestMapping(value = "/boardOut", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String boardOut(Model model, @RequestParam Map map) {

		int result = memberService.removeMembers(map);
		return new Gson().toJson(result);
	}

	@RequestMapping(value = "/profile", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String profile(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		System.out.println("profile");
		String m_id = request.getParameter("profileId");

		map.put("m_id", m_id);
		List list = memberService.profile(map);
		map = (Map) list.get(0);
		System.out.println(map);
		
		model.addAttribute("name", map.get("m_name"));
		model.addAttribute("regdate", map.get("regdate"));
		model.addAttribute("id", map.get("m_id"));

		return "profile";

	}
}
