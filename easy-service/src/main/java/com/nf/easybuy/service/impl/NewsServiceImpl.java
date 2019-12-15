package com.nf.easybuy.service.impl;

import com.nf.easybuy.domain.News;
import com.nf.easybuy.mapper.NewsMapper;
import com.nf.easybuy.service.NewsService;
import com.nf.easybuy.utils.PagingUtil;

import java.util.List;

public class NewsServiceImpl implements NewsService {
	private NewsMapper newsMapper;

	public void setNewsMapper(NewsMapper newsMapper) {
		this.newsMapper = newsMapper;
	}

	@Override
	public List<News> getNewsByTop5() {
		return newsMapper.getNewsByTop5();
	}
	public List<News> getNewsByLimit(PagingUtil<News> pageNews) {
		return newsMapper.getNewsByLimt(pageNews.getStart(),pageNews.getRows());
	}
	public int getNewsCount() {
		return newsMapper.getNewsCount();
	}

	public News getNewsById(int id) {
		return newsMapper.getNewsById(id);
	}
}
