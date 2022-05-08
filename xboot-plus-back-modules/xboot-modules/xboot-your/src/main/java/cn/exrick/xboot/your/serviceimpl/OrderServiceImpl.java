package cn.exrick.xboot.your.serviceimpl;

import cn.exrick.xboot.core.entity.User;
import cn.exrick.xboot.your.dao.OrderDao;
import cn.exrick.xboot.your.entity.Order;
import cn.exrick.xboot.your.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.exrick.xboot.core.common.vo.SearchVo;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.lang.Nullable;

import java.util.*;
import javax.persistence.criteria.*;

/**
 * 点餐接口实现
 * @author Exrick
 */
@Slf4j
@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Override
    public OrderDao getRepository() {
        return orderDao;
    }

    @Override
    public Page<Order> findByCondition(Order order, SearchVo searchVo, Pageable pageable) {

        return orderDao.findAll(new Specification<Order>() {
            @Nullable
            @Override
            public Predicate toPredicate(Root<Order> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {

                // TODO 可添加你的其他搜索过滤条件 默认已有创建时间过滤
                Path<Date> createTimeField = root.get("createTime");

                List<Predicate> list = new ArrayList<>();

                // 创建时间
                if(StrUtil.isNotBlank(searchVo.getStartDate())&&StrUtil.isNotBlank(searchVo.getEndDate())){
                    Date start = DateUtil.parse(searchVo.getStartDate());
                    Date end = DateUtil.parse(searchVo.getEndDate());
                    list.add(cb.between(createTimeField, start, DateUtil.endOfDay(end)));
                }

                Predicate[] arr = new Predicate[list.size()];
                cq.where(list.toArray(arr));
                return null;
            }
        }, pageable);
    }

    @Override
    public List<Order> findByDate(SearchVo searchVo) {
        Date start = DateUtil.parse(searchVo.getStartDate());
        Date end = DateUtil.parse(searchVo.getEndDate());
        List<Order> orders = new ArrayList<>();
        while (start.before(end) || start.equals(end)){
            List<Order> obj = orderDao.findByDate(start);
            if (obj != null) {
                Order order = new Order();
                for (Order order1 :
                        obj) {
                    order.setDate(order1.getDate());
                    order.setBreakfast(order.getBreakfast() + order1.getBreakfast());
                    order.setLunch(order.getLunch() + order1.getLunch());
                    order.setDinner(order.getDinner() + order1.getDinner());

                }
                orders.add(order);
            }
            Calendar cal = Calendar.getInstance();
            cal.setTime(start);
            cal.add(Calendar.DATE, 1);
            start=cal.getTime();
        }
        return orders;
    }

    @Override
    public List<Order> findByStaffIDAndDate(String staffID, SearchVo searchVo) {
        Date start = DateUtil.parse(searchVo.getStartDate());
        Date end = DateUtil.parse(searchVo.getEndDate());
        List<Order> orders = new ArrayList<>();
        while (start.before(end) || start.equals(end)){
            Order ord = orderDao.findByStaffIDAndDate(staffID, start);
            orders.add(ord);
            Calendar cal = Calendar.getInstance();
            cal.setTime(start);
            cal.add(Calendar.DATE, 1);
            start=cal.getTime();
        }
        return orders;
    }

    @Override
    public boolean checkOrder(String staffID, Date date) {
        if (orderDao.findByStaffIDAndDate(staffID,date) == null){
            return false;
        }else {
            return true;
        }

    }

    @Override
    public List<Order> findByStaffID(List<String> strings) {
        List<Order> orders = new ArrayList<>();
        for (String s :
                strings) {
            orders.addAll(orderDao.findByStaffID(s));
        }
        return orders;
    }

    @Override
    public List<Order> findByIDsAndDate(List<String> IDs, SearchVo searchVo) {
        Date start = DateUtil.parse(searchVo.getStartDate());
        Date end = DateUtil.parse(searchVo.getEndDate());
        List<Order> orders = new ArrayList<>();
        while (start.before(end) || start.equals(end)){
            Order order = new Order();
            order.setDate(start);
            for (String id :
                    IDs) {
                Order order1 = orderDao.findByStaffIDAndDate(id, start);
                order.setBreakfast(order.getBreakfast()+order1.getBreakfast());
                order.setLunch(order.getLunch()+order1.getLunch());
                order.setDinner(order.getDinner() + order1.getDinner());
            }
            orders.add(order);
            Calendar cal = Calendar.getInstance();
            cal.setTime(start);
            cal.add(Calendar.DATE, 1);
            start = cal.getTime();
        }
        return orders;
    }
}