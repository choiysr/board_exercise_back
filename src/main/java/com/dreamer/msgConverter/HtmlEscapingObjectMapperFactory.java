package com.dreamer.msgConverter;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.FactoryBean;
import com.fasterxml.jackson.core.SerializableString;
import com.fasterxml.jackson.core.io.CharacterEscapes;
import com.fasterxml.jackson.core.io.SerializedString;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@Log4j
public class HtmlEscapingObjectMapperFactory implements FactoryBean {

	private final ObjectMapper objectMapper;
	public HtmlEscapingObjectMapperFactory() {
		log.info("BEAN FACTORY TEST!!!!!!!!!!!!!!!!!");
		objectMapper = new ObjectMapper();
		objectMapper.getFactory().setCharacterEscapes(new HTMLCharacterEscapes());
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	}

	@Override
	public ObjectMapper getObject() throws Exception {
		return objectMapper;
	}

	@Override
	public Class<?> getObjectType() {
		return ObjectMapper.class;
	}

	@Override
	public boolean isSingleton() {
		return true;
	}

	public static class HTMLCharacterEscapes extends CharacterEscapes {
		private final int[] asciiEscapes;
		public HTMLCharacterEscapes() {
			// start with set of characters known to require escaping (double-quote,
			// backslash etc)
			asciiEscapes = CharacterEscapes.standardAsciiEscapesForJSON();

			// and force escaping of a few others:
			asciiEscapes['<'] = CharacterEscapes.ESCAPE_CUSTOM;
			asciiEscapes['>'] = CharacterEscapes.ESCAPE_CUSTOM;
			asciiEscapes['&'] = CharacterEscapes.ESCAPE_CUSTOM;
			asciiEscapes['"'] = CharacterEscapes.ESCAPE_CUSTOM;
			asciiEscapes['\''] = CharacterEscapes.ESCAPE_CUSTOM;
		}

		@Override
		public int[] getEscapeCodesForAscii() {
			return asciiEscapes;
		}

		// and this for others; we don't need anything special here
		@Override
		public SerializableString getEscapeSequence(int ch) {
			return new SerializedString(StringEscapeUtils.escapeHtml4(Character.toString((char) ch)));
		}
	}
}