#include<iostream>
#include<string>
using namespace std;

struct nhanvien {
	string Manv, Tennv, Chucdanh;
	int Namsinh;
	double Hesoluong, Luong, PCCV, Tongluong, Congdoanphi, Connhan;
};

struct phongban {
	string Ten, Diachi;
	int Soluongnv;
	double Luongtoithieu, Tongluongpb, Tongcbphi;
	nhanvien *Dsnhanvien;
};

struct dsphongban{
	int Sophongban;
	phongban *Dsphongban;
};

void nhapNhanVien(nhanvien &nv) {
	cout<<"\t\tMaNV: "; cin>>nv.Manv; cout<<endl;
	cout<<"\t\tHo ten Nhan vien: "; cin.ignore(); getline(cin, nv.Tennv); cout<<endl;
	cout<<"\tNhap Nam sinh: "; cin>>nv.Namsinh; 
	cout<<"\t\tNhap HS Luong: "; cin>>nv.Hesoluong; cout<<endl;
	cout<<"\t\tNhap chuc danh: "; cin>>nv.Chucdanh; cout<<endl;
	if(nv.Chucdanh == "GVCC") nv.PCCV = 2000;
	if(nv.Chucdanh == "GVC") nv.PCCV = 1500;
	if(nv.Chucdanh == "GV") nv.PCCV = 1000;
	if(nv.Chucdanh == "CBKT") nv.PCCV = 750;
	if(nv.Chucdanh == "CBHC") nv.PCCV = 500;
	cout<<endl;
}

void nhapPhongBan(phongban &pb) {
	cout<<"\tTen phong ban: "; cin>>pb.Ten; cout<<endl;
	cout<<"\tDia chi: "; cin>>pb.Diachi; cout<<endl;
	cout<<"\tLuong toi thieu: "; cin>>pb.Luongtoithieu; cout<<endl;
	cout<<"\tSo nhan vien: "; cin>>pb.Soluongnv; cout<<endl;
	cout<<"\tNhap ds Nhan vien: "<<endl;
	
	pb.Dsnhanvien = new nhanvien[pb.Soluongnv];
	pb.Tongluongpb = 0;
	pb.Tongcbphi = 0;
	for(int i=0; i<pb.Soluongnv; i++) {
		cout<<"\tNhan vien thu "<<i+1<<endl;
		nhapNhanVien(pb.Dsnhanvien[i]);
		pb.Dsnhanvien[i].Luong = pb.Dsnhanvien[i].Hesoluong*pb.Luongtoithieu;
		pb.Tongluongpb += pb.Dsnhanvien[i].Luong; 
		pb.Dsnhanvien[i].Tongluong = pb.Dsnhanvien[i].Luong + pb.Dsnhanvien[i].PCCV;
		pb.Dsnhanvien[i].Congdoanphi = 0.01*pb.Dsnhanvien[i].Tongluong;
		pb.Tongcbphi += pb.Dsnhanvien[i].Congdoanphi;
		pb.Dsnhanvien[i].Connhan = pb.Dsnhanvien[i].Luong - pb.Dsnhanvien[i].Congdoanphi; 
	}
}

void nhapDsPhongBan(dsphongban &ds) {
	ds.Dsphongban = new phongban[ds.Sophongban];
	for(int i=0; i<ds.Sophongban; i++) {
		cout<<"Nhap thong tin phong ban thu "<<i+1<<":"<<endl;
		nhapPhongBan(ds.Dsphongban[i]);
	}
}

void inPhongBan(phongban pb) {
	cout<<"\tTen phong ban: "<<pb.Ten<<endl;
	cout<<"\tDia chi: "<<pb.Diachi<<endl;
	cout<<"\tLuong TT: "<<pb.Luongtoithieu<<endl;
	cout<<"\tTong luong PB: "<<pb.Tongluongpb<<endl;
	cout<<"\tTong CD Phi: "<<pb.Tongcbphi<<endl;
	cout<<"\tBang Luong Nhan vien: "<<endl;
	cout<<"\tMaNV"<<"\tHotenNV"<<"\t\tChucdanh"<<"\tPCCV"<<"\tHesoluong"<<"\tLuong"<<"\tCDP"<<"\tConnhan"<<endl;
	for(int i=0; i<pb.Soluongnv; i++) {
		cout<<"\t"<<pb.Dsnhanvien[i].Manv<<"\t"
		<<pb.Dsnhanvien[i].Tennv<<"\t"<<pb.Dsnhanvien[i].Chucdanh<<"\t\t"
		<<pb.Dsnhanvien[i].PCCV<<"\t\t"<<pb.Dsnhanvien[i].Hesoluong<<"\t"
		<<pb.Dsnhanvien[i].Luong<<"\t"<<pb.Dsnhanvien[i].Congdoanphi<<"\t"
		<<pb.Dsnhanvien[i].Connhan<<endl;
	}
	cout<<endl;
}

void inDsPhongBan(dsphongban ds) {
	for(int i=0; i<ds.Sophongban; i++) {
		inPhongBan(ds.Dsphongban[i]);
	}
}

int main() {
	int luachon;
	dsphongban ds;
	cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
	cout<<"Nhap so phong ban: "; cin>>ds.Sophongban;
	cout<<endl;
	do {
		cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
		cout<<"**   CHUONG TRINH QUAN LY Phong Ban - Nhan vien   **"<<endl;
		cout<<"**1. Nhap cac Phong ban                           **"<<endl;
		cout<<"**2. In ket qua ds phong ban va nhan vien         **"<<endl;
		cout<<"**0. Thoat                                        **"<<endl;
		cout<<"****************************************************"<<endl;
		cout<<"**             Nhap lua chon cua ban              **"<<endl;
		cin>>luachon;
		cout<<endl;
		switch(luachon) {
			case 1: {
				cout<<"Ban da chon nhap ds phong ban nhan vien!"<<endl;
				nhapDsPhongBan(ds);
				cout<<"Ban da nhap thanh cong!"<<endl;
				cout<<endl;
				break;
			}
			case 2: {
				cout<<"Ban da chon xuat ds phong ban!"<<endl;
				cout<<endl;
				inDsPhongBan(ds);
				break;
			}
			case 0: {
				cout<<"ban da chon thoat chuong trinh!"<<endl;
				break;
			}
			default: {
				cout<<"Lua chon khong hop le, Vui long nhap lai."<<endl;
				break;
			}
		}
	} 
	while(luachon != 0);
	return 0;
}















