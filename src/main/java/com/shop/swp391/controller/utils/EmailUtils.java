package com.shop.swp391.controller.utils;

import com.shop.swp391.Config.GlobalConfig;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Map;
import jakarta.servlet.ServletContext;

public class EmailUtils {

    public static boolean sendMail(ServletContext context, String to, String subject, String content) throws AddressException, MessagingException {
        @SuppressWarnings("unchecked")
        Map<String, String> settings = (Map<String, String>) context.getAttribute("settings");
        String username = settings.get(GlobalConfig.SETTING_KEY_EMAIL_APP_USERNAME);
        String password = settings.get(GlobalConfig.SETTING_KEY_EMAIL_APP_PASSWORD);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setContent(content, "text/html; charset=UTF-8");

        Transport.send(message);
        return true;
    }

    // public static String sendOTPMail(String to) {
    //     int otp = GlobalUtils.generateOTP(6); // Sử dụng phương thức generateOTP để tạo OTP
    //     String subject = "Mã OTP";
    //     String content = "Mã OTP của bạn là: " + otp;

    //     try {
    //         sendMail(to, subject, content);
    //     } catch (MessagingException ex) {
    //         Logger.getLogger(EmailUtils.class.getName()).log(Level.SEVERE, null, ex);
    //     }

    //     return String.valueOf(otp);
    // }

    public static String sendOTPMail(ServletContext context, String to) {
        int otp = GlobalUtils.generateOTP(6);
        String subject = "Mã OTP";
        String content = "Mã OTP của bạn là: " + otp;

        try {
            sendMail(context, to, subject, content);
        } catch (MessagingException ex) {
            Logger.getLogger(EmailUtils.class.getName()).log(Level.SEVERE, null, ex);
        }

        return String.valueOf(otp);
    }
    
    // public static void main(String[] args) {
    //     sendOTPMail("vinhpham2761@gmail.com");
    // }
}
