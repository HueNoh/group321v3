package a.b.c.controller;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.mail.internet.HeaderTokenizer.Token;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.parsing.TokenHandler;
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

@RequestMapping(value = "/chat")
@Controller
public class ChatController {

	@Autowired
	MemberServiceInterface memberService;
	InBoardMember inBoardMember;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

		return "home";
	}

	@RequestMapping(value = "/chatMsg", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String chatMsg(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		System.out.println(map);
		String error = null;

		try {

			int result = memberService.msgInsert(map);
			if (0 != result) {
				error = "001";
			} else {
				error = "002";
			}
			System.out.println(error);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return error;
	}

	@RequestMapping(value = "/viewMsg", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String viewMsg(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {

		Map map2 = new HashMap<>();
		JsonArray jarr = new JsonArray();
		try {
			List list = memberService.msgSelect(map);
			for (int i = 0; i < list.size(); i++) {
				map2 = (Map) list.get(i);
				JsonObject obj = new JsonObject();

				Date s = (Date) map2.get("regdate");
				String date = String.valueOf(s);

				StringTokenizer st = new StringTokenizer(date);
				List dateList = new ArrayList<>();
				while (st.hasMoreTokens()) {
					dateList.add(st.nextToken());
				}

				StringTokenizer dateToken = new StringTokenizer((String) dateList.get(1), ":");
				dateList.clear();

				while (dateToken.hasMoreTokens()) {
					dateList.add((String) dateToken.nextToken());
				}

				String h = null;
				String m = (String) dateList.get(1);
				String amPm = null;
				if (12 > Integer.valueOf((String) dateList.get(0))) {
					amPm = "오전";
					h = (String) dateList.get(0);
				} else if (12 < Integer.valueOf((String) dateList.get(0))) {
					amPm = "오후";
					int temp = Integer.valueOf((String) dateList.get(0)) - 12;
					h = temp + "";
				} else {
					amPm = "오후";
					h = (String) dateList.get(0);
				}
				obj.addProperty("date", amPm + " " + h + ":" + m);
				obj.addProperty("m_id", (String) map2.get("m_id"));
				obj.addProperty("content", (String) map2.get("content"));
				jarr.add(obj);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new Gson().toJson(jarr);
	}

	@RequestMapping(value = "/ucConnection", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String ucConnection(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		int b_num = Integer.valueOf((String) map.get("b_num"));

		Map inBoardMemberMap = inBoardMember.getInstanceMap();
		Set inBoardMemberSet = inBoardMember.getInstanceSet();

		inBoardMemberMap.remove(session.getAttribute("id"));
		inBoardMemberMap.put(session.getAttribute("id"), 0);

		List list2 = new ArrayList<>();

		Iterator it = inBoardMemberMap.keySet().iterator();
		while (it.hasNext()) {
			String id = (String) it.next();
			if (b_num == (int) inBoardMemberMap.get(id)) {
				list2.add(id);
			}
		}
		System.out.println("===============================");
		System.out.println("list2 : " + list2);
		System.out.println("inBoardMemberMap : " + inBoardMemberMap);
		System.out.println("===============================");
		model.addAttribute("users", new Gson().toJson(list2));

		return new Gson().toJson(list2);
	}

}
