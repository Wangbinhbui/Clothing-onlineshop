/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.shop.swp391.controller.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.shop.swp391.config.GlobalConfig;
import com.shop.swp391.entity.User;
import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.controller.utils.MD5PasswordEncoderUtils;
@WebServlet(name = "ProfileController", urlPatterns = { "/profile", "/change-password" })
public class ProfileController extends HttpServlet {

    private UserDAO userDAO;
    private final String PROFILE_JSP = "view/profile/profile.jsp";
    private final String CHANGE_PASSWORD_JSP = "view/profile/change-password.jsp";
    private final String LOGIN_JSP = "authen?action=login";

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathRequest = request.getServletPath();
        if (pathRequest.equals("/profile")) {
            handleProfileRequest(request, response);
        } else if (pathRequest.equals("/change-password")) {
            handleChangePasswordRequest(request, response);
        } else {
            response.sendRedirect("authen?action=login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathRequest = request.getServletPath();

        if ("/profile".equals(pathRequest)) {
            updateProfile(request, response);
        } else if ("/change-password".equals(pathRequest)) {
            changePassword(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String dob = request.getParameter("dob");
            boolean sex = Boolean.parseBoolean(request.getParameter("sex"));

            // Lấy user từ session
            User currentUser = (User) request.getSession().getAttribute(GlobalConfig.SESSION_ACCOUNT);

            // Kiểm tra xem user có quyền chỉnh sửa thông tin này không
            if (currentUser != null && currentUser.getId() == id) {
                // Tạo đối tượng User với thông tin mới
                User updatedUser = new User();
                updatedUser.setId(id);
                updatedUser.setFirstName(firstName);
                updatedUser.setLastName(lastName);
                updatedUser.setPhone(phone);
                updatedUser.setDob(dob);
                updatedUser.setSex(sex);
                updatedUser.setRoleId(currentUser.getRoleId());
                updatedUser.setEmail(currentUser.getEmail());
                updatedUser.setUsername(currentUser.getUsername());

                // Cập nhật vào database
                boolean isUpdated = userDAO.update(updatedUser);

                if (isUpdated) {
                    // Cập nhật lại thông tin trong session
                    currentUser.setFirstName(firstName);
                    currentUser.setLastName(lastName);
                    currentUser.setPhone(phone);
                    currentUser.setDob(dob);
                    currentUser.setSex(sex);

                    request.setAttribute("suc", "Profile updated successfully!");
                } else {
                    request.setAttribute("err", "Failed to update profile!");
                }
            } else {
                request.setAttribute("err", "Unauthorized access!");
            }
        } catch (Exception e) {
            request.setAttribute("err", "An error occurred: " + e.getMessage());
        }

        // Chuyển hướng trở lại trang profile
        doGet(request, response);
    }

    private void handleProfileRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute(GlobalConfig.SESSION_ACCOUNT);
        if (user == null) {
            response.sendRedirect("authen?action=login");
            return;
        }

        // find user by email
        user = userDAO.findByEmail(user);
        request.setAttribute("user", user);
        request.getRequestDispatcher(PROFILE_JSP).forward(request, response);
    }

    private void handleChangePasswordRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute(GlobalConfig.SESSION_ACCOUNT);
        if (user == null) {
            response.sendRedirect("authen?action=login");
            return;
        }
        // find user by email
        user = userDAO.findByEmail(user);
        request.setAttribute("user", user);
        request.getRequestDispatcher(CHANGE_PASSWORD_JSP).forward(request, response);

    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //get id from session
            User user = (User) request.getSession().getAttribute(GlobalConfig.SESSION_ACCOUNT);
            //check if user is null
            if (user == null) {
                request.setAttribute("err", "User not found!");
                response.sendRedirect(LOGIN_JSP);
                return;
            }

            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("err", "New password and confirm password do not match!");
                request.getRequestDispatcher(CHANGE_PASSWORD_JSP).forward(request, response);
                return;
            }

            //find user by email
            user = userDAO.findByEmail(user);
            if (user == null) {
                request.setAttribute("err", "User not found!");
                request.getRequestDispatcher(CHANGE_PASSWORD_JSP).forward(request, response);
                return;
            }

            //check old password
            if (!user.getPassword().equals(MD5PasswordEncoderUtils.encodeMD5(oldPassword))) {
                request.setAttribute("err", "Old password is incorrect!");
                request.getRequestDispatcher(CHANGE_PASSWORD_JSP).forward(request, response);
                return;
            }

            //update password
            user.setPassword(MD5PasswordEncoderUtils.encodeMD5(newPassword));
            boolean isUpdated = userDAO.updatePassword(user);
            if (isUpdated) {
                request.setAttribute("suc", "Password updated successfully!");
            } else {
                request.setAttribute("err", "Failed to update password!");
            }
            //update session
            request.getSession().setAttribute(GlobalConfig.SESSION_ACCOUNT, user);

            
        } catch (Exception e) {
            request.setAttribute("err", "An error occurred: " + e.getMessage());
        }
        request.getRequestDispatcher(CHANGE_PASSWORD_JSP).forward(request, response);
    }
}
