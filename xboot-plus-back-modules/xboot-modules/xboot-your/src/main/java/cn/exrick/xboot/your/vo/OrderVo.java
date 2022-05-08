package cn.exrick.xboot.your.vo;

import cn.exrick.xboot.your.entity.Order;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
@Data
public class OrderVo implements Serializable {

    @ApiModelProperty(value = "订餐列表")
    List<Order> orders ;

    public OrderVo() {
    }

    public OrderVo(List<Order> orders) {
        this.orders = orders;
    }

    public List<Order> getOrders() {
        return orders;
    }
}
