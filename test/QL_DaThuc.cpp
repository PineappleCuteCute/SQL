#include <iostream>
#include <math.h>
#include <string>
using namespace std;

struct hesobac
{
	int heso;
};

struct dathuc
{
	string Tendathuc;
	int bac, Hesotong;
	double x, Giatridt;
	hesobac *heso;
};

struct dsdathuc
{
	int Soluongdt;
	dathuc *Dsdathuc;
};

void nhapHeSoBac(hesobac &hs)
{
	cin >> hs.heso;
	cout << endl;
}

void nhapDaThuc(dathuc &dt)
{
	cout << "Nhap ten da thuc: ";
	cin >> dt.Tendathuc;
	cout << endl;
	cout << "Nhap bac: ";
	cin >> dt.bac;
	cout << endl;
	cout << "Nhap x: ";
	cin >> dt.x;
	cout << endl;
	dt.heso = new hesobac[dt.bac];
	dt.Giatridt = 0;
	for (int i = dt.bac; i >= 0; i--)
	{
		cout << "\tHe so bac " << i << ":";
		nhapHeSoBac(dt.heso[i]);
		dt.Giatridt += dt.heso[i].heso * pow(dt.x, i);
	}
}

void nhapDsDaThuc(dsdathuc &ds)
{
	ds.Dsdathuc = new dathuc[ds.Soluongdt];
	for (int i = 0; i < ds.Soluongdt; i++)
	{
		cout << "Nhap da thuc thu " << i + 1 << ":" << endl;
		nhapDaThuc(ds.Dsdathuc[i]);
	}
}

void inDaThuc(dathuc dt)
{
	cout << "Da thuc: " << dt.Tendathuc << "(x) = ";
	for (int i = dt.bac; i >= 0; i--)
	{
		if (dt.bac == 0 && dt.heso[i].heso == 0)
			cout << "";
		else if (dt.heso[i].heso == 0)
			cout << "";
		else if (i == 0)
		{
			if (dt.heso[i].heso < 0)
				cout << " " << dt.heso[i].heso;
			else
				cout << " + " << dt.heso[i].heso;
		}
		else if (i == dt.bac)
			cout << dt.heso[i].heso << "*x^" << i;
		else if (dt.heso[i].heso == 1 && i == 1)
			cout << " + x";
		else if (dt.heso[i].heso == -1 && i == 1)
			cout << " -x";
		else if (i == 1)
		{
			if (dt.heso[i].heso < 0)
				cout << " " << dt.heso[i].heso << "*x";
			else
				cout << " + " << dt.heso[i].heso << "*x";
		}
		else if (dt.heso[i].heso == 1)
			cout << " + x^" << i;
		else if (dt.heso[i].heso == -1)
			cout << " x^" << i;
		else
		{
			if (dt.heso[i].heso < 0)
				cout << " " << dt.heso[i].heso << "*x^" << i;
			else
				cout << " + " << dt.heso[i].heso << "*x^" << i;
		}
	}
	cout << endl;
	cout << "Gia tri Da thuc: " << dt.Tendathuc << "(" << dt.x << ") = "
		 << dt.Giatridt << endl;
}

void inDsDathuc(dsdathuc ds)
{
	for (int i = 0; i < ds.Soluongdt; i++)
	{
		cout << "Da thuc thu " << i + 1 << ":" << endl;
		inDaThuc(ds.Dsdathuc[i]);
		cout << endl;
	}
	cout << endl;
}

int main()
{
	int luachon;
	dsdathuc ds;
	cout << "Bui Thuc Nam - 20200857 - 721431" << endl;
	cout << "Nhap so luong da thuc: ";
	cin >> ds.Soluongdt;
	cout << endl;
	do
	{
		cout << "Bui Thuc Nam - 20200857 - 721431" << endl;
		cout << "**   CHUONG TRINH QUAN LY CAC DA THUC   **" << endl;
		cout << "**1. Nhap cac Da thuc, gia tri x        **" << endl;
		cout << "**2. In danh sach da thuc va gia tri    **" << endl;
		cout << "**0. Thoat                              **" << endl;
		cout << "******************************************" << endl;
		cout << "**        Nhap lua chon cua ban         **" << endl;
		cin >> luachon;
		switch (luachon)
		{
		case 1:
		{
			cout << "Ban da chon nhap DS da thuc!" << endl;
			nhapDsDaThuc(ds);
			cout << "Ban da nhap thanh cong!" << endl
				 << endl;
			break;
		}
		case 2:
		{
			cout << "Ban da chon xuat DS da thuc, Gia tri da thuc!" << endl;
			inDsDathuc(ds);
			break;
		}
		case 0:
			break;
		default:
		{
			cout << "Lua chon khong hop le, vui long nhap lai." << endl;
			break;
		}
		}
	} while (luachon != 0);
	return 0;
}
