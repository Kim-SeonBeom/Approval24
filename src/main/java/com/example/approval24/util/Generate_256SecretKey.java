package com.example.approval24.util;

import java.security.SecureRandom;
import java.util.Base64;

public class Generate_256SecretKey {

    public static void main(String[] args) {
        String key = generateEncryptionKey();
    }

    public static String generateEncryptionKey() {
        byte[] key = new byte[32];
        new SecureRandom().nextBytes(key);
		return Base64.getEncoder().encodeToString(key);
    }
}