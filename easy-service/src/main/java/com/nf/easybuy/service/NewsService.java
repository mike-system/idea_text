package com.nf.easybuy.service;


import com.nf.easybuy.domain.News;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public interface NewsService {

	List<News> getNewsByTop5();

	List<News> getNewsByLimit(PagingUtil<News> pageNews);

	int getNewsCount();

	News getNewsById(int id);

}