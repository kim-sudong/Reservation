package com.hotel.book.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.book.DTO.LalistDTO;
import com.hotel.book.DTO.RoomDTO;
import com.hotel.book.DTO.RoomTDTO;
import com.hotel.book.DTO.TypeDTO;


@Mapper
public interface HotelDAO {
	ArrayList<TypeDTO> getType();
	void insertRoom(String a,int b,int c, int d);
	ArrayList<RoomDTO> getRoom();
	void delRoom(int a);
	void upRoom(String a,int b,int c,int d,int e);
	int sum();
	ArrayList<RoomDTO> getRoomlist(String a);
	void insertlalist(int a,int b,int c,String d,String e,String f,String g);
	ArrayList<LalistDTO> getLalist();
	int id(String a);
	RoomTDTO RoomT(int a);
	void updatelalist(int a,int b,int c,String d,String e,String f,String g,int t);
	void dellalist(int a);
}
