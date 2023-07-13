#include<iostream>
#include<string>
using namespace std;

struct sanpham {
	string Masp, Tensp;
	int Soluong;
	double Dongia, Tiengiam, Thanhtien;
}; 

struct phieunhap {
	string Tenncc;
	int ngay, thang, nam, Sosp;
	double Sotiendatt, Sotienphaitt, Tonggiam;
	sanpham *Dssanpham;
};

struct dsphieunhap {
	int Soluongphieu;
	phieunhap *Dsphieunhap;
};

void nhapSanPham(sanpham &sp) {
	cout<<"\t\tMa so san pham: "; cin>>sp.Masp; cout<<endl;
	cout<<"\t\tTen San Pham: "; cin.ignore(); getline(cin, sp.Tensp); cout<<endl;
	cout<<"\t\tSo luong: "; cin>>sp.Soluong; cout<<endl;
	cout<<"\t\tDon gia nhap: "; cin>>sp.Dongia; cout<<endl;
	
	sp.Thanhtien = sp.Soluong*sp.Dongia;
	
	if(sp.Soluong < 10) sp.Tiengiam = 0;
	else if(sp.Soluong < 50) sp.Tiengiam = sp.Thanhtien*0.01;
	else if(sp.Soluong < 100) sp.Tiengiam = sp.Thanhtien*0.02;
	else if(sp.Soluong < 200) sp.Tiengiam = sp.Thanhtien*0.025;
	else if(sp.Soluong < 500) sp.Tiengiam = sp.Thanhtien*0.03;
}

void nhapPhieuNhap(phieunhap &pn) {
	cout<<"\tTen nha cung cap: "; cin.ignore(); getline(cin, pn.Tenncc); cout<<endl;
	cout<<"\tNgay: "; cin>>pn.ngay; cout<<endl;
	cout<<"\tThang: "; cin>>pn.thang; cout<<endl;
	cout<<"\tNam: "; cin>>pn.nam; cout<<endl;
	cout<<"\tSo San Pham: "; cin>>pn.Sosp; cout<<endl;
	cout<<"\tNhap ds san pham: "<<endl;
	pn.Dssanpham = new sanpham[pn.Sosp];
	pn.Sotienphaitt = 0;
	pn.Tonggiam = 0;
	for(int i=0; i<pn.Sosp; i++) {
		cout<<"\tSan Pham "<<i+1<<endl;
		nhapSanPham(pn.Dssanpham[i]);
		pn.Sotienphaitt += pn.Dssanpham[i].Thanhtien;
		pn.Tonggiam += pn.Dssanpham[i].Tiengiam;
	}
	cout<<"\tSo tien da Thanh toan: ";cin>>pn.Sotiendatt; cout<<endl;
}

void nhapDsPhieuNhap(dsphieunhap &ds) {
	ds.Dsphieunhap = new phieunhap[ds.Soluongphieu];
	for(int i=0; i<ds.Soluongphieu; i++) {
		cout<<"Nhap thong tin Phieu Nhap "<<i+1<<":"<<endl;
		nhapPhieuNhap(ds.Dsphieunhap[i]);
	}
	cout<<endl;
}

void inThongTinPN(phieunhap pn) {
	cout<<"\tTen Nha Cung cap: "<<pn.Tenncc<<endl;
	cout<<"\tNgay thu: Ngay "<<pn.ngay<<" thang "<<pn.thang<<" nam "<<pn.nam<<endl;
	cout<<"\tSo San Pham: "<<pn.Sosp<<endl;
	cout<<"\tTong da Thanh toan: "<<pn.Sotiendatt<<endl;
	cout<<"\tTong phai thanh toan: "<<pn.Sotienphaitt<<endl;
	cout<<"\ttong tien giam: "<<pn.Tonggiam<<endl;
	cout<<"Thanh toan thua: "<<pn.Sotiendatt-pn.Sotienphaitt+pn.Tonggiam<<endl;
	cout<<"\tChi tiet cac san pham: "<<endl;
	cout<<"\tMasp"<<"\tTensSanPham"<<"\tDongia"<<"\tSoluong"<<"\t\tThanhtien"<<"\tGiam"<<endl;
	for(int i=0; i<pn.Sosp; i++) {
		cout<<"\t"<<pn.Dssanpham[i].Masp<<"\t"
		<<pn.Dssanpham[i].Tensp<<"\t\t"
		<<pn.Dssanpham[i].Dongia<<"\t"
		<<pn.Dssanpham[i].Soluong<<"\t\t"
		<<pn.Dssanpham[i].Thanhtien<<"\t\t"
		<<pn.Dssanpham[i].Tiengiam<<endl;
	}
	cout<<endl;
}

void inDsPhieuNhap(dsphieunhap ds) {
	for(int i=0; i<ds.Soluongphieu; i++) {
		inThongTinPN(ds.Dsphieunhap[i]);
	}
}

int main() {
	int luachon;
	dsphieunhap ds;
	cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
	cout<<"Nhap so Phieu Nhap: "; cin>>ds.Soluongphieu; cout<<endl;
	do {
		cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
		cout<<"**   CHUONG TRINH QUAN LY Nha CC   **"<<endl;
		cout<<"**1. Nhap Nha CC Phieu Nhap        **"<<endl;
		cout<<"**2. IN KET QUA PHIEU Phieu Nhap   **"<<endl;
		cout<<"**0. Thoat                         **"<<endl;
		cout<<"*************************************"<<endl;
		cout<<"**      Nhap lua chon cua ban      **"<<endl;
		cin>>luachon;
		switch(luachon) {
			case 1: {
				cout<<"Ban da chon nhap ds Phieu Nhap SP!"<<endl;
				nhapDsPhieuNhap(ds);
				cout<<"Ban da nhap thanh cong!"<<endl;
				cout<<endl;
				break;
			}
			case 2: {
				cout<<"Ban da chon xuat Phieu Nhap!"<<endl;
				inDsPhieuNhap(ds);
				break;
			}
			case 0: break;
			default: {
				cout<<"Lua chon khong hop le, vui long nhap lai."<<endl;
				break;
			}
		}
	}
	while(luachon != 0);
	return 0;
}

