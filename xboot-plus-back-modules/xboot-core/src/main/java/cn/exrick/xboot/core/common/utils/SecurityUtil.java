package cn.exrick.xboot.core.common.utils;

import cn.exrick.xboot.core.common.constant.CommonConstant;
import cn.exrick.xboot.core.common.constant.SecurityConstant;
import cn.exrick.xboot.core.common.constant.UserConstant;
import cn.exrick.xboot.core.common.exception.XbootException;
import cn.exrick.xboot.core.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.core.common.vo.TokenMember;
import cn.exrick.xboot.core.common.vo.TokenUser;
import cn.exrick.xboot.core.config.properties.XbootAppTokenProperties;
import cn.exrick.xboot.core.config.properties.XbootTokenProperties;
import cn.exrick.xboot.core.dao.DepartmentDao;
import cn.exrick.xboot.core.dao.MemberDao;
import cn.exrick.xboot.core.dao.UserDao;
import cn.exrick.xboot.core.dao.mapper.PermissionMapper;
import cn.exrick.xboot.core.dao.mapper.UserRoleMapper;
import cn.exrick.xboot.core.entity.*;
import cn.exrick.xboot.core.service.mybatis.IUserRoleService;
import cn.exrick.xboot.core.vo.PermissionDTO;
import cn.exrick.xboot.core.vo.RoleDTO;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author Exrickx
 */
@Component
public class SecurityUtil {

    @Autowired
    private XbootTokenProperties tokenProperties;

    @Autowired
    private XbootAppTokenProperties appTokenProperties;

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private IUserRoleService iUserRoleService;

    @Autowired
    private DepartmentDao departmentDao;

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private RedisTemplateHelper redisTemplate;

    /**
     * -------------------ToB-------------------------
     */

    public User findUserByUsername(String username) {

        String key = "username::" + username;
        // ????????????
        String res = redisTemplate.get(key);
        if (StrUtil.isNotBlank(res)) {
            return userToDTO(new Gson().fromJson(res, User.class));
        }
        User user = userToDTO(userDao.findByUsername(username));
        // ??????
        redisTemplate.set(key, new Gson().toJson(user), 15L, TimeUnit.DAYS);
        return user;
    }

    public User findUserByMobile(String mobile) {

        return userToDTO(userDao.findByMobile(mobile));
    }

    public User findUserByEmail(String email) {

        return userToDTO(userDao.findByEmail(email));
    }

    public User userToDTO(User user) {

        if (user == null) {
            return null;
        }
        // ????????????
        List<Role> roleList = userRoleMapper.findByUserId(user.getId());
        List<RoleDTO> roleDTOList = roleList.stream().map(e ->
                new RoleDTO().setId(e.getId()).setName(e.getName())).collect(Collectors.toList());
        user.setRoles(roleDTOList);
        // ??????????????????
        List<Permission> permissionList = permissionMapper.findByUserId(user.getId());
        List<PermissionDTO> permissionDTOList = permissionList.stream()
                .filter(e -> CommonConstant.PERMISSION_OPERATION.equals(e.getType()))
                .map(e -> new PermissionDTO().setTitle(e.getTitle()).setPath(e.getPath())).collect(Collectors.toList());
        user.setPermissions(permissionDTOList);
        return user;
    }

    public User checkUserPassword(String username, String password) {

        User user;
        // ???????????????
        if (NameUtil.mobile(username)) {

            user = findUserByMobile(username);

        } else if (NameUtil.email(username)) {
            user = findUserByEmail(username);
        } else {
            user = findUserByUsername(username);
        }
        if (user == null) {
            return null;
        }
        // ????????????
        Boolean isValid = new BCryptPasswordEncoder().matches(password, user.getPassword());
        if (!isValid) {
            return null;
        }
        return user;
    }

    public String getToken(String username, Boolean saveLogin) {

        if (StrUtil.isBlank(username)) {
            throw new XbootException("username????????????");
        }
        User user = findUserByUsername(username);
        return getToken(user, saveLogin);
    }

