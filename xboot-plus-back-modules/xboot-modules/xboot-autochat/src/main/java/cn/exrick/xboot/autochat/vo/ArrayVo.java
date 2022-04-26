package cn.exrick.xboot.autochat.vo;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ArrayVo<T> {

    T array;
}
