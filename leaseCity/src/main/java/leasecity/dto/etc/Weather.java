package leasecity.dto.etc;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Weather {
	
	private Integer weatherNo;
	 
    private String day;
    
    private String wfKor;
    
    private String tmn;
    
    private String tmx;
    
    private String hour;
    
    private String temp;
    
    private String city;
    
}