#include<iostream>
#include<string>

using namespace std;

struct monhoc {
	string Mamh, Loaigio;
	int Sotinchi, SotinchiLT, SotinchiTH, SotinchiBT, Khoiluong;
	double SotinchiHP, Sotienhoc;
};

struct sinhvien {
	string Masv, Hotensv;
	int Somonhoc;
	double Tienhoc1tinchiLT, Sotiendanop, Sotienhocphaidong;
	monhoc *DSmonhoc;
};

struct dssinhvien {
	int Sosinhvien;
	sinhvien *DSsinhvien;
};

void nhapMonHoc(monhoc &mh) {
	cout<<"\tMa mon hoc: "; cin>>mh.Mamh;
	cout<<"\t\tSo tin chi: "; cin>>mh.Sotinchi;
	cout<<"\t\tSo tin chi LT: "; cin>>mh.SotinchiLT;
	cout<<"\t\tSo tin chi BT: "; cin>>mh.SotinchiBT;
	cout<<"\t\tSo tin chi TH: "; cin>>mh.SotinchiTH;
	
	mh.SotinchiHP=mh.SotinchiLT + mh.SotinchiBT + mh.SotinchiTH*1.5;
	
	if(mh.SotinchiLT > 0 && mh.SotinchiBT > 0 && mh.SotinchiTH > 0) {
		mh.Loaigio = "LT-BT-TH";
		mh.Khoiluong = mh.SotinchiHP*2;
	}
	if(mh.SotinchiLT > 0 && mh.SotinchiBT > 0 && mh.SotinchiTH == 0) {
		mh.Loaigio = "LT-BT";
		mh.Khoiluong = mh.SotinchiHP*2;
	}
	if(mh.SotinchiLT > 0 && mh.SotinchiBT == 0 && mh.SotinchiTH > 0){
		mh.Loaigio = "LT-TH";
		mh.Khoiluong = mh.SotinchiHP*2;
	}
	if(mh.SotinchiLT == 0 && mh.SotinchiBT == 0 && mh.SotinchiTH == 3){
		mh.Loaigio = "DAMH";
		mh.Khoiluong = mh.SotinchiHP*2;
	}
	if(mh.SotinchiLT == 0 && mh.SotinchiBT == 0 && mh.SotinchiTH == 6){
		mh.Loaigio = "DATN Cu Nhan";
		mh.Khoiluong = mh.SotinchiHP*2;
	}
	if(mh.SotinchiLT == 0 && mh.SotinchiBT == 0 && mh.SotinchiTH == 12){
		mh.Loaigio = "DATN Ky Su";
		mh.Khoiluong = mh.SotinchiHP*2;
	}
}

void nhapSinhVien(sinhvien &hv) {
	cout<<"\tTen sinh vien: ";
	cin.ignore(); getline(cin, hv.Hotensv);
	cout<<"\tSo mon hoc: "; cin>>hv.Somonhoc;
	cout<<"\tSo tien mot tin chi: "; cin>>hv.Tienhoc1tinchiLT;
	hv.DSmonhoc = new monhoc[hv.Somonhoc];
	for(int i=0; i<hv.Somonhoc; i++){
		cout<<"\tMon hoc thu "<<i+1<<endl;
		nhapMonHoc(hv.DSmonhoc[i]);
	} 
	
	cout<<"\tHoc phi da nop: "; cin>>hv.Sotiendanop;
	hv.Sotienhocphaidong=0; 
	for(int i=0; i<hv.Somonhoc; i++) {
		hv.DSmonhoc[i].Sotienhoc = hv.DSmonhoc[i].SotinchiHP*hv.Tienhoc1tinchiLT;
		hv.Sotienhocphaidong += hv.DSmonhoc[i].Sotienhoc;
	}
	cout<<endl;
}

void nhapDsSinhVien(dssinhvien &ds) {
	ds.DSsinhvien = new sinhvien[ds.Sosinhvien];
	for(int i=0; i<ds.Sosinhvien; i++){
		cout<<"Nhap thong tin cua sv thu "<<i+1<<":"<<endl;
		nhapSinhVien(ds.DSsinhvien[i]);
	}
}

void inThongTinSinhVien(sinhvien sv) {
	cout<<"\tTen sinh vien: "<<sv.Hotensv<<endl;
	cout<<"\tSo mon hoc: "<<sv.Somonhoc<<endl;
	cout<<"\tSo tien mot tin chi: "<<sv.Tienhoc1tinchiLT<<endl;
	cout<<"\tSo tien phai nop: "<<sv.Sotienhocphaidong<<endl;
	cout<<"\tDa nop dot 1: "<<sv.Sotiendanop<<endl;
	cout<<"\tTo toi thieu: "<<sv.Sotienhocphaidong-sv.Sotiendanop<<endl;
	if(sv.Sotiendanop>=sv.Sotienhocphaidong){
		cout<<"\tTinh trang nop HP: Da nop het"<<endl;
	}
	else cout<<"\tTinh trang nop HP: Con thieu"<<endl;
	cout<<"\tChi tiet hoc phi cac mon hoc: "<<endl;
	cout<<"\tMa MH"<<"\t\tLoai gio"<<"\t\tKhoi luong"<<"\t\tHoc phi phai nop"<<endl;
	for(int i=0; i<sv.Somonhoc; i++){
		cout<<"\t"<<sv.DSmonhoc[i].Mamh<<"\t\t"
		<<sv.DSmonhoc[i].Loaigio<<"\t\t\t"
		<<sv.DSmonhoc[i].Khoiluong<<"("<<sv.DSmonhoc[i].SotinchiLT<<"-"<<sv.DSmonhoc[i].SotinchiBT
		<<"-"<<sv.DSmonhoc[i].SotinchiTH<<"-"<<sv.DSmonhoc[i].Khoiluong*2<<")"<<"\t\t\t"
		<<sv.DSmonhoc[i].Sotienhoc<<endl;
	}
	cout<<endl;
}

void inDsSinhVien(dssinhvien ds){
	for(int i=0; i<ds.Sosinhvien; i++){
		inThongTinSinhVien(ds.DSsinhvien[i]);
	}
}

int main() {
	int luachon;
	dssinhvien ds;
	cout<<"De2_6_IT3040_20211"<<endl<<endl;
	cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
	cout<<"Nhap so sinh vien: "; cin>>ds.Sosinhvien;
	do {
		cout<<"De2_6_IT3040_20211"<<endl;
		cout<<"Bui Thuc Nam - 20200857 - 721431"<<endl;
		cout<<"**          CHUONG TRINH QUAN LY HOC PHI          **"<<endl;
		cout<<"**1. Nhap cac sinh vien va mon hoc                **"<<endl;
		cout<<"**2. In danh sach sinh vien va hoc phi cac mon    **"<<endl;
		cout<<"**0. Thoat                                        **"<<endl;
		cout<<"****************************************************"<<endl;
		cout<<"**Nhap lua chon cua ban**"<<endl;
		cin>>luachon;
		switch(luachon){
			case 1: {
				cout<<"Ban da chon nhap ds sinh vien!"<<endl;
				nhapDsSinhVien(ds);
				break;
			}
			case 2: {
				cout<<"Ban da chon xuat DS sinh vien!"<<endl;
				inDsSinhVien(ds);
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

