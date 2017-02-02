package a.b.c.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.annotation.WebListener;
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

@ServerEndpoint("/socket")
public class WebSocket {
	public static List<Session> clients = Collections.synchronizedList(new ArrayList<Session>());
	public static List users = Collections.synchronizedList(new ArrayList<>());
	public static List bs_num = Collections.synchronizedList(new ArrayList<>());

	@OnMessage
	public void onMessage(String message, Session session) {

		Gson gson = new Gson();
		JsonObject jObj = gson.fromJson(message, JsonObject.class);
		JsonElement jId = jObj.get("userId");
		JsonElement jMsg = jObj.get("msg");
		JsonElement jaccess = jObj.get("access");
		JsonElement jB_num = jObj.get("b_num");

		String id = jId.getAsString();
		String msg = jMsg.getAsString();
		String access = jaccess.getAsString();
		int b_num = jB_num.getAsInt();

		try {
			synchronized (clients) {

				if ("message".equals(access)) {
					for (int i = 0; i < bs_num.size(); i++) {
						if ((int) bs_num.get(i) == b_num) {
							Session client = clients.get(i);

							client.getBasicRemote().sendText(id + ":" + msg + ":" + access);

						}
					}

				} else if ("open".equals(access)) {
					for (int i = 0; i < bs_num.size(); i++) {
						if ((int) bs_num.get(i) == b_num) {
							Session client = clients.get(i);
							client.getBasicRemote().sendText(id + ":" + msg + ":" + access + ":" + b_num);
						}
					}
				} else if ("close".equals(access)) {
					for (int i = 0; i < bs_num.size(); i++) {
						if ((int) bs_num.get(i) == b_num) {
							Session client = clients.get(i);
							client.getBasicRemote().sendText(id + ":" + msg + ":" + access + ":" + b_num);
						}
					}
				}

			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		int remobeB_num = (int) bs_num.get(clients.indexOf(session));

		users.remove(clients.indexOf(session));
		bs_num.remove(clients.indexOf(session));
		clients.remove(session);

		for (int i = 0; i < clients.size(); i++) {
			Gson gson = new Gson();
			JsonObject jObj = new JsonObject();

			jObj.addProperty("userId", (String) users.get(i));
			jObj.addProperty("msg", "close");
			jObj.addProperty("access", "close");
			jObj.addProperty("b_num", remobeB_num);

			onMessage(gson.toJson(jObj), session);
		}

	}
}
