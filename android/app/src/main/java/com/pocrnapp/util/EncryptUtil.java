package com.pocrnapp.util;

import com.blankj.utilcode.util.EncryptUtils;

import static com.blankj.utilcode.util.ConvertUtils.hexString2Bytes;

/**
 * Created by Ryan on 29/03/2019.
 */
public class EncryptUtil {
    //    public static String key = "11111111111111111111111111111111";
    public static String key = "11111241111111678941135113151611";
    private static byte[] bytesKeyAES = hexString2Bytes(key);

    public static byte[] encryptAES(final byte[] data) {
        return EncryptUtils.encryptAES2Base64(data, bytesKeyAES,
                "AES/ECB/PKCS5Padding", null);
    }

    public static byte[] decryptAES(final byte[] data) {

        return EncryptUtils.decryptBase64AES(data, bytesKeyAES,
                "AES/ECB/PKCS5Padding", null);
    }


}
