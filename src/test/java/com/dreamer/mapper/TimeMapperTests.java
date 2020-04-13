package com.dreamer.mapper;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.dreamer.loading.LoadingTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class TimeMapperTests extends LoadingTests {
	
	
	@Setter(onMethod_ = {@Autowired})
	TimeMapper tmapper;
	
	@Test
	public void timeMapperTest() {
		log.info(tmapper.getTimeWithXml());
	}

}
