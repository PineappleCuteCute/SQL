#include<iostream>
#include<string>
using namespace std;

struct monhoc {
	string maMH, Ketquamh;
	int Sotinchi;
	double Diemqt, Diemck, Trongsock, Diemmh;
};

struct sinhvien {
	string Masv, Hotensv, Gioitinh, Xeploai;
	int Somonhoc;
	double Diemcpa;
	monhoc *DSmonhoc;
};

struct dssinhvien {
	int Sosinhvien;
	sinhvien *DSsinhvien;
};

void nhapMonHoc(monhoc &mh) {
	cout<<"\tNhap ma MH: "; cin>>mh.maMH;
	cout<<"\tNhap so tin chi: "; cin>>mh.Sotinchi;
	cout<<"\tNhap trong so CK:>0, <1: "; cin>>mh.Trongsock;
	cout<<"\tNhap diem QT: "; cin>>mh.Diemqt;
	cout<<"\tNhap diem CK: "; cin>>mh.Diemck;
	mh.Diemmh=mh.Diemck*mh.Trongsock+mh.Diemqt*(1-mh.Trongsock);
	if(mh.Diemmh >= 5) mh.Ketquamh = "dat yeu cau";
	else mh.Ketquamh = "hoc lai";
}

void nhapSinhVien(sinhvien &sv) {
	cout<<"Nhap ten SV: "; cin.ignore(); getline(cin, sv.Hotensv);
	cout<<"Nhap gioi tinh: "; cin>>sv.Gioitinh;
	cout<<"Nhap so mon hoc: "; cin>>sv.Somonhoc;
	cout<<endl;
	sv.DSmonhoc = new monhoc[sv.Somonhoc];
	for(int i=0; i<sv.Somonhoc; i++){
		cout<<"Nhap mon hoc thu "<<i+1<<endl;
		nhapMonHoc(sv.DSmonhoc[i]);
	}
	double sum=0, count=0;
	for(int i=0; i<sv.Somonhoc; i++){
		sum+=sv.DSmonhoc[i].Diemmh*sv.DSmonhoc[i].Sotinchi;
		count+=sv.DSmonhoc[i].Sotinchi;
	}
	sv.Diemcpa = sum/count;
	cout<<endl;
	
	if(sv.Diemcpa >= 9) sv.Xeploai = "A+";
	else if(sv.Diemcpa >= 8.5) sv.Xeploai = "A";
	else if(sv.Diemcpa >= 7.5) sv.Xeploai = "B+";
	else if(sv.Diemcpa >= 6.5) sv.Xeploai = "B";
	else if(sv.Diemcpa >= 5) sv.Xeploai = "C";
	else if(sv.Diemcpa >= 4) sv.Xeploai = "D";
	else sv.Xeploai = "F";
}

void nhapDsSinhVien(dssinhvien &ds) {
	ds.DSsinhvien = new sinhvien[ds.Sosinhvien];
	for(int i=0; i<ds.Sosinhvien; i++){
		cout<<"Nhap thong tin cua sinh vien thu "<<i+1<<":"<<endl;
		nhapSinhVien(ds.DSsinhvien[i]);
	}
}

void inThongTinSinhVien(sinhvien sv){
	cout<<"\tTen sinh vien: "<<sv.Hotensv<<endl;
	cout<<"\tGioi tinh: "<<sv.Gioitinh<<endl;
	cout<<"\tSo mon hoc: "<<sv.Somonhoc<<endl;
	cout<<"\tKet qua hoc tap cac mon: "<<endl;
	cout<<"\tMamonhoc"<<"\tSotinchi"<<"\tTrongso"<<"\t\tDiemQT"<<"\t\tDiemCK"<<"\t\tDiem MH"<<"\t\tKetqua MH"<<endl;
	for(int i=0; i<sv.Somonhoc; i++){
		cout<<"\t"<<sv.DSmonhoc[i].maMH<<"\t\t"<<sv.DSmonhoc[i].Sotinchi<<"\t\t"
		<<sv.DSmonhoc[i].Trongsock<<"\t\t"<<sv.DSmonhoc[i].Diemqt<<"\t\t"
		<<sv.DSmonhoc[i].Diemck<<"\t\t"<<sv.DSmonhoc[i].Diemmh<<"\t\t"
		<<sv.DSmonhoc[i].Ketquamh<<endl;
	}
	cout<<"Diem CPA: "<<sv.Diemcpa<<endl;;
	cout<<"Xep loai: "<<sv.Xeploai<<endl;
	cout<<endl;
}

void inDsSinhVien(dssinhvien ds) {
	for(int i=0; i<ds.Sosinhvien; i++){
		inThongTinSinhVien(ds.DSsinhvien[i]);
	}
}

int main(){
	int luachon;
	dssinhvien ds;
	cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
	cout<<"Nhap so luong sinh vien: "; cin>>ds.Sosinhvien;
	cout<<endl;
	do {
		cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
		cout<<"**   CHUONG TRINH QUAN LY SINH VIEN   **"<<endl;
		cout<<"**1. Nhap cac SINH VIEN               **"<<endl;
		cout<<"**2. In THONG TIN SV, KET QUA,..      **"<<endl;
		cout<<"**0. Thoat                            **"<<endl;
		cout<<"****************************************"<<endl;
		cout<<"**       Nhap lua chon cua ban        **"<<endl;
		cin>>luachon;
		switch(luachon){
			case 1: {
				cout<<"Ban da chon nhap ds SINH VIEN!"<<endl;
				nhapDsSinhVien(ds);
				break;
			}
			case 2: {
				cout<<"Ban da chon xuat ds SINH VIEN!"<<endl;
				inDsSinhVien(ds);
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

