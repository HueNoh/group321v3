package a.b.c.controller;

import java.text.DateFormat;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	MemberServiceInterface memberService;
	InBoardMember inBoardMember;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session, HttpServletRequest request) {
		String route = null;
		session = request.getSession(false);
		if (null != session) {
			route = "redirect:/main/board";
		} else {
			route = "/";
		}

		return route;
	}

	@RequestMapping(value = "/login", method = { RequestMethod.POST, RequestMethod.GET })
	public String login(Model model, @RequestParam Map map, HttpSession session, HttpServletRequest request) {
		// String page = null;

		String loginChk = null;

		Set inBoardMemberSet = inBoardMember.getInstanceSet();
		Map inBoardMemberMap = inBoardMember.getInstanceMap();
		Map inUserIpMap = inBoardMember.getUserIpMap();

		System.out.println(session.getAttribute("id"));

		if (null != session.getAttribute("id")) {

			loginChk = "redirect:/main/board";

		} else {
			System.out.println(inUserIpMap);
			boolean userOk = false;

			if (inBoardMemberSet.contains(map.get("id"))) {
				System.out.println(map.get("id"));
				Iterator it = inUserIpMap.keySet().iterator();
				while (it.hasNext()) {
					String ip = (String) it.next();
					if (inUserIpMap.get(ip).equals(map.get("id")) && !ip.equals(request.getRemoteHost())) {
						userOk = true;
						break;
					} else {
						userOk = false;
					}
				}
				
				if (userOk) {
					model.addAttribute("err", "접속된 아이디입니다.");
					loginChk = "home";

				} else {
					int result = memberService.loginChk(map);
					model.addAttribute("loginChk", result);

					if (result == 0) {

						session = request.getSession();
						session.setAttribute("id", map.get("id"));
						session.setAttribute("b_num", 0);
						inBoardMemberSet.add(map.get("id"));
						inUserIpMap.remove(request.getRemoteHost());
						inUserIpMap.put(request.getRemoteHost(), map.get("id"));

						loginChk = "redirect:/main/board";
					} else {
						loginChk = "home";
						model.addAttribute("err", "아이디와 비밀번호를 확인해 주세요.");
					}
				}
			} else {
				int result = memberService.loginChk(map);
				model.addAttribute("loginChk", result);

				if (result == 0) {

					session = request.getSession();
					session.setAttribute("id", map.get("id"));
					session.setAttribute("b_num", 0);
					inBoardMemberSet.add(map.get("id"));
					inUserIpMap.remove(request.getRemoteHost());
					inUserIpMap.put(request.getRemoteHost(), map.get("id"));

					loginChk = "redirect:/main/board";
				} else {
					loginChk = "home";
					model.addAttribute("err", "아이디와 비밀번호를 확인해 주세요.");
				}
			}

		}
		return loginChk;
	}

	@RequestMapping(value = "/chkIdDup", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int chkId(Locale locale, Model model, @RequestParam Map map) {
		logger.info("Welcome dupCheck! The client locale is {}.", locale);

		System.out.println("�븘�씠�뵒泥댄겕: " + map);

		int result = memberService.chkIdDup(map);
		System.out.println(result);

		return result;

	}

	@RequestMapping(value = "/insertForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String register(Locale locale, Model model, @RequestParam Map map) {
		logger.info("Welcome insert! The client locale is {}.", locale);

		return "insertForm";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(Locale locale, Model model, @RequestParam Map map) {
		logger.info("Welcome insert! The client locale is {}.", locale);

		int result = 0;
		try {
			result = memberService.insertMember(map);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("personService.insertPerson(map)" + String.valueOf(result));
		}
		return "success";

	}

}
