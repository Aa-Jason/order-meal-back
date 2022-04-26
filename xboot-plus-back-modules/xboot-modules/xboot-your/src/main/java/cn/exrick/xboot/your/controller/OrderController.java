package cn.exrick.xboot.your.controller;

import cn.exrick.xboot.core.base.XbootBaseController;
import cn.exrick.xboot.core.common.exception.XbootException;
import cn.exrick.xboot.core.common.utils.PageUtil;
import cn.exrick.xboot.core.common.utils.ResultUtil;
import cn.exrick.xboot.core.common.utils.SecurityUtil;
import cn.exrick.xboot.core.common.utils.SnowFlakeUtil;
import cn.exrick.xboot.core.common.vo.PageVo;
import cn.exrick.xboot.core.common.vo.Result;
import cn.exrick.xboot.core.common.vo.SearchVo;
import cn.exrick.xboot.core.common.vo.TokenUser;
import cn.exrick.xboot.core.entity.User;
import cn.exrick.xboot.core.service.UserService;
import cn.exrick.xboot.your.dao.OrderDao;
import cn.exrick.xboot.your.entity.Order;
import cn.exrick.xboot.your.service.OrderService;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.common.recycler.Recycler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.EntityManager;
import javax.validation.Valid;
import java.sql.Date;
import java.text.DateFormat;
import java.util.List;

/**
 * @author Exrick
 */
@Slf4j
@RestController
@Api(tags = "报餐信息管理接口")
@RequestMapping("/xboot/order")
@Transactional
public class OrderController extends XbootBaseController<Order, String> {
    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Override
    public OrderService getService() {
        return orderService;
    }

    public UserService getUserService() {
        return userService;
    }

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    @ApiOperation(value = "多条件分页获取")
    public Result<Page<Order>> getByCondition(Order order, SearchVo searchVo, PageVo pageVo) {

        Page<Order> page = orderService.findByCondition(order, searchVo, PageUtil.initPage(pageVo));
        return new ResultUtil<Page<Order>>().setData(page);
    }

    // 根据选定的日期查询日期内订餐总数
    @RequestMapping(value = "/getSumByDate", method = RequestMethod.GET)
    @ApiOperation(value = "选定日期内订餐总数")
    public Result<List<Order>> getSunByDate(SearchVo searchVo) {
        List<Order> orders = orderService.findSumByDate(searchVo);
        return new ResultUtil<List<Order>>().setData(orders);
    }

    @RequestMapping(value = "/getByStaffIDAndDate", method = RequestMethod.GET)
    @ApiOperation(value = "当前用户选择日期内订餐情况")
    public Result<List<Order>> getByStaffIDAndDate(SearchVo searchVo) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication instanceof AnonymousAuthenticationToken) {
            throw new XbootException("未检测到登录用户");
        }
        TokenUser tokenUser = (TokenUser) authentication.getPrincipal();
        List<Order> orders = orderService.findByStaffIDAndDate(tokenUser.getId(),searchVo);
        return new ResultUtil<List<Order>>().setData(orders);
    }
    @RequestMapping(value = "/addOrder", method = RequestMethod.POST)
    @ApiOperation(value = "当前用户添加订餐记录")
    public Result<Object> addOrder(Order order,
            @RequestParam(value = "date")Date date,
            @RequestParam(value = "breakfast",required =true)int breakfast,
                                   @RequestParam(value = "lunch",required =true)int lunch,
                                   @RequestParam(value = "dinner",required =true)int dinner){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                || authentication instanceof AnonymousAuthenticationToken) {
            throw new XbootException("未检测到登录用户");
        }
        TokenUser tokenUser = (TokenUser) authentication.getPrincipal();
        if (!orderService.checkOrder(tokenUser.getId(),order.getDate())){
            order.setStaffID(tokenUser.getId());
            order.setId(SnowFlakeUtil.nextId().toString());
            orderService.save(order);
            return ResultUtil.success("订餐成功");
        }else {
            return ResultUtil.error("订餐失败，" + DateFormat.getDateInstance().format(order.getDate()) + "已订餐");
        }

    }
    @RequestMapping(value = "/findOrderByUsername", method = RequestMethod.POST)
    @ApiOperation(value = "按姓名查询订餐信息")
    public List<Order> getByStaffIDAndDate(String nickname){
        List<String> userIds = userService.findIdByNickname(nickname);
        return orderService.findByStaffID(userIds);
    }
}
