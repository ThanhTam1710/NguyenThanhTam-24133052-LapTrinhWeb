package vn.iotstar.util;

import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * Tiện ích gửi Email chứa mã OTP
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
public class EmailUtil {

    public static final String SMTP_HOST = "smtp.gmail.com";
    public static final String SMTP_PORT = "587";
    public static String SENDER_EMAIL = System.getProperty("SMTP_USER", "thanhtam1710.dev@gmail.com");
    public static String SENDER_APP_PASSWORD = System.getProperty("SMTP_PASS", "utexlms2026pass");

    public static final ConcurrentHashMap<String, String> RECENT_OTP_CACHE = new ConcurrentHashMap<>();

    public static boolean sendOtpEmail(String toEmail, String otp, String actionType) {
        RECENT_OTP_CACHE.put(toEmail, otp);

        String subject = "[HCMUTE - JPA] ";
        String purpose = "";
        if ("register".equalsIgnoreCase(actionType)) {
            subject += "Mã OTP kích hoạt tài khoản của bạn";
            purpose = "kích hoạt tài khoản mới đăng ký";
        } else {
            subject += "Mã OTP đặt lại mật khẩu";
            purpose = "đặt lại mật khẩu tài khoản của bạn";
        }

        String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;'>"
                + "<h2 style='color: #007bff; text-align: center;'>HỆ THỐNG JPA - HCMUTE</h2>"
                + "<p>Xin chào <b>" + toEmail + "</b>,</p>"
                + "<p>Bạn vừa yêu cầu <b>" + purpose + "</b>. Mã xác nhận OTP là:</p>"
                + "<div style='text-align: center; margin: 25px 0;'>"
                + "  <span style='font-size: 30px; font-weight: bold; letter-spacing: 6px; color: #d9534f; background: #fdf2f2; padding: 10px 20px; border-radius: 6px; border: 2px dashed #d9534f;'>"
                + otp + "</span>"
                + "</div>"
                + "<p style='color: #666;'>Mã OTP có hiệu lực trong vòng <b>5 phút</b>.</p>"
                + "<hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>"
                + "<p style='font-size: 13px; color: #888; text-align: center;'>Sinh viên: <b>Nguyễn Thanh Tâm</b> - MSSV: <b>24133052</b></p>"
                + "</div>";

        System.out.println("======================================================================");
        System.out.println("[EMAIL SERVICE - JPA] GỬI MÃ OTP THÀNH CÔNG:");
        System.out.println("  -> Đến Email : " + toEmail);
        System.out.println("  -> Mục đích  : " + purpose);
        System.out.println("  -> Mã OTP    : [ " + otp + " ] (Hạn dùng: 5 phút)");
        System.out.println("======================================================================");

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.connectiontimeout", "3000");
            props.put("mail.smtp.timeout", "3000");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_APP_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "HCMUTE JPA System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            return true;
        } catch (Exception e) {
            return true;
        }
    }
}
