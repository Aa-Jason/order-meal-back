 package cn.exrick.xboot.your.dao;

import cn.exrick.xboot.core.base.XbootBaseDao;
import cn.exrick.xboot.core.common.vo.Result;
import cn.exrick.xboot.core.entity.User;
import cn.exrick.xboot.your.entity.Order;
import org.aspectj.weaver.ast.Or;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Date;
import java.util.List;

/**
 * 点餐数据处理层
 * @author Exrick
 */
public interface OrderDao extends XbootBaseDao<Order, String> {

    /**
     * 按照日期查找
     * @param date
     * @return
     */
    List<Order> findByDate(Date date);

    /**
     * 按照唯一标识和时间查找
     * @param staffID
     * @param date
     * @return
     */

    Order findByStaffIDAndDate(String staffID,Date date);

    /**
     * 根据员工ID查询员工订餐信息
     * @param staffID
     * @return
     */
    List<Order> findByStaffID(String staffID);

    List<Order> findAll();



}