    public String getToken(User user, Boolean saveLogin) {

        if (user == null) {
            throw new XbootException("user????????????");
        }
        if (UserConstant.USER_STATUS_LOCK.equals(user.getStatus())) {
            throw new XbootException("????????????????????????????????????");
        }
        Boolean saved = false;
        if (saveLogin == null || saveLogin) {
            saved = true;
            if (!tokenProperties.getRedis()) {
                tokenProperties.setTokenExpireTime(tokenProperties.getSaveLoginTime() * 60 * 24);
            }
        }
        // ??????token
        String token;
        TokenUser tokenUser;
        if (tokenProperties.getRedis()) {
            // redis
            token = IdUtil.simpleUUID();
            tokenUser = new TokenUser(user, tokenProperties.getStorePerms(), saved);
            // ??????????????? ?????????token??????
            if (tokenProperties.getSdl()) {
                String oldToken = redisTemplate.get(SecurityConstant.USER_TOKEN + user.getUsername());
                if (StrUtil.isNotBlank(oldToken)) {
                    redisTemplate.delete(SecurityConstant.TOKEN_PRE + oldToken);
                }
            }
            // ??????????????????/????????????
            if (saved) {
                redisTemplate.set(SecurityConstant.USER_TOKEN + user.getUsername(), token, tokenProperties.getSaveLoginTime(), TimeUnit.DAYS);
                redisTemplate.set(SecurityConstant.TOKEN_PRE + token, new Gson().toJson(tokenUser), tokenProperties.getSaveLoginTime(), TimeUnit.DAYS);
            } else {
                redisTemplate.set(SecurityConstant.USER_TOKEN + user.getUsername(), token, tokenProperties.getTokenExpireTime(), TimeUnit.MINUTES);
                redisTemplate.set(SecurityConstant.TOKEN_PRE + token, new Gson().toJson(tokenUser), tokenProperties.getTokenExpireTime(), TimeUnit.MINUTES);
            }
        } else {
            // JWT ??????????????? ??????JWT????????????
            tokenUser = new TokenUser(user, false, null);
            token = SecurityConstant.TOKEN_SPLIT + Jwts.builder()
                    // ?????? ??????????????????
                    .setSubject(new Gson().toJson(tokenUser))
                    // ????????????
                    .setExpiration(new Date(System.currentTimeMillis() + tokenProperties.getTokenExpireTime() * 60 * 1000))
                    // ?????????????????????
                    .signWith(SignatureAlgorithm.HS512, SecurityConstant.JWT_SIGN_KEY)
                    .compact();
        }

        // ??????????????????
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(tokenUser, null, null);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return token;
    }

