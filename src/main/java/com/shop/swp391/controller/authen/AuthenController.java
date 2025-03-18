/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.authen;

import com.shop.swp391.config.GlobalConfig;
import com.shop.swp391.controller.utils.EmailUtils;
import com.shop.swp391.controller.utils.MD5PasswordEncoderUtils;
import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AuthenController", urlPatterns = { "/authen" })
public class AuthenController extends HttpServlet {

    UserDAO accountDAO = new UserDAO();
    private static final String LOGIN_PAGE = "view/authen/login.jsp";
    private static final String REGISTER_PAGE = "view/authen/register.jsp";
    private static final String FORGOT_PASSWORD_PAGE = "view/authen/enterEmailForgotPassword.jsp";
    private static final String RESET_PASSWORD_PAGE = "view/authen/resetPassword.jsp";
    private static final String VERIFY_OTP_PAGE = "view/authen/verifyOTP.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        // dua theo action set URL trang can chuyen den
        String url;
        switch (action) {
            case "login":
                url = LOGIN_PAGE;
                // url = fakeLogin(request, response);
                break;
            case "logout":
                url = logOut(request, response);
                break;
            case "sign-up":
                url = REGISTER_PAGE;
                break;
            case "enter-email":
                url = FORGOT_PASSWORD_PAGE;
                break;
            default:
                url = LOGIN_PAGE;
        }

