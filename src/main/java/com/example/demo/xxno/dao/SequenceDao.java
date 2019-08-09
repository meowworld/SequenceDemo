package com.example.demo.xxno.dao;


import org.springframework.stereotype.Repository;

@Repository
public interface SequenceDao {

    String nextNo();

}
