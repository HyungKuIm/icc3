package com.icc2.customer.domain.mapper;

import com.icc2.search.domain.model.SearchDTO;

import java.util.List;
import java.util.Map;

public interface GoodMapper {
    String findGood(Map<String, Object> params);
    void addGood(Map<String, Object> params);
    List<SearchDTO> getLikedProds(Map<String, Object> params);
    int getLikedProdsCount(int cust_id);
}
