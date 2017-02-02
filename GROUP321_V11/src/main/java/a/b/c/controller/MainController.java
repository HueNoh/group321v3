package a.b.c.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

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
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import a.b.c.service.MemberServiceInterface;

@RequestMapping(value = "/main")
@Controller
public class MainController {

	@Autowired
	MemberServiceInterface memberService;

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
		model.addAttribute("b_num", request.getParameter("b_num"));

		session = request.getSession(false);
		map.put("id", session.getAttribute("id"));
		map.put("bnum", map.get("b_num"));
		try {

			List list = memberService.selectBoardMember(map);
			if (0 < list.size()) {

				return loginChk(map, request, session, "list");
			} else {
				return loginChk(map, request, session, "list");
			}
		} catch (Exception e) {
			// TODO: handle exception
			return loginChk(map, request, session, "list");
		}

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

		List list = memberService.insertCard(map);
		Map lastBoard = (Map) list.get(list.size() - 1);
		return new Gson().toJson(lastBoard);
	}

	@RequestMapping(value = "/selectCardDetail", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String selectCardDetail(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		List list = memberService.selectCardDetail(map);
		return new Gson().toJson(list);
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
		System.out.println(map);
		List list = memberService.moveCard(map);
		return new Gson().toJson("aa");
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
}
