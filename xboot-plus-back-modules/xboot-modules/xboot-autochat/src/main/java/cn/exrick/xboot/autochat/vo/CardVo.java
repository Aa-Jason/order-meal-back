package cn.exrick.xboot.autochat.vo;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author exrick
 */
@Data
@Accessors(chain = true)
public class CardVo<T> {

    String code = "knowledge";

    T data;
}
