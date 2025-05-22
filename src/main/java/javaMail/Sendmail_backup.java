package javaMail;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class Sendmail_backup {
	private final String account = "kenny199611081158@gmail.com";
	private final String password = "wvum xayu fhwx cagi";
	
	private String host = "smtp.gmail.com";
	private int port = 587;
	
	private String message;
	
	private String setMessagebranch(String branch) {
		String meg;
		switch (branch) {
			case "永和仁愛店":
				meg = "<br><br><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">門市資訊：</p>"
				+ "<div class=\"col\"><div class=\"card bg-dark text-white h-100\">"
				+ "<div class=\"card-body\"><p class=\"card-text\">"
				+ "地址：234009新北市永和區仁愛路162號<br>電話：02-29256062<br>營業時間：11:30 - 20:30</p><div class=\"ratio ratio-4x3\">"
				+ "<p>門市地圖：<a href=\"https://www.google.com/maps/place/Farina+Pizza+%E6%B3%95%E9%87%8C%E5%A8%9C%E6%8A%AB%E8%96%A9+%E6%B0%B8%E5%92%8C%E4%BB%81%E6%84%9B%E5%BA%97/@25.0128809,121.5078715,17z/data=!3m1!4b1!4m6!3m5!1s0x3442a96d5f00e0c3:0x29ca324eeb16de11!8m2!3d25.0128761!4d121.5104464!16s%2Fg%2F11s4wcftfc?entry=ttu&g_ep=EgoyMDI1MDUxMy4xIKXMDSoJLDEwMjExNDUzSAFQAw%3D%3D\" target=\"_blank\">請點擊此處</a></p>"
				+ "<a href=\"https://www.google.com/maps/place/Farina+Pizza+%E6%B3%95%E9%87%8C%E5%A8%9C%E6%8A%AB%E8%96%A9+%E6%B0%B8%E5%92%8C%E4%BB%81%E6%84%9B%E5%BA%97/@25.0128809,121.5078715,17z/data=!3m1!4b1!4m6!3m5!1s0x3442a96d5f00e0c3:0x29ca324eeb16de11!8m2!3d25.0128761!4d121.5104464!16s%2Fg%2F11s4wcftfc?entry=ttu&g_ep=EgoyMDI1MDUxMy4xIKXMDSoJLDEwMjExNDUzSAFQAw%3D%3D\" target=\"_blank\">"
				+ "<img src=\"https://lh3.googleusercontent.com/gps-cs-s/AC9h4nq0oaqrPv4__ykjjYH4LLNhA3qJdcG2i4x0VVhzeMil7dOmWGvVKsvtqhPTiMtol2jFHmIrPZXBtegYuaH-pEN3TtrEP18sVLCDL5ILE1KqIQDfysYw_aSLvGhkr_AjN__-heMM=w203-h152-k-no\" alt=\"地圖\" style=\"border: 2px solid #333; border-radius: 5px;\"></a>"
				+ "</div></div></div></div>";
				break;
			default:
				meg = "<br><br><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">門市資訊：</p>"
				+ "<div class=\"col\"><div class=\"card bg-dark text-white h-100\">"
				+ "<div class=\"card-body\"><p class=\"card-text\">"
				+ "地址：235605新北市中和區中安街54號<br>電話：02-29290062<br>營業時間：11:30 - 20:30</p><div class=\"ratio ratio-4x3\">"
				+ "<p>門市地圖：<a href=\"https://www.google.com/maps/place/Farina+Pizza+%E6%B3%95%E9%87%8C%E5%A8%9C%E6%8A%AB%E8%96%A9+%E5%9B%9B%E8%99%9F%E5%85%AC%E5%9C%92%E5%BA%97/@25.002492,121.5100621,17z/data=!3m1!4b1!4m6!3m5!1s0x3442a9622a57e3d9:0xe7169ad26af7de7!8m2!3d25.0024872!4d121.512637!16s%2Fg%2F11k4k2tp27?entry=ttu&g_ep=EgoyMDI1MDUxMy4xIKXMDSoJLDEwMjExNDUzSAFQAw%3D%3D\" target=\"_blank\">請點擊此處</a></p>"
				+ "<a href=\"https://www.google.com/maps/place/Farina+Pizza+%E6%B3%95%E9%87%8C%E5%A8%9C%E6%8A%AB%E8%96%A9+%E5%9B%9B%E8%99%9F%E5%85%AC%E5%9C%92%E5%BA%97/@25.002492,121.5100621,17z/data=!3m1!4b1!4m6!3m5!1s0x3442a9622a57e3d9:0xe7169ad26af7de7!8m2!3d25.0024872!4d121.512637!16s%2Fg%2F11k4k2tp27?entry=ttu&g_ep=EgoyMDI1MDUxMy4xIKXMDSoJLDEwMjExNDUzSAFQAw%3D%3D\" target=\"_blank\">"
				+ "<img src=\"https://lh3.googleusercontent.com/gps-cs-s/AC9h4noKImkhdQ0Ga6MC6iSODRLzZgLlLfgBwHWsYoxSpMXEjrjRT0w2j5npYHN9yTk1b5ekP8Rvwf61knmKYdxZKGvs0k0VriLQ9qpq6ZuM2jYL-rAT0nowB8f5ybtBAcZJnnZ6HP2vzw=w203-h152-k-no\" alt=\"地圖\" style=\"border: 2px solid #333; border-radius: 5px;\"></a>"
				+ "</div></div></div></div>";
				break;
		}
		return meg;
		
	}
	
	public void setMessage(int num) {
		this.message = "<p><b>驗證碼：</b></p><p><span style=\"font-size:24px; color:#000000; font-weight:bold; font-family:Arial;\">" + num + "</span></p>";
	}
	
	public void setMessage(String name, String email, String branch, String date, String time, String people, String note) {
		this.message = "<p style=\"font-size:15px; color:#000000; font-weight:bold; font-family:Arial;\">您已成功訂位!訂位資訊如下：</p>"
				+"<p style=\"color:#9F5000;\"><b>Farina Pizza：</b></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">貴賓："
				+ "<span style=\"color:#750000;\">"+name
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">E-mail："
				+ "<span style=\"color:#750000;\">"+email
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">餐廳門市："
				+ "<span style=\"color:#750000;\">"+branch
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">日期："
				+ "<span style=\"color:#750000;\">"+date
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">時間："
				+ "<span style=\"color:#750000;\">"+time
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">人數："
				+ "<span style=\"color:#750000;\">"+people
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">備註："
				+ "<span style=\"color:#750000;\">"+note
				+"</span></p></p><p style=\"font-size:12px; color:red; font-weight:bold; font-family:Arial;\">餐廳訂位只保留10分鐘，請貴賓們準時抵達，謝謝~"
				+ setMessagebranch(branch);
	}
     
	public String send( String email, String str ) {
		
		String result = "";
		Properties props = new Properties();
		props.put("mail.smtp.host",host);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		try {
			Session s = Session.getInstance(props,new Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(account,password);
				}
			});
			
		 	MimeMessage msg= new MimeMessage(s);
		 	
		 	msg.setFrom(new InternetAddress(account, "Farina Pizza"));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			msg.setSubject(str);
			msg.setSentDate(new Date());
			
		 	MimeBodyPart htmlPart = new MimeBodyPart();
			htmlPart.setContent(message,"text/html;charset=UTF-8");
			
			Multipart multiPart = new MimeMultipart();	
			multiPart.addBodyPart(htmlPart);
			
			msg.setContent(multiPart); 
			
			Transport.send(msg); 
			
			result = "success";
		}
		catch ( Exception e ) {
			result = "error：" + e.getMessage();
	        e.printStackTrace();
		}
		return result;
	}	
}
