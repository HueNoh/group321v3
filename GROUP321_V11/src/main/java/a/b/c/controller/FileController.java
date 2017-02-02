package a.b.c.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="/file")
@Controller
public class FileController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

		
		
		return "home";
	}
}
