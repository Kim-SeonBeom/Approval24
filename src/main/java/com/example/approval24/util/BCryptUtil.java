package com.example.approval24.util;

import org.springframework.security.crypto.bcrypt.BCrypt;

public final class BCryptUtil {
	private static final int DEFAULT_ROUNDS = 4;
	
	private BCryptUtil() {
	}
	 public static String hash(String rawPassword) {
		 if(rawPassword == null) {
			 throw new IllegalArgumentException("rawPassword null");
		 }
		 String salt = BCrypt.gensalt(DEFAULT_ROUNDS);
		 return BCrypt.hashpw(rawPassword, salt);
	 }
	 
	 public static boolean matches(String rawPassword, String storedHash) {
		 if(rawPassword == null || storedHash == null) {
			 return false;
		 }
		 return BCrypt.checkpw(rawPassword, storedHash);
			
	 }
}
