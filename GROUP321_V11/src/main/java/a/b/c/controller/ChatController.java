package a.b.c.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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

@RequestMapping(value = "/chat")
@Controller
public class ChatController {

	@Autowired
	MemberServiceInterface memberService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

		return "home";
	}

	@RequestMapping(value = "/chatMsg", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String chatMsg(Locale locale, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam Map map) {
		System.out.println(map);
		String error=null;

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
		JsonArray jarr= new JsonArray();
		try {
			List list = memberService.msgSelect(map);
			for (int i = 0; i < list.size(); i++) {
				map2 = (Map) list.get(i);
				JsonObject obj= new JsonObject();
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

}
