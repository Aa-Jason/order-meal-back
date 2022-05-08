package cn.exrick.xboot.core.service;


import cn.exrick.xboot.core.base.XbootBaseService;
import cn.exrick.xboot.core.common.vo.SearchVo;
import cn.exrick.xboot.core.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.security.SecureRandom;
import java.util.List;

/**
 * 用户接口
 * @author Exrickx
 */
public interface UserService extends XbootBaseService<User, String> {

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    User findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    User findByMobile(String mobile);

    /**
     * 通过邮件和状态获取用户
     * @param email
     * @return
     */
    User findByEmail(String email);

    /**
     * 多条件分页获取用户
     * @param user
     * @param searchVo
     * @param pageable
     * @return
     */
    Page<User> findByCondition(User user, SearchVo searchVo, Pageable pageable);

    /**
     * 通过部门id获取
     * @param departmentId
     * @return
     */
    List<User> findByDepartmentId(String departmentId);

    /**
     * 通过用户名模糊搜索
     * @param username
     * @param status
     * @return
     */
    List<User> findByUsernameLikeAndStatus(String username, Integer status);

    /**
     * 更新部门名称
     * @param departmentId
     * @param departmentTitle
     */
    void updateDepartmentTitle(String departmentId, String departmentTitle);

    /**
     * 通过部门名搜索ID
     * @param title
     * @return
     */
    List<String> findByDepartmentTitle(String title);

    /**
     * 通过部门名和用户名搜索ID
     * @param nickname
     * @param title
     * @return
     */
    List<String> findByDepartmentTitleAndNickname(String title,String nickname);
}