        // chuyen trang
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        // dựa theo action để xử lí request
        String url;
        switch (action) {
            case "login":
                url = loginDoPost(request, response);
                break;
            case "sign-up":
                url = signUp(request, response);
                break;
            case "verify-otp":
                url = verifyOTP(request, response);
                break;
            case "forgot-password":
                url = forgotPassword(request, response);
                break;
            case "reset-password":
                url = resetPassword(request, response);
                break;
            default:
                url = "home";
        }
        request.getRequestDispatcher(url).forward(request, response);

    }

    private String logOut(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute(GlobalConfig.SESSION_ACCOUNT);
        return "home";
    }

    private String loginDoPost(HttpServletRequest request, HttpServletResponse response) {
        String url = null;
        // get về các thong tin người dufg nhập
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");
        // kiểm tra thông tin có tồn tại trong DB ko
        User account = User.builder()
                .username(usernameOrEmail)
                .email(usernameOrEmail)
                .password(MD5PasswordEncoderUtils.encodeMD5(password))
                .build();
        User accFoundByUsernamePass = accountDAO.findByEmailOrUsernameAndPass(account);
        // true => trang home ( set account vao trong session )
        if (accFoundByUsernamePass != null) {
            request.getSession().setAttribute(GlobalConfig.SESSION_ACCOUNT,
                    accFoundByUsernamePass);
            url = "home";
            // false => quay tro lai trang login ( set them thong bao loi )
        } else {
            request.setAttribute("error", "Username or password incorrect!!");
            url = LOGIN_PAGE;
        }
        return url;
    }

    private String signUp(HttpServletRequest request, HttpServletResponse response) {
        String url;
        // Lấy thông tin người dùng nhập
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp không
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Password and confirm password not matching");
            url = REGISTER_PAGE;
        }

        // Kiểm tra xem email đã tồn tại trong db chưa
        User account = User.builder()
                .username(username)
                .email(email)
                .password(MD5PasswordEncoderUtils.encodeMD5(password))
                .roleId(GlobalConfig.ROLE_STUDENT)
                .active(false) // Đặt trạng thái ban đầu là "Inactive"
                .sex(true)
                .build();
        User accountFoundByEmail = accountDAO.findByEmail(account);

        if (accountFoundByEmail != null) {
            if (accountFoundByEmail.getUsername().equalsIgnoreCase(username)) {
                request.setAttribute("error", "Username already exist!!");
            } else {
                request.setAttribute("error", "Email already exists!");
            }
            url = REGISTER_PAGE;
        } else {
            // Lưu tài khoản vào database
            int accountId = accountDAO.insert(account);
            if (accountId > 0) {
                // Tạo session cho việc kích hoạt tài khoản sau này
                HttpSession session = request.getSession();
                account.setId(accountId);
                session.setAttribute(GlobalConfig.SESSION_ACCOUNT, account);
                session.setAttribute("email", email);
                session.setMaxInactiveInterval(300);

                // Gửi OTP
                String otp = EmailUtils.sendOTPMail(email);
                session.setAttribute("otp", otp);
                session.setAttribute("otp_purpose", "activation"); // Thêm mục đích OTP

                url = VERIFY_OTP_PAGE;
            } else {
                request.setAttribute("error", "Failed to create account. Please try again.");
                url = REGISTER_PAGE;
            }
        }
        return url;
    }

    private String verifyOTP(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String storedOTP = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");
        String enteredOTP = request.getParameter("otp");
        String purpose = (String) session.getAttribute("otp_purpose");
        String url = null;
        if (storedOTP != null && storedOTP.equals(enteredOTP)) {
            // OTP is correct
            session.removeAttribute("otp");

            if ("activation".equals(purpose)) {
                return handleUserActivation(request, session);
            } else if ("password_reset".equals(purpose)) {
                return handlePasswordReset(request, session);
            } else {
                request.setAttribute("error", "Invalid OTP purpose.");
                url = VERIFY_OTP_PAGE;
            }
        } else {
            // Incorrect OTP
            request.setAttribute("error", "Incorrect OTP. Please try again.");
            url = VERIFY_OTP_PAGE;
        }
        return url;
    }

    private String forgotPassword(HttpServletRequest request, HttpServletResponse response) {
        String url;
        String email = request.getParameter("email");

        // Kiểm tra xem email có tồn tại trong cơ sở dữ liệu không
        User account = User.builder().email(email).build();
        User foundUser = accountDAO.findByEmail(account);

        if (foundUser == null) {
            // Email không tìm thấy trong cơ sở dữ liệu
            request.setAttribute("error", "No account found with this email address.");
            url = FORGOT_PASSWORD_PAGE;
            return url;
        }

        // Gửi OTP
        HttpSession session = request.getSession();
        String otp = EmailUtils.sendOTPMail(email);

        // Lưu thông tin vào session
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);
        session.setAttribute("otp_purpose", "password_reset");
        session.setAttribute("account_id", foundUser.getId());

        // Đặt thời gian hết hạn cho session (ví dụ: 15 phút)
        session.setMaxInactiveInterval(15 * 60);

        url = VERIFY_OTP_PAGE;
        return url;
    }

    private String handleUserActivation(HttpServletRequest request, HttpSession session) {
        User account = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);
        String url = null;
        if (account != null) {
//            account.setIsActive(true);
//            accountDAO.activateUser(account.getId());
            request.setAttribute("message", "Your account has been successfully activated!");
            url = "home";
        } else {
            request.setAttribute("error", "Session expired. Please sign up again.");
            url = REGISTER_PAGE;
        }
        return url;
    }

    private String handlePasswordReset(HttpServletRequest request, HttpSession session) {
        // Redirect to password reset page
        return RESET_PASSWORD_PAGE;
    }

    private String resetPassword(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String url = null;

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            url = RESET_PASSWORD_PAGE;
            return url;
        }

        User account = User.builder()
                .email(email)
                .password(MD5PasswordEncoderUtils.encodeMD5(newPassword))
                .build();

        boolean updated = accountDAO.updatePassword(account);
        if (updated) {
            request.setAttribute("message", "Your password has been successfully reset.");
            url = LOGIN_PAGE;
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            url = RESET_PASSWORD_PAGE;
        }
        return url;
    }

    private String fakeLogin(HttpServletRequest request, HttpServletResponse response) {
        String url = null;
        // get về các thong tin người dufg nhập
        String email = "agfffwwsm@yomail.info";
        String password = "12345";
        // kiểm tra thông tin có tồn tại trong DB ko
        User account = User.builder()
                .email(email)
                .password(MD5PasswordEncoderUtils.encodeMD5(password))
                .build();
        User accFoundByUsernamePass = accountDAO.findByEmailOrUsernameAndPass(account);
        // true => trang home ( set account vao trong session )
        if (accFoundByUsernamePass != null) {
            request.getSession().setAttribute(GlobalConfig.SESSION_ACCOUNT,
                    accFoundByUsernamePass);
            url = "home";
            // false => quay tro lai trang login ( set them thong bao loi )
        } else {
            request.setAttribute("error", "Username or password incorrect!!");
            url = LOGIN_PAGE;
        }
        return url;
    }

}
