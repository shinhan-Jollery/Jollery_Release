package com.shinhan.util;

import java.io.IOException;
import java.security.Key;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JWT2RequestFilter implements Filter {

    private static final String SECRET_KEY = "nahyunjungyeonmomosanajihyomimidahyuncheyoungtwuyu";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 荑좏궎�뿉�꽌 JWT 異붿텧
        String token = null;
        javax.servlet.http.Cookie[] cookies = httpRequest.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if ("jwtToken".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token != null) {
            try {
                Claims claims = Jwts.parser()
                        .setSigningKey(SECRET_KEY)
                        .build()
                        .parseClaimsJws(token)
                        .getBody();

                // JWT�룷�옣 �쑐怨� Request�뿉 �꽔湲�
             
                String Member_name = claims.getSubject();
                httpRequest.setAttribute("isArtist", claims.get("isArtist"));
                httpRequest.setAttribute("userId", claims.get("userId"));
                httpRequest.setAttribute("member_login_ID", claims.get("member_login_ID"));
                httpRequest.setAttribute("Member_name", Member_name);
   
            } catch (Exception e) {
                // 濡쒓렇�씤 X or �쐞議�
                httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid JWT token");
            }
        } else {
//            System.out.println("로그인안됨");
        }
        chain.doFilter(request, response);
    }


    @Override
    public void destroy() {
    }

}
