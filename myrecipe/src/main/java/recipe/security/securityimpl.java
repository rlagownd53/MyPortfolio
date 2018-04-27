package recipe.security;

import java.security.MessageDigest;

import org.springframework.stereotype.Repository;
@Repository("sec")
public class securityimpl {
	// 암호화
	public String ChangePw(String pw) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			digest.update(pw.getBytes("UTF-8"));
			byte[] hash = digest.digest();
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}
			return hexString.toString(); 
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
	}
}
