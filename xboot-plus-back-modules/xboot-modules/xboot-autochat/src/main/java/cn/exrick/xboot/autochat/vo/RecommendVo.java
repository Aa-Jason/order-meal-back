package cn.exrick.xboot.autochat.vo;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class RecommendVo<T> {

    String code = "recommend";

    T data;
}
