package com.zumsim;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	
	@RequestMapping("/send")
	public void json(HttpServletResponse response) throws IOException {
		String str = "[382,392,402,412,422]";
		
		JSONObject json = new JSONObject();
		
		PrintWriter out = response.getWriter();
		
		out.print(JSONObject.stringToValue(str));
	}
}
