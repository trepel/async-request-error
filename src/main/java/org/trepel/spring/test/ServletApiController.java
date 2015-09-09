package org.trepel.spring.test;

import javax.servlet.AsyncContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ServletApiController {

    @RequestMapping("/")
    public String welcome() {
        return "index";
    }

    @RequestMapping(value = "/customlogin", method = RequestMethod.GET)
    public String login(@ModelAttribute LoginForm loginForm) {
        return "customlogin";
    }

    @RequestMapping(value = "/customlogin", method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpServletResponse response,
            @ModelAttribute LoginForm loginForm, BindingResult result) throws ServletException {
        try {
            request.login(loginForm.getUsername(), loginForm.getPassword());
        } catch(ServletException authenticationFailed) {
            result.rejectValue(null, "authentication.failed", authenticationFailed.getMessage());
            return "customlogin";
        }
        return "redirect:/";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect) throws ServletException {
        request.logout();
        return "redirect:/";
    }

    @RequestMapping("/async")
    public void asynch(HttpServletRequest request, HttpServletResponse response) {
        final AsyncContext async = request.startAsync();
        async.start(new Runnable() {
            public void run() {
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                try {
                    final HttpServletResponse asyncResponse = (HttpServletResponse) async.getResponse();
                    asyncResponse.setStatus(HttpServletResponse.SC_OK);
                    asyncResponse.getWriter().write(String.valueOf(authentication));
                    async.complete();
                } catch(Exception e) {
                    throw new RuntimeException(e);
                }
            }
        });
    }

}