package org.zerock.security;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml" })
@Log4j
public class MemberTests {
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	@Test
	public void testInsertMember() {
		IntStream.range(499900, 500001).forEach(i -> {
			try {
				MemberVO member = new MemberVO();
				String pw = "password";
				member.setEmp_pw(pwencoder.encode(pw));
				member.setEmp_no(Long.valueOf(i));
				memberMapper.insert(member);
			} catch (Exception e) {
				// TODO: handle exception
			}
		});
	}

	@Test
	public void testInsertMemberAuth() {
		IntStream.range(499900, 500001).forEach(i -> {
			try {
				AuthVO auth = new AuthVO();

				auth.setEmp_no(Long.valueOf(i));
				auth.setAuth("ROLE_MEMBER");
				memberMapper.insertAuth(auth);
			} catch (Exception e) {
				// TODO: handle exception
			}
		});
	}

}
