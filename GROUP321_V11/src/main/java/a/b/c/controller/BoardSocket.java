package a.b.c.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@ServerEndpoint("/board")
public class BoardSocket {
	public static List<Session> clients = Collections.synchronizedList(new ArrayList<Session>());

	@OnMessage
	public void onMessage(String message, Session session) {
		Gson gson = new Gson();
		JsonObject jObj = gson.fromJson(message, JsonObject.class);
		if (null != jObj.get("userId")) {
			JsonElement jId = jObj.get("userId");
			JsonElement jMsg = jObj.get("msg");
			JsonElement jaccess = jObj.get("access");
			JsonElement jCreate = jObj.get("create");

			String id = jId.getAsString();
			String msg = jMsg.getAsString();
			String access = jaccess.getAsString();
			String create = jCreate.getAsString();
			try {
				synchronized (clients) {
					if ("board".equals(create)) {
						for (int i = 0; i < clients.size(); i++) {
							Session client = clients.get(i);
							client.getBasicRemote().sendText(id + "::" + msg + "::" + access);
						}
					}

				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		// Add session to the connected sessions set
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		// Remove session from the connected sessions set
		clients.remove(session);
	}
}
