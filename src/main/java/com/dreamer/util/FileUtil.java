package com.dreamer.util;

import java.io.File;
import java.io.FileOutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
public final class FileUtil {
	
	public static List<Map<String,String>> saveFile(MultipartFile[] files) {
		
		DateTimeFormatter dataForm = DateTimeFormatter.ofPattern("yy\\MM\\dd");
		LocalDate currDate = LocalDate.now();
		String filePath = "\\"+dataForm.format(currDate);
		File targetDir = new File("C:\\upload"+filePath);
		List<Map<String,String>> fileInfoList = new ArrayList<>();
		
		if(!targetDir.exists()) {
			targetDir.mkdirs();
		}
		
		for(MultipartFile file : files) {
			Map<String,String> fileInfo = new HashMap<>();
			try {
				UUID uuid = UUID.randomUUID();
				File saveFile = new File(filePath,uuid.toString()+file.getOriginalFilename());
				file.transferTo(saveFile);
				fileInfo.put("path",filePath);
				fileInfo.put("uuid",uuid.toString());
				fileInfo.put("fileName",file.getOriginalFilename());
				fileInfo.put("image","n");
				// 이미지타입일 경우 썸네일 생성
				if(file.getContentType().startsWith("image")) {
					fileInfo.put("image", "y");
					FileOutputStream thumbnail = new FileOutputStream(new File("C:\\upload"+filePath,"th_"+uuid.toString()+file.getOriginalFilename()));
					Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				fileInfoList.add(fileInfo);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return fileInfoList;
	}
	

	
	
	
//	public static String makePath() {
//		DateTimeFormatter dataForm = DateTimeFormatter.ofPattern("yy\\MM\\dd");
//		LocalDate currDate = LocalDate.now();
//		String filePath = "\\"+dataForm.format(currDate);
//		File targetDir = new File("C:\\upload"+filePath);
//		
//		if(!targetDir.exists()) {
//			targetDir.mkdirs();
//		}
//		
//		System.out.println("파일경로는===:"+filePath);
//		return filePath;
//	}

}
