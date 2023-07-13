#include<iostream>
#include<string>
#include<ctime>
using namespace std;

struct dangvien {
	string Tendv, Chucvudang;
	double Luong, Dangphi, Tienphucap, Tienphaidong;
	int Ngayvaodang, Thangvaodang, Namvaodang, Tuoidang, Sothedv;
};

struct chibo {
	string Tencb, Diachi;
	int Sodangvien;
	double Tongluong, Tongdangphithu, Tongtrocap, Chibogiulai, Nopcaptren;
	dangvien *Dsdangvien;
};

struct dschibo {
	int Sochibo;
	chibo *Dschibo;
};

void nhapThongTinDV(dangvien &dv) {
	cout<<"\t\tSo the: "; cin>>dv.Sothedv;
	cout<<"\t\tTen dang vien: "; cin.ignore(); getline(cin, dv.Tendv);
	cout<<"\t\tNgay vao dang: "<<endl;
	cout<<"\t\tNgay: "; cin>>dv.Ngayvaodang;
	cout<<"\t\tThang: "; cin>>dv.Thangvaodang;
	cout<<"\t\tNam: "; cin>>dv.Namvaodang;
	cout<<"\t\tLuong: "; cin>>dv.Luong;
	cout<<"\t\tChuc vu: "; cin>>dv.Chucvudang;
	
	dv.Dangphi = 0.01*dv.Luong;
	
	if(dv.Chucvudang == "BT") dv.Tienphucap = 0.005*dv.Luong;
	else if(dv.Chucvudang == "PBT") dv.Tienphucap = 0.0025*dv.Luong;
	else if(dv.Chucvudang == "UV") dv.Tienphucap = 0.0015*dv.Luong;
	else dv.Tienphucap = 0;
	
	time_t now = time(0);
	tm *ltm = localtime(&now);
	dv.Tuoidang = 1900 + ltm->tm_year - dv.Namvaodang;
	if((ltm->tm_mon + 1) < dv.Thangvaodang || 
	   ((ltm->tm_mon + 1) == dv.Thangvaodang && ltm->tm_mday < dv.Ngayvaodang)) {
		dv.Tuoidang--;
	}
}

void nhapDsDangVien(chibo &cb) {
	cout<<"\tTen chi bo: "; cin>>cb.Tencb;
	cout<<"\tSo dang vien: "; cin>>cb.Sodangvien;
	cout<<"\tNhap ds Dang vien: "<<endl;
	
	cb.Dsdangvien = new dangvien[cb.Sodangvien];
	for(int i=0; i<cb.Sodangvien; i++) {
		cout<<"\tDang vien thu "<<i+1<<":"<<endl;
		nhapThongTinDV(cb.Dsdangvien[i]);
		cb.Tongdangphithu += cb.Dsdangvien[i].Dangphi;
		cb.Tongluong += cb.Dsdangvien[i].Luong;
		cb.Tongtrocap += cb.Dsdangvien[i].Tienphucap;
	}
	cout<<endl;
	
	cb.Tongdangphithu = 0;
	cb.Tongluong = 0;
	cb.Tongtrocap = 0;
	for(int i=0; i<cb.Sodangvien; i++) {
		cb.Tongdangphithu += cb.Dsdangvien[i].Dangphi;
		cb.Tongluong += cb.Dsdangvien[i].Luong;
		cb.Tongtrocap += cb.Dsdangvien[i].Tienphucap;
	}
	cb.Chibogiulai = cb.Tongdangphithu*0.3;
	cb.Nopcaptren = cb.Tongdangphithu*0.7;
}

void nhapDsChiBo(dschibo &ds) {
	ds.Dschibo = new chibo[ds.Sochibo];
	for(int i=0; i<ds.Sochibo; i++){
		cout<<"Nhap thong tin chi bo thu "<<i+1<<endl;
		nhapDsDangVien(ds.Dschibo[i]);
	}
}

void inThongTinCB(chibo cb) {
	cout<<"\tTen chi bo: "<<cb.Tencb<<endl;
	cout<<"\tSo dang vien: "<<cb.Sodangvien<<endl;
	cout<<"\tTong luong: "<<cb.Tongluong<<endl;
	cout<<"\tTong thu Dang phi: "<<cb.Tongdangphithu<<endl;
	cout<<"\tTong nop DP Cap tren: "<<cb.Nopcaptren<<endl;
	cout<<"\tTong tro Cap chuc vu: "<<cb.Tongtrocap<<endl;
	cout<<"\tBang Bang Thu Dang Phi: "<<endl;
	cout<<"\tSothe"<<"\tHotenDV"<<"\t\tNgayvaoDang"<<"\tTuoidang"
	<<"\tChucvu"<<"\tTrocap"<<"\tLuong"<<"\tDangphi"<<endl;
	for(int i=0; i<cb.Sodangvien; i++){
		cout<<"\t"<<cb.Dsdangvien[i].Sothedv<<"\t"
		<<cb.Dsdangvien[i].Tendv<<"\t\t"
		<<cb.Dsdangvien[i].Ngayvaodang<<"-"<<cb.Dsdangvien[i].Thangvaodang<<"-"<<cb.Dsdangvien[i].Namvaodang<<"\t"
		<<cb.Dsdangvien[i].Tuoidang<<"\t\t"
		<<cb.Dsdangvien[i].Chucvudang<<"\t"
		<<cb.Dsdangvien[i].Tienphucap<<"\t"
		<<cb.Dsdangvien[i].Luong<<"\t"
		<<cb.Dsdangvien[i].Dangphi<<endl;
	}
	cout<<endl;
}

void inDsChiBo(dschibo ds) {
	double sumLuong = 0;
	double sumDangPhi = 0;
	double sumNopCapTren = 0;
	for(int i=0; i<ds.Sochibo; i++){
		inThongTinCB(ds.Dschibo[i]);
		sumLuong += ds.Dschibo[i].Tongluong;
		sumDangPhi += ds.Dschibo[i].Tongdangphithu;
		sumNopCapTren += ds.Dschibo[i].Nopcaptren;
	}
	cout<<"Tong Luong cac chi bo: "<<sumLuong<<endl;
	cout<<"Tong dang phi thu duoc: "<<sumDangPhi<<endl;
	cout<<"Tong nop cap tren: "<<sumNopCapTren<<endl;
	cout<<endl;
}

int main() {
	int luachon;
	dschibo ds;
	cout<<"De4_8_IT3040_20211"<<endl;
	cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
	cout<<"Nhap so Chi Bo: "; cin>>ds.Sochibo;
	cout<<endl;
	do {
		cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
		cout<<"**   CHUONG TRINH QUAN LY CHI BO - DANG VIEN   **"<<endl;
		cout<<"**1. Nhap cac Chi bo                           **"<<endl;
		cout<<"**2. In ket qua ds Chi bo Dang vien            **"<<endl;
		cout<<"**0. Thoat                                     **"<<endl;
		cout<<"*************************************************"<<endl;
		cout<<"**            Nhap lua chon cua ban            **"<<endl;
		cin>>luachon;
		switch(luachon) {
			case 1: {
				cout<<"Ban da chon nhap ds Chi bo Dang vien!"<<endl;
				nhapDsChiBo(ds);
				cout<<"Ban da nhap thanh cong!"<<endl<<endl;
				break;
			}
			case 2: {
				cout<<"Ban da chon xuat ds Chi bo Dang vien!"<<endl;
				inDsChiBo(ds);
				break;
			}
			case 0: break;
			default: {
				cout<<"Lua chon khong hop le, vui long nhap lai!"<<endl;
				break;
			}
		}
	}
	while(luachon != 0);
	return 0;
}

