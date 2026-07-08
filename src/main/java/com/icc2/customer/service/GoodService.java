package com.icc2.customer.service;

import com.icc2.customer.domain.mapper.GoodMapper;
import com.icc2.search.domain.model.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GoodService {

    @Autowired
    private GoodMapper goodMapper;

    public List<SearchDTO> getLikedProds(int cust_id, int page, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("cust_id", cust_id);
        params.put("limit", pageSize);
        params.put("offset", (page - 1) * pageSize);
        return goodMapper.getLikedProds(params);
    }

    public int getLikedProdsCount(int cust_id) {
        return goodMapper.getLikedProdsCount(cust_id);
    }

    public String findGood(String userId, int prodId) {
        Map<String, Object> params = new HashMap<>();
        params.put("custId", userId);
        params.put("prodId", prodId);
        return goodMapper.findGood(params);
    }

    @Transactional
    public void addGood(String userId, int prodId) {
        Map<String, Object> params = new HashMap<>();
        params.put("custId", userId);
        params.put("prodId", prodId);
        goodMapper.addGood(params);
    }
}
