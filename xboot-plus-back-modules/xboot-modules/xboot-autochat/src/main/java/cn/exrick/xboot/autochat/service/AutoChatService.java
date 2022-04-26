package cn.exrick.xboot.autochat.service;

import cn.exrick.xboot.autochat.entity.AutoChat;
import cn.exrick.xboot.core.base.XbootBaseService;
import cn.exrick.xboot.core.common.vo.SearchVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 问答助手客服接口
 * @author Exrick
 */
public interface AutoChatService extends XbootBaseService<AutoChat, String> {

    /**
     * 多条件分页获取
     * @param autoChat
     * @param searchVo
     * @param pageable
     * @return
     */
    Page<AutoChat> findByCondition(AutoChat autoChat, SearchVo searchVo, Pageable pageable);

    /**
     * 完全匹配
     * @param title
     * @return
     */
    AutoChat findByTitle(String title);
}