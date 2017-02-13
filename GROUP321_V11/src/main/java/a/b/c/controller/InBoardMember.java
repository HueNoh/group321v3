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

	public static Map getInstanceMap() {
		return LazyHolder.magMap;
	}

	public static Map getUserIpMap() {
		return LazyHolderUser.userMap;
	}

	public static Set getInstanceSet() {
		return LazyHolder3.msgSet;
	}

	private static class LazyHolder {
		private static final Map magMap = new HashMap<>();
	}

	private static class LazyHolderUser {
		private static final Map userMap = new HashMap<>();
	}

	private static class LazyHolder3 {
		private static final Set msgSet = new HashSet<>();
	}
}
