package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String file_Name, String type) {

		File file;
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(file_Name, "UTF-8"));
			file.delete();
			if (type.equals("image")) {
				String largefile_Name = file.getAbsolutePath().replace("s_", "");
				file = new File(largefile_Name);
				file.delete();
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		return new ResponseEntity<>("delete", HttpStatus.OK);
	}

	// p.531
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String file_Name) {
		log.info("download file : " + file_Name);
		Resource resource = new FileSystemResource("c:\\upload\\" + file_Name);
		log.info("resource : " + resource);

		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String resourceName = resource.getFilename();

		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();
		try {

			String downloadName = "";
			// IE
			if (userAgent.contains("Trident")) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if (userAgent.contains("Edge")) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			headers.add("Content-Disposition", "attachment;filename=" + downloadName);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjax....");
	}

	// REST + Controller = @RestController -> Controller + ResponseBody
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile) {
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "c:\\upload";
		// "c:\\upload\\2020\\11\\14"

		String uploadFolderPath = getFolder();

		File upload_Path = new File("c:\\upload", uploadFolderPath);
		log.info(upload_Path);
		if (upload_Path.exists() == false) {
			upload_Path.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachFileDTO = new AttachFileDTO();
			log.info("------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			String uploadfile_Name = multipartFile.getOriginalFilename();
			// IE
			uploadfile_Name = uploadfile_Name.substring(uploadfile_Name.lastIndexOf("\\") + 1);
			log.info("uploadfile_Name : " + uploadfile_Name);

			attachFileDTO.setFile_Name(uploadfile_Name);

			UUID uuid = UUID.randomUUID();
			uploadfile_Name = uuid.toString() + "_" + uploadfile_Name;

			try {
				attachFileDTO.setUuid(uuid.toString());
				attachFileDTO.setUpload_Path(uploadFolderPath);

				File saveFile = new File(upload_Path, uploadfile_Name);

				multipartFile.transferTo(saveFile);
				// check image type file
				if (checkImageType(saveFile)) {
					attachFileDTO.setImage(true);
					// thumbnail
					FileOutputStream thumbnail = new FileOutputStream(new File(upload_Path, "s_" + uploadfile_Name));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}

				list.add(attachFileDTO);

			} catch (Exception e) {
				// TODO: handle exception
			}

		}

		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload Form");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {

		String uploadFolder = "c:\\upload";

		for (MultipartFile multipartFile : uploadFile) {
			log.info("------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				// TODO: handle exception
			}

		}
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String file_Name) {

		log.info("file_Name : " + file_Name);

		File file = new File("c:\\upload\\" + file_Name);

		log.info("file : " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}

	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (Exception e) {
		}
		return false;
	}

}
