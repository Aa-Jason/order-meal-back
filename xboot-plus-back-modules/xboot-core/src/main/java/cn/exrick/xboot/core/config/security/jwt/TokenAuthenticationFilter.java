package cn.exrick.xboot.core.config.security.jwt;

import cn.exrick.xboot.core.common.constant.SecurityConstant;
import cn.exrick.xboot.core.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.core.common.utils.ResponseUtil;
import cn.exrick.xboot.core.common.utils.SecurityUtil;
import cn.exrick.xboot.core.common.vo.TokenMember;
import cn.exrick.xboot.core.common.vo.TokenUser;
import cn.exrick.xboot.core.config.properties.XbootAppTokenProperties;
import cn.exrick.xboot.core.config.properties.XbootTokenProperties;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author Exrickx
 */
@Slf4j
public class TokenAuthenticationFilter extends BasicAuthenticationFilter {

    private XbootTokenProperties tokenProperties;

    private XbootAppTokenProperties appTokenProperties;

    private RedisTemplateHelper redisTemplate;

    private SecurityUtil securityUtil;

    public TokenAuthenticationFilter(AuthenticationManager authenticationManager,
                                     XbootTokenProperties tokenProperties,
                                     XbootAppTokenProperties appTokenProperties,
                                     RedisTemplateHelper redisTemplate, SecurityUtil securityUtil) {
        super(authenticationManager);
        this.tokenProperties = tokenProperties;
        this.appTokenProperties = appTokenProperties;
        this.redisTemplate = redisTemplate;
        this.securityUtil = securityUtil;
    }

