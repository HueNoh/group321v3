package a.b.c.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

@ServerEndpoint("/list")
public class ListWebSocket {
	public static List<Session> clients = Collections.synchronizedList(new ArrayList<Session>());

	@OnMessage
	public void onMessage(String message, Session session) {
		Gson gson = new Gson();

		Map map = (Map) gson.fromJson(message, Object.class);

		String id = (String) map.get("userId");
		String msg = (String) map.get("msg");
		String access = (String) map.get("access");
		int b_num = Integer.valueOf((String) map.get("b_num"));
		int l_num = Integer.valueOf((String) map.get("l_num"));
		int c_num = Integer.valueOf((String) map.get("c_num"));

		try {
			synchronized (clients) {
				if ("message".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("listMove".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("cardMove".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("listCreate".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("cardCreate".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("reply".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("connec".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
					}
				} else if ("unConnec".equals(access)) {
					for (int i = 0; i < clients.size(); i++) {
						Session client = clients.get(i);
						client.getBasicRemote()
								.sendText(id + "::" + msg + "::" + access + "::" + b_num + "::" + l_num + "::" + c_num);
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
		clients.remove(session);

	}
}
