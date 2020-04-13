package com.dreamer.loading;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.dreamer.mapper.TimeMapper;

import lombok.extern.log4j.Log4j;

@Log4j
public class MySqlConnectTests extends LoadingTests {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private TimeMapper tMapper;
	
	@Test
	public void driverTest() throws Exception {
		// jdbc driver test 
		Class<?> clz = Class.forName("com.mysql.cj.jdbc.Driver");
		log.info(clz);
	}
	
	@Test
	public void connectTest() {
		// db connection test 
		try (Connection conn = dataSource.getConnection()) {
			log.info(conn);
		} catch(Exception e) {
			fail(e.getMessage());
		}
	}
	
	@Test
	public void mapperTest() {
		log.info("mysql Select Test.................");
		log.info(tMapper.getTimeMySQL());
	}

}
