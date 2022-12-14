package cn.exrick.xboot.core.service;

import cn.exrick.xboot.core.base.XbootBaseService;
import cn.exrick.xboot.core.entity.Department;

import java.util.List;

/**
 * 部门接口
 * @author Exrick
 */
public interface DepartmentService extends XbootBaseService<Department, String> {

    /**
     * 通过父id获取 升序
     * @param parentId
     * @param openDataFilter 是否开启数据权限
     * @return
     */
    List<Department> findByParentIdOrderBySortOrder(String parentId, Boolean openDataFilter);

    /**
     * 通过父id和状态获取
     * @param parentId
     * @param status
     * @return
     */
    List<Department> findByParentIdAndStatusOrderBySortOrder(String parentId, Integer status);

    /**
     * 部门名模糊搜索 升序
     * @param title
     * @param openDataFilter 是否开启数据权限
     * @return
     */
    List<Department> findByTitleLikeOrderBySortOrder(String title, Boolean openDataFilter);

    /**
     * 返回所有部门的部门名
     * @return
     */
    List<String> findAllname();
}