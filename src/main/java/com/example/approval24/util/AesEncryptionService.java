package com.example.approval24.util;

import javax.annotation.PostConstruct;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Base64;
import java.util.Properties;

@Service
public class AesEncryptionService {

    private String secretKey;
    private String ivKey;

    private static final String ALGORITHM = "AES/CBC/PKCS5Padding";

    @PostConstruct
    public void init() {
        try {
            Properties prop = new Properties();


            InputStream input = getClass().getClassLoader().getResourceAsStream("application.properties");

            if (input == null) {
                File file = new File("WebContent/WEB-INF/classes/application.properties");
                if (file.exists()) {
                    input = new FileInputStream(file);
                }
            }

            if (input == null) {
                throw new RuntimeException("application.properties 파일을 찾을 수 없습니다.");
            }

            prop.load(input);

            // AES 키와 IV 가져오기, 공백 제거
            this.secretKey = prop.getProperty("my.crypto.key.secret").trim();
            this.ivKey = prop.getProperty("my.crypto.key.iv").trim();

        } catch (Exception e) {
            throw new RuntimeException("AES 키 초기화 실패", e);
        }
    }

    public String encrypt(String plainText) throws Exception {
        byte[] decodedKey = Base64.getDecoder().decode(secretKey);
        byte[] decodedIV = Base64.getDecoder().decode(ivKey);

        SecretKeySpec secretKeySpec = new SecretKeySpec(decodedKey, "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(decodedIV);

        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);

        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    public String decrypt(String encryptedText) throws Exception {
        byte[] decodedKey = Base64.getDecoder().decode(secretKey);
        byte[] decodedIV = Base64.getDecoder().decode(ivKey);
        byte[] decodedEncryptedText = Base64.getDecoder().decode(encryptedText);

        SecretKeySpec secretKeySpec = new SecretKeySpec(decodedKey, "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(decodedIV);

        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);

        byte[] decryptedBytes = cipher.doFinal(decodedEncryptedText);
        return new String(decryptedBytes, "UTF-8");
    }
    public String maskResidentNo(String rrn) {
        if (rrn == null || rrn.length() < 7) return rrn;

        String cleaned = rrn.replace("-", ""); 
        // 뒷자리 별표시
        return cleaned.substring(0, 6) + "-" + cleaned.substring(6, 7) + "******";
    }

}
