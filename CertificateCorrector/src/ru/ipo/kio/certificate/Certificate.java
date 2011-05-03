package ru.ipo.kio.certificate;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;

import javax.swing.*;
import java.io.*;
import java.util.Arrays;

/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 03.05.11
 * Time: 16:04
 */
public class Certificate {

    private File file;
    private final String CERT_FIELD = "json_certificate";

    private String certificateAsString;

    public Certificate(File cert) {
        this.file = cert;
        load();
    }

    public Certificate(File cert, boolean createNew) {
        this.file = cert;
        if (!createNew)
            load();
        else
            createNew();
    }

    @SuppressWarnings({"unchecked"})
    private void createNew() {
        JSONObject cert = new JSONObject();

        JSONObject anketa = new JSONObject();
        anketa.put("surname", "ФАМИЛИЯ");
        anketa.put("name", "ИМЯ");
        anketa.put("second_name", "ОТЧЕСТВО");

        cert.put("_anketa", anketa);
        cert.put("_is_teacher", true);
        cert.put("_position", "Должность или место работы");

        certificateAsString = cert.toJSONString();
    }

    private void load() {
        try {
            JSONObject val = (JSONObject) JSONValue.parseWithException(new InputStreamReader(new FileInputStream(file), "UTF-8"));
            certificateAsString = (String) val.get(CERT_FIELD);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Не удалось прочитать файл " + file);
        }
    }

    public String getCertificateAsString() {
        StringBuilder res = new StringBuilder();
        char prev = 0;
        boolean inside = false;
        for (int i = 0; i < certificateAsString.length(); i++) {
            char c = certificateAsString.charAt(i);
            if (c == '"' && prev != '\\') {
                if (!inside && prev != ':')
                    res.append("\n");
                inside = !inside;
            }
            res.append(c);
            prev = c;
        }

        return res.toString();
    }

    @SuppressWarnings({"unchecked"})
    public void save(String text) throws ParseException, IOException {
        //try parse to test if it is a correct certificate
        JSONObject innerCert = (JSONObject) JSONValue.parseWithException(text);
        String certAsString = innerCert.toJSONString();

        certificateAsString = certAsString;

        JSONObject cert = new JSONObject();
        cert.put(CERT_FIELD, certAsString);
        String SIGN_FIELD = "signature";
        cert.put(SIGN_FIELD, sign(certAsString));

        //save data to file
        FileOutputStream out = new FileOutputStream(file);
        out.write(cert.toJSONString().getBytes("UTF-8"));
        out.close();
    }

    private int sign(String s) throws UnsupportedEncodingException {
        byte[] rawBytes = s.getBytes("UTF-8");
        byte[] bytes = new byte[rawBytes.length + 2];
        bytes[0] = (byte) (rawBytes.length / 256);
        bytes[1] = (byte) (rawBytes.length % 256);
        System.arraycopy(rawBytes, 0, bytes, 2, rawBytes.length);

        int res = 0;
        for (byte b : bytes) {
            res *= 19;
            res += b + 256;
            res %= 1299709;
        }
        return res;
    }
}
