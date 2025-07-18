package com.cqcskj.blog.rs;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResultDeal<T> {
    private Integer code;
    private String message;
    private T data;
    public static <E> ResultDeal<E> success(E data){
        return  new ResultDeal<>(700,"成功",data);
    }
    public static ResultDeal success(){
        //noinspection rawtypes
        return new ResultDeal(700,"成功",null);
    }
    public static ResultDeal error(String message){
        return new ResultDeal(701,message,"失败");
    }
    public static ResultDeal success(String message,String data){
        return new ResultDeal(700,message,data);
    }
    public static <A> ResultDeal<A> customize(Integer code,String message,A data){
        return new ResultDeal<>(code,message,data);
    }
}
