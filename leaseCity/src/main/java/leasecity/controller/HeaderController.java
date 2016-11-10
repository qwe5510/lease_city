package leasecity.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HeaderController {
	
	static Logger logger = LoggerFactory.getLogger(ConvenienceController.class);
	
	
	
	@RequestMapping(value="/totalSearch", method=RequestMethod.GET)
	public String totalSearch(RedirectAttributes redir,
			@RequestParam String serviceKind,
			@RequestParam String keyword) throws UnsupportedEncodingException{

		//URL링크에 들어갈 수 있게 인코딩
		keyword = URLEncoder.encode(keyword, "UTF-8");
		
		if(serviceKind.equals("LEASE")){ // 임대
			return "redirect:/leaseCall?search=TITLE&keyword=" + keyword;
		}else if(serviceKind.equals("COMMUNITY")){ //커뮤니티
			return "redirect:board?search?search=TITLE&keyword=" + keyword;
		}else if(serviceKind.equals("Q_AND_A")){ // Q&A
			return "redirect:/help/qna?search=TITLE&keyword=" + keyword;
		}else if(serviceKind.equals("HE_SELECT")){ //중기업체 조회
			return "redirect:/lookupHeavy?search=COMPANY_NAME&keyword=" + keyword;			
		}else{
			redir.addFlashAttribute("index_message", "총괄검색에 문제가 발생하였습니다.\\n메인 페이지로 이동합니다.");
		}
		return "redirect:/index";
	}
	
	
	
	
	

}
