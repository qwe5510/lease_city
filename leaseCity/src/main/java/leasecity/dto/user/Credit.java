package leasecity.dto.user;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Credit implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 평가 하는 유저. */
	private String sendUserId;

	/** 평가 받는 유저. */
	private String acceptUserId;

	/** 평가점수. */
	private Double evaluation;
}
