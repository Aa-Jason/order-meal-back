package cn.exrick.xboot.your.service;

import cn.exrick.xboot.core.base.XbootBaseDao;
import cn.exrick.xboot.core.base.XbootBaseService;
import cn.exrick.xboot.core.entity.User;
import cn.exrick.xboot.your.dao.OrderDao;
import cn.exrick.xboot.your.entity.Order;
import org.aspectj.weaver.ast.Or;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import cn.exrick.xboot.core.common.vo.SearchVo;

import java.util.Date;
import java.util.List;

/**
 * 点餐接口
 * @author Exrick
 */
public interface OrderService extends XbootBaseService<Order, String> {
    /**
    * 多条件分页获取
    * @param order
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<Order> findByCondition(Order order, SearchVo searchVo, Pageable pageable);
//    List<Order> findByIDandDate(Order order, SearchVo searchVo);

    /**
     * 查询日期范围内订餐总数
     * @param searchVo
     * @return
     */
    List<Order> findByDate(SearchVo searchVo);

    /**
     * 查询该用户在查询日期范围内订餐情况
     * @param staffID
     * @param searchVo
     * @return
     */

    List<Order> findByStaffIDAndDate(String staffID,SearchVo searchVo);

    /**
     * 检查该员工在当日有没有订餐
     * @param staffID
     * @param date
     * @return
     */
    boolean checkOrder(String staffID,Date date);

    /**
     * 根据员工id返回订餐信息
     * @param strings
     * @return
     */
    List<Order> findByStaffID(List<String> strings);

    /**
     * 根据日期范围返回选中员工的订餐情况
     * @param IDs
     * @param searchVo
     * @return
     */
    List<Order> findByIDsAndDate(List<String> IDs,SearchVo searchVo);


}