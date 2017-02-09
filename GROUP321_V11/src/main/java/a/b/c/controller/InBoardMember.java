package a.b.c.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class InBoardMember {

	private InBoardMember() {
	}

	public static List getInstanceList() {
		return LazyHolder.msgList;
	}
	
	public static Map getInstanceMap() {
		return LazyHolder2.msgMap;
	}

	private static class LazyHolder {
		private static final List msgList = new ArrayList<>();
	}

	private static class LazyHolder2 {
		private static final Map msgMap = new HashMap<>();
	}
}