    public TokenAuthenticationFilter(AuthenticationManager authenticationManager, AuthenticationEntryPoint authenticationEntryPoint) {
        super(authenticationManager, authenticationEntryPoint);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        String header = request.getHeader(SecurityConstant.HEADER);
        if (StrUtil.isBlank(header)) {
            header = request.getParameter(SecurityConstant.HEADER);
        }
        String appHeader = request.getHeader(SecurityConstant.APP_HEADER);
        if (StrUtil.isBlank(appHeader)) {
            appHeader = request.getParameter(SecurityConstant.APP_HEADER);
        }
        Boolean notValid = (StrUtil.isBlank(header) || (!tokenProperties.getRedis() && !header.startsWith(SecurityConstant.TOKEN_SPLIT)))
                && StrUtil.isBlank(appHeader);
        if (notValid) {
            chain.doFilter(request, response);
            return;
        }
        try {
            UsernamePasswordAuthenticationToken authentication = null;
            if (StrUtil.isNotBlank(header)) {
                authentication = getAuthentication(header, response);
            } else {
                authentication = getAppAuthentication(appHeader, response);
            }
            if (authentication == null) {
                return;
            }
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            log.warn(e.toString());
        }

        chain.doFilter(request, response);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(String header, HttpServletResponse response) {

        TokenUser tokenUser = null;
        List<GrantedAuthority> authorities = new ArrayList<>();

        if (tokenProperties.getRedis()) {
            // redis
            String v = redisTemplate.get(SecurityConstant.TOKEN_PRE + header);
            if (StrUtil.isBlank(v)) {
                ResponseUtil.out(response, ResponseUtil.resultMap(false, 401, "?????????????????????????????????"));
                return null;
            }
            tokenUser = new Gson().fromJson(v, TokenUser.class);
            if (tokenProperties.getStorePerms()) {
                // ???????????????
                for (String ga : tokenUser.getPermissions()) {
                    authorities.add(new SimpleGrantedAuthority(ga));
                }
            } else {
                // ????????? ??????????????????
                authorities = securityUtil.getCurrUserPerms(tokenUser.getUsername());
            }
            if (!tokenUser.getSaveLogin()) {
                // ????????????????????????????????????????????????
                redisTemplate.set(SecurityConstant.USER_TOKEN + tokenUser.getUsername(), header, tokenProperties.getTokenExpireTime(), TimeUnit.MINUTES);
                redisTemplate.set(SecurityConstant.TOKEN_PRE + header, v, tokenProperties.getTokenExpireTime(), TimeUnit.MINUTES);
            }
        } else {
            // JWT
            try {
                // ??????token
                Claims claims = Jwts.parser()
                        .setSigningKey(SecurityConstant.JWT_SIGN_KEY)
                        .parseClaimsJws(header.replace(SecurityConstant.TOKEN_SPLIT, ""))
                        .getBody();
                // ????????????
                tokenUser = new Gson().fromJson(claims.getSubject(), TokenUser.class);
                // JWT??????????????? ?????????????????? ??????JWT????????????
                authorities = securityUtil.getCurrUserPerms(tokenUser.getUsername());
            } catch (ExpiredJwtException e) {
                ResponseUtil.out(response, ResponseUtil.resultMap(false, 401, "?????????????????????????????????"));
            } catch (Exception e) {
                log.error(e.toString());
                ResponseUtil.out(response, ResponseUtil.resultMap(false, 500, "??????token??????"));
            }
        }

        if (tokenUser != null && StrUtil.isNotBlank(tokenUser.getUsername())) {
            return new UsernamePasswordAuthenticationToken(tokenUser, null, authorities);
        }
        return null;
    }

    private UsernamePasswordAuthenticationToken getAppAuthentication(String appHeader, HttpServletResponse response) {

        TokenMember tokenMember = null;
        List<GrantedAuthority> authorities = new ArrayList<>();

        if (appTokenProperties.getRedis()) {
            // redis
            String v = redisTemplate.get(SecurityConstant.TOKEN_MEMBER_PRE + appHeader);
            if (StrUtil.isBlank(v)) {
                ResponseUtil.out(response, ResponseUtil.resultMap(false, 401, "???????????????????????????????????????"));
                return null;
            }
            tokenMember = new Gson().fromJson(v, TokenMember.class);
            // ??????
            if (StrUtil.isNotBlank(tokenMember.getPermissions())) {
                authorities = Arrays.stream(tokenMember.getPermissions().split(",")).map(e -> new SimpleGrantedAuthority(e))
                        .collect(Collectors.toList());
            }
            // ????????????????????????
            redisTemplate.set(SecurityConstant.MEMBER_TOKEN + tokenMember.getUsername() + ":" + tokenMember.getPlatform(), appHeader, appTokenProperties.getTokenExpireTime(), TimeUnit.DAYS);
            redisTemplate.set(SecurityConstant.TOKEN_MEMBER_PRE + appHeader, v, appTokenProperties.getTokenExpireTime(), TimeUnit.DAYS);
        } else {
            // JWT
            try {
                // ??????token
                Claims claims = Jwts.parser()
                        .setSigningKey(SecurityConstant.JWT_SIGN_KEY)
                        .parseClaimsJws(appHeader.replace(SecurityConstant.TOKEN_SPLIT, ""))
                        .getBody();
                // ????????????
                tokenMember = new Gson().fromJson(claims.getSubject(), TokenMember.class);
                // ??????
                if (StrUtil.isNotBlank(tokenMember.getPermissions())) {
                    authorities = Arrays.stream(tokenMember.getPermissions().split(",")).map(e -> new SimpleGrantedAuthority(e))
                            .collect(Collectors.toList());
                }
            } catch (ExpiredJwtException e) {
                ResponseUtil.out(response, ResponseUtil.resultMap(false, 401, "?????????????????????????????????"));
            } catch (Exception e) {
                log.error(e.toString());
                ResponseUtil.out(response, ResponseUtil.resultMap(false, 500, "??????token??????"));
            }
        }
        if (tokenMember != null && StrUtil.isNotBlank(tokenMember.getUsername())) {
            return new UsernamePasswordAuthenticationToken(tokenMember, null, authorities);
        }
        return null;
    }
}


