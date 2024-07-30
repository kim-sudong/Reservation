package com.hotel.book.controller;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotel.book.DAO.HotelDAO;
import com.hotel.book.DTO.LalistDTO;
import com.hotel.book.DTO.RoomDTO;
import com.hotel.book.DTO.RoomTDTO;
import com.hotel.book.DTO.TypeDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	@Autowired HotelDAO hdao;
	
	@GetMapping("/")
	public String home() {
		return "room";
	}
	
	@PostMapping("/getType")
	@ResponseBody
	public String getT(HttpServletRequest req) {
		ArrayList<TypeDTO> a = hdao.getType();
		JSONArray Ty = new JSONArray();
		for(TypeDTO Tdto : a) {
			JSONObject T = new JSONObject();
			T.put("id",Tdto.getId());
			T.put("roomname",Tdto.getRoomname());
			
			Ty.put(T);
		}
		return Ty.toString();
	}
	
	@PostMapping("/insertRoom")
	@ResponseBody
	public String insertR(HttpServletRequest req) {
		int type = Integer.parseInt(req.getParameter("id"));
		String name = req.getParameter("name");
		int person = Integer.parseInt(req.getParameter("person"));
		int price = Integer.parseInt(req.getParameter("price"));
		hdao.insertRoom(name,type,person,price);
		System.out.println(name+type+person+price);
		
		return "room";
	}
	
	@PostMapping("/getRoomlist")
	@ResponseBody
	public String getRooml(HttpServletRequest req) {
		ArrayList<RoomDTO> a = hdao.getRoom();
		JSONArray Ty = new JSONArray();
		for(RoomDTO Rdto : a) {
			JSONObject T = new JSONObject();
			T.put("id",Rdto.getId());
			T.put("name",Rdto.getName());
			T.put("type",Rdto.getRoomname());
			T.put("person",Rdto.getPersonnel());
			T.put("price",Rdto.getPrice());
			Ty.put(T);
		}
		return Ty.toString();
	}
	@PostMapping("/delRoom")
	@ResponseBody
	public String delR(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		hdao.delRoom(id);
		System.out.println(id);
		
		return "room";
	}
	
	@PostMapping("/updateRoom")
	@ResponseBody
	public String upR(HttpServletRequest req) {
		String name = req.getParameter("name");
		int id = Integer.parseInt(req.getParameter("id"));
		int price = Integer.parseInt(req.getParameter("price"));
		int person = Integer.parseInt(req.getParameter("person"));
		int list = Integer.parseInt(req.getParameter("list"));
		hdao.upRoom(name,id,person,price,list);
		System.out.println(name+id+price+person+list);
		
		return "room";
	}
	
	@GetMapping("/book")
	public String book() {
		return "book";
	}
	
	@PostMapping("/addlalist")
	@ResponseBody
	public String addlalist(HttpServletRequest req) {
		int roomid= Integer.parseInt(req.getParameter("roomid"));
		String checkin= req.getParameter("checkin");
		String checkout= req.getParameter("checkout");
		String name= req.getParameter("name");
		String mobile= req.getParameter("mobile");
		int price= Integer.parseInt(req.getParameter("price"));
		int person= Integer.parseInt(req.getParameter("person"));
		System.out.println(roomid+checkin+checkout+name+mobile+price+person);
		hdao.insertlalist(roomid,person,price, checkin, checkout, name, mobile);
		return "book";
	}
	@PostMapping("/updatelalist")
	@ResponseBody
	public String updatelalist(HttpServletRequest req) {
		int id= Integer.parseInt(req.getParameter("id"));
		int roomid= Integer.parseInt(req.getParameter("roomid"));
		String checkin= req.getParameter("checkin");
		String checkout= req.getParameter("checkout");
		String name= req.getParameter("name");
		String mobile= req.getParameter("mobile");
		int price= Integer.parseInt(req.getParameter("price"));
		int person= Integer.parseInt(req.getParameter("person"));
		System.out.println("업데이트"+roomid+checkin+checkout+name+mobile+price+person+id);
		hdao.updatelalist(roomid, person, price, checkin, checkout, name, mobile,id);
		return "ok";
	}
	@PostMapping("/dellalist")
	@ResponseBody
	public String dellalist(HttpServletRequest req) {
		int id= Integer.parseInt(req.getParameter("id"));
		hdao.dellalist(id);
		return "book";
	}
	
	@PostMapping("/getRlist")
	@ResponseBody
	public String getRlist(HttpServletRequest req) {
		ArrayList<LalistDTO> a = hdao.getLalist();
		JSONArray Ll = new JSONArray();
		for(LalistDTO Ldto : a) {
			JSONObject T = new JSONObject();
			T.put("id",Ldto.getId());
			T.put("checkin",Ldto.getCheckin());
			T.put("checkout",Ldto.getCheckout());
			T.put("roomname",Ldto.getRoomname());
			T.put("name",Ldto.getName());
			T.put("mobile",Ldto.getMobile());
			T.put("person",Ldto.getHowmany());
			T.put("price",Ldto.getHowmuch());
			Ll.put(T);
			System.out.println(Ldto.getId());
		}
		return Ll.toString();
	}
	
	@PostMapping("/getTlist")
	@ResponseBody
	public String getTlist(HttpServletRequest req) {
		String type= req.getParameter("type");
		System.out.println(type);
		ArrayList<RoomDTO> i = hdao.getRoomlist(type);
		JSONArray Ty = new JSONArray();
		for(RoomDTO Rdto : i) {
			JSONObject T = new JSONObject();
			T.put("name",Rdto.getName());
			T.put("person",Rdto.getPersonnel());
			T.put("price",Rdto.getPrice());
			Ty.put(T);
			System.out.println(Rdto.getName());
		}
		return Ty.toString();
	}
	
	@PostMapping("/getroomid")
	@ResponseBody
	public int getroomid(HttpServletRequest req) {
		String roomname= req.getParameter("roomname");
		int id = hdao.id(roomname);
		return id;
	}
	
	@PostMapping("/RoomT")
	@ResponseBody
	public String RoomT(HttpServletRequest req) {
		int id= Integer.parseInt(req.getParameter("id"));
		RoomTDTO type = hdao.RoomT(id);
		System.out.println("11111111111111111111111"+type.getRoomname());
		return type.getRoomname();
	}
	
}
