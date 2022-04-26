package cn.exrick.xboot.core.service;

import cn.exrick.xboot.core.base.XbootBaseService;
import cn.exrick.xboot.core.common.vo.SearchVo;
import cn.exrick.xboot.core.entity.StopWord;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 禁用词管理接口
 * @author Exrick
 */
public interface StopWordService extends XbootBaseService<StopWord, String> {

    /**
    * 多条件分页获取
    * @param stopWord
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<StopWord> findByCondition(StopWord stopWord, SearchVo searchVo, Pageable pageable);

}