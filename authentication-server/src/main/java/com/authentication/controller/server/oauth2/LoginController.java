package com.authentication.controller.server.oauth2;

import com.authentication.repository.RoleRepository;
import com.authentication.repository.UserRepository;
import com.authentication.service.UserService;
import com.authentication.model.entity.Role;
import com.authentication.model.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleRepository roleRepository;

    @GetMapping("/account")
    public ModelAndView account() {
        return new ModelAndView("account");
    }

    @PostMapping("/register")
    public String demo(HttpServletRequest request) {
        String username = request.getParameter("newUsername");
        String email = request.getParameter("email");
        String password = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        if (password.equals(confirmPassword) && userService.notExistEmail(email)) {
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(new BCryptPasswordEncoder(10).encode(password));
            user.setEnabled(true);
            user.setAccountNonLocked(true);
            user.setAccountNonExpired(true);
            user.setCredentialsNonExpired(true);
            Role role = roleRepository.findById(2).get();
            List<Role> roles = new ArrayList<>();
            roles.add(role);
            user.setRoles(roles);
            userService.save(user);
            return "redirect:http://localhost:8080/account";
        }
        return "error";
    }

    @PostMapping("/forgot")
    public ModelAndView sendMail(HttpServletRequest request){
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        if(!(userService.notExistEmail(email)) && !(userService.notExistUsername(username))) {
            return new ModelAndView("redirect:http://localhost:8082/verifyCode?email="+email);
        } else {
            return new ModelAndView("error");
        }
    }

    @PostMapping("/changePassword")
    public ModelAndView changePassword(HttpServletRequest request, HttpSession session){
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        User user = userService.findByEmail(email);
        if((newPassword.equals(confirmPassword)) && (user != null)){
            userService.changePassword(user, newPassword);

            session.removeAttribute("target");
            session.removeAttribute("email");
            return new ModelAndView("redirect:http://localhost:8080/account");
        }
        return  new ModelAndView("error");
    }
}