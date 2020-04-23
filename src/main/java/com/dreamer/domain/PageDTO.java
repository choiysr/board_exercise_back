package com.dreamer.domain;

import java.util.List;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO<T extends Pageable> {

	private int startPage, endPage, total;
	private boolean prev, next;
	private List<T> list;

	public PageDTO(Criteria criteria, int total, List<T> list) {


		this.total = total;
		this.list = list;

		int realPage = (criteria.getPageRequest() / criteria.getAmount()) + 1;
		this.endPage = (int) (Math.ceil(realPage / new Double(criteria.getAmount())) * 10);
		this.startPage = endPage - 9;

		int realEndPage = (int) Math.ceil((total / (double)criteria.getAmount()));

		if (realEndPage < this.endPage) {
			this.endPage = realEndPage;
		}

		this.prev = startPage > 1;
		this.next = this.endPage < realEndPage;

	}

}
