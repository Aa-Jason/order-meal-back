package cn.exrick.xboot.core.dao;

import cn.exrick.xboot.core.base.XbootBaseDao;
import cn.exrick.xboot.core.entity.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.sql.DataTruncation;
import java.util.List;

/**
 * 用户数据处理层
 * @author Exrickx
 */
public interface UserDao extends XbootBaseDao<User, String> {

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
     * 通过邮件获取用户
     * @param email
     * @return
     */
    User findByEmail(String email);

    /**
     * 通过部门id获取
     * @param departmentId
     * @return
     */
    List<User> findByDepartmentId(String departmentId);

    /**
     * 通过用户名模糊搜索
     * @param key
     * @param status
     * @return
     */
    @Query("select u from User u where u.username like %?1% or u.nickname like %?1% and u.status = ?2")
    List<User> findByUsernameLikeAndStatus(String key, Integer status);

    /**
     * 更新部门名称
     * @param departmentId
     * @param departmentTitle
     */
    @Modifying
    @Query("update User u set u.departmentTitle=?2 where u.departmentId=?1")
    void updateDepartmentTitle(String departmentId, String departmentTitle);

    /**
     * 按照用户名搜索
     * @param nickname
     * @return
     */
    List<User> findByNickname(String nickname);

    /**
     * 按照部门名查找
     * @param title
     * @return
     */
    List<User> findByDepartmentTitle(String title);

    /**
     * 按照用户名和部门查找
     * @param title
     * @param nickname
     * @return
     */
    List<User> findByDepartmentTitleAndNickname(String title,String nickname);
}
