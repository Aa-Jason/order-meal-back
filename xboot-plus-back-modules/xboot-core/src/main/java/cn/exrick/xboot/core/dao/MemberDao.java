package cn.exrick.xboot.core.dao;


import cn.exrick.xboot.core.base.XbootBaseDao;
import cn.exrick.xboot.core.entity.Member;

/**
 * 会员数据处理层
 * @author Exrick
 */
public interface MemberDao extends XbootBaseDao<Member, String> {

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    Member findByUsername(String username);

    /**
     * 通过手机获取用户
     * @param mobile
     * @return
     */
    Member findByMobile(String mobile);
}