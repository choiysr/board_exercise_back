package com.dreamer.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	
	@Select("select now()")
	public String getTimeMySQL();
	
	public String getTimeWithXml();

}
