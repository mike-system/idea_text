package com.nf.easybuy.mapper;


import com.nf.easybuy.domain.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsMapper {

	List<News> getNewsByTop5();

	List<News> getNewsByLimt(@Param("start") int start, @Param("rows") Integer rows);

	int getNewsCount();

	News getNewsById(int id);

}