    /**
     * ???????????????????????? ??????????????????
     * @return
     */
    public User getCurrUser() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication instanceof AnonymousAuthenticationToken) {
            throw new XbootException("????????????????????????");
        }
        return findUserByUsername(authentication.getName());
    }

    /**
     * ?????????????????????????????????????????? id???username???nickname???mobile???email???departmentId???type???permissions????????????????????????
     * @return
     */
    public User getCurrUserSimple() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication instanceof AnonymousAuthenticationToken) {
            throw new XbootException("????????????????????????");
        }
        TokenUser tokenUser = (TokenUser) authentication.getPrincipal();
        User user = new User().setUsername(tokenUser.getUsername()).setNickname(tokenUser.getNickname()).
                setMobile(tokenUser.getMobile()).setEmail(tokenUser.getEmail()).setDepartmentId(tokenUser.getDepartmentId()).setType(tokenUser.getType());
        if (tokenUser.getPermissions() != null && !tokenUser.getPermissions().isEmpty()) {
            user.setPermissions(tokenUser.getPermissions().stream().map(e -> new PermissionDTO().setTitle(e)).collect(Collectors.toList()));
        }
        user.setId(tokenUser.getId());
        return user;
    }

    /**
     * ?????????????????????????????? ???????????????????????????
     */
    public Boolean isSelfDataPerm() {

        List<String> list = getDeparmentIds();
        if (list == null) {
            return false;
        }
        return list.contains("-2");
    }

    /**
     * ?????????????????????????????? null???????????????????????? ????????????-1?????????????????????????????? ????????????-2?????????????????????????????????
     */
    public List<String> getDeparmentIds() {

        List<String> deparmentIds = new ArrayList<>();
        User u = getCurrUserSimple();
        // ????????????
        String key = "userRole::depIds:" + u.getId();
        String v = redisTemplate.get(key);
        if (StrUtil.isNotBlank(v)) {
            deparmentIds = new Gson().fromJson(v, new TypeToken<List<String>>() {
            }.getType());
            return deparmentIds;
        }
        // ????????????????????????
        List<Role> roles = iUserRoleService.findByUserId(u.getId());
        // ?????????????????????????????????
        Boolean flagAll = false;
        for (Role r : roles) {
            if (r.getDataType() == null || r.getDataType().equals(CommonConstant.DATA_TYPE_ALL)) {
                flagAll = true;
                break;
            }
        }
        // ????????????????????????null
        if (flagAll) {
            return null;
        }
        // ?????????????????? ?????????
        for (Role r : roles) {
            if (r.getDataType().equals(CommonConstant.DATA_TYPE_UNDER)) {
                // ??????????????????
                if (StrUtil.isBlank(u.getDepartmentId())) {
                    // ???????????????
                    deparmentIds.add("-1");
                } else {
                    // ???????????????????????????
                    List<String> ids = new ArrayList<>();
                    getDepRecursion(u.getDepartmentId(), ids);
                    deparmentIds.addAll(ids);
                }
            } else if (r.getDataType().equals(CommonConstant.DATA_TYPE_SAME)) {
                // ?????????
                if (StrUtil.isBlank(u.getDepartmentId())) {
                    // ???????????????
                    deparmentIds.add("-1");
                } else {
                    deparmentIds.add(u.getDepartmentId());
                }
            } else if (r.getDataType().equals(CommonConstant.DATA_TYPE_CUSTOM)) {
                // ?????????
                List<String> depIds = iUserRoleService.findDepIdsByUserId(u.getId());
                if (depIds == null || depIds.size() == 0) {
                    deparmentIds.add("-1");
                } else {
                    deparmentIds.addAll(depIds);
                }
            } else if (r.getDataType().equals(CommonConstant.DATA_TYPE_SELF)) {
                // ??????
                deparmentIds.add("-2");
            }
        }
        // ??????
        LinkedHashSet<String> set = new LinkedHashSet<>(deparmentIds.size());
        set.addAll(deparmentIds);
        deparmentIds.clear();
        deparmentIds.addAll(set);
        // ??????
        redisTemplate.set(key, new Gson().toJson(deparmentIds), 15L, TimeUnit.DAYS);
        return deparmentIds;
    }

    private void getDepRecursion(String departmentId, List<String> ids) {

        Department department = departmentDao.getById(departmentId);
        ids.add(department.getId());
        if (department.getIsParent() != null && department.getIsParent()) {
            // ???????????????
            List<Department> departments =
                    departmentDao.findByParentIdAndStatusOrderBySortOrder(departmentId, CommonConstant.STATUS_NORMAL);
            departments.forEach(d -> {
                getDepRecursion(d.getId(), ids);
            });
        }
    }

    /**
     * ???????????????????????????????????????
     * @param username
     */
    public List<GrantedAuthority> getCurrUserPerms(String username) {

        List<GrantedAuthority> authorities = new ArrayList<>();
        User user = findUserByUsername(username);
        if (user == null || user.getPermissions() == null || user.getPermissions().isEmpty()) {
            return authorities;
        }
        for (PermissionDTO p : user.getPermissions()) {
            authorities.add(new SimpleGrantedAuthority(p.getTitle()));
        }
        return authorities;
    }

    /**
     * -------------------App ToC-------------------------
     */

    public Member findMemberByUsername(String username) {

        return memberDao.findByUsername(username);
    }

    public Member findMemberByMobile(String mobile) {

        String key = "member::" + mobile;
        // ????????????
        String res = redisTemplate.get(key);
        if (StrUtil.isNotBlank(res)) {
            return new Gson().fromJson(res, Member.class);
        }
        Member member = memberDao.findByMobile(mobile);
        // ??????
        redisTemplate.set(key, new Gson().toJson(member), 15L, TimeUnit.DAYS);
        return member;
    }

    public String getAppToken(String username, Integer platform) {

        if (StrUtil.isBlank(username)) {
            throw new XbootException("username????????????");
        }
        Member member = findMemberByUsername(username);
        return getAppToken(member, platform);
    }

    public String getAppToken(Member member, Integer platform) {

        if (member == null) {
            throw new XbootException("member????????????");
        }
        if (UserConstant.USER_STATUS_LOCK.equals(member.getStatus())) {
            throw new XbootException("????????????????????????????????????");
        }
        // ??????token
        String token;
        TokenMember tokenMember;
        if (appTokenProperties.getRedis()) {
            // redis
            token = IdUtil.simpleUUID();
            tokenMember = new TokenMember(member, platform);
            String key = SecurityConstant.MEMBER_TOKEN + tokenMember.getUsername() + ":" + platform;
            // ??????????????? ?????????token??????
            if (appTokenProperties.getSpl()) {
                String oldToken = redisTemplate.get(key);
                if (StrUtil.isNotBlank(oldToken)) {
                    redisTemplate.delete(SecurityConstant.TOKEN_MEMBER_PRE + oldToken);
                }
            }
            redisTemplate.set(key, token, appTokenProperties.getTokenExpireTime(), TimeUnit.DAYS);
            redisTemplate.set(SecurityConstant.TOKEN_MEMBER_PRE + token, new Gson().toJson(tokenMember), appTokenProperties.getTokenExpireTime(), TimeUnit.DAYS);
        } else {
            // JWT
            tokenMember = new TokenMember(member, platform);
            token = SecurityConstant.TOKEN_SPLIT + Jwts.builder()
                    // ?????? ??????????????????
                    .setSubject(new Gson().toJson(tokenMember))
                    // ????????????
                    .setExpiration(new Date(System.currentTimeMillis() + appTokenProperties.getTokenExpireTime() * 60 * 1000))
                    // ?????????????????????
                    .signWith(SignatureAlgorithm.HS512, SecurityConstant.JWT_SIGN_KEY)
                    .compact();
        }
        // ??????????????????
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(tokenMember, null, null);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return token;
    }

    /**
     * ?????????????????????????????? ????????????
     * @return
     */
    public Member getCurrMember() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication instanceof AnonymousAuthenticationToken) {
            throw new XbootException("????????????????????????");
        }
        return findMemberByUsername(authentication.getName());
    }

    /**
     * ???????????????????????????????????? id???username???nickname???mobile???email???type???permissions???platform
     * @return
     */
    public Member getCurrMemberSimple() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication instanceof AnonymousAuthenticationToken) {
            throw new XbootException("????????????????????????");
        }
        TokenMember tokenMember = (TokenMember) authentication.getPrincipal();
        Member member = new Member().setUsername(tokenMember.getUsername()).setNickname(tokenMember.getNickname())
                .setMobile(tokenMember.getMobile()).setEmail(tokenMember.getEmail()).setType(tokenMember.getType())
                .setPermissions(tokenMember.getPermissions()).setPlatform(tokenMember.getPlatform());
        member.setId(tokenMember.getId());
        return member;
    }
}
