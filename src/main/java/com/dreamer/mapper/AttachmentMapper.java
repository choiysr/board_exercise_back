package com.dreamer.mapper;

import java.util.List;

import com.dreamer.domain.AttachmentVO;

public interface AttachmentMapper {
	
	public void insertAttachments(AttachmentVO attachedList);
	
	public List<AttachmentVO> selectAttachmentsByBno(Integer bno);
	
	public Integer getCurrentBno();
	
	public void deleteAttachments(Integer bno);
	
	public String getOriginalFileName(String wholeFileName);

}
