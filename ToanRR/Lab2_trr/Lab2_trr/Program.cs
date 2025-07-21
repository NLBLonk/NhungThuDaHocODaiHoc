using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace TapHop
{
	internal class TapHop
	{
		static void Main(String[] args)
		{

			ChayChuongTrinh();
			Console.ReadKey();
		}
		static void ChayChuongTrinh()
		{
			#region Tap Hop Co Dinh
			List<int> u = new List<int>() { -6, -7, -8, 6, 7, 8, 9, 5, 1, 2, 3, 4, 10 };

			List<int> a = new List<int>() { -6, -7, -8, 6, 7, 8, 9, 5 };
			List<int> b = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8 };

			#endregion

			int Chon, SoMenu = 7;
			do
			{
				Console.Clear();
				XuatMenu();
				Chon = ChonMenu(SoMenu);
				XuLyMenu(Chon, u, a, b);
			} while (Chon != 0);
		}
		static void XuatMenu()
		{
			Console.WriteLine("0. Thoat chuong trinh");
			Console.WriteLine("1. Nhap vao thong tin cua vu tru U, tap hop A và tap hop B");
			Console.WriteLine("2. Kiem tra phan tu da nhap co thuoc tap hop A hay khong ?");
			Console.WriteLine("3. Tim giao cua 2 tap hop (A^B)");
			Console.WriteLine("4. Tim hop cua 2 tap hop (AvB)");
			Console.WriteLine("5. Tim hieu cua hai tap hop");
			Console.WriteLine("6. Tinh phan tu bu cua tap A trong U (U/A)");
			Console.WriteLine("7. Tinh hieu doi xung cua A va B");
		}
		static int ChonMenu(int SoMenu)
		{
			int Chon;
			do
			{
				Console.Write("\nChon chuc nang [0..." + SoMenu + "] = ");
				Chon = Convert.ToInt32(Console.ReadLine());
				if (0 <= Chon && Chon <= SoMenu)
					return Chon;
			} while (true);
		}
		static void XuLyMenu(int Chon, List<int> u, List<int> a, List<int> b)
		{
			switch (Chon)
			{
				case 0:
					Console.WriteLine("\nThoat chuong trinh!");
					Environment.Exit(0);
					break;
				case 1:
					Console.WriteLine("\n1. Nhap vao thong tin cua vu tru U, tap hop A và tap hop B");
					Console.Write("Thong tin trong vu tru U:");
					Xuat(u);
					Console.Write("\nTap hop A:");
					Xuat(a);
					Console.Write("\nTap hop B:");
					Xuat(b);
					break;
				case 2:
					Console.WriteLine("\n2. Kiem tra phan tu da nhap co thuoc tap hop A hay khong ?");
					Xuat(a);
					Console.WriteLine("\nNhap gia tri can kiem tra:");
					int x = int.Parse(Console.ReadLine());
					Console.WriteLine("\nPhan tu {0} {1} la phan tu cua tap hop a ", x, KiemTra(a, x));
					break;
				case 3:
					Console.WriteLine("\n3. Tim giao cua 2 tap hop (A^B)");
					Console.WriteLine("Tap hop A:");
					Xuat(a);
					Console.WriteLine("Tap hop B:");
					Xuat(b);
					Console.WriteLine("\nGiao cua hai tap hop tren la: ");
					HamGiao(a, b);
					break;
				case 4:
					Console.WriteLine("\n4. Tim hop cua 2 tap hop (AvB)");
					Console.WriteLine("Tap hop A:");
					Xuat(a);
					Console.WriteLine("Tap hop B:");
					Xuat(b);
					Console.WriteLine("\nHop cua hai tap hop tren la: ");
					HamHop(a, b);
					break;
				case 5:
					Console.WriteLine("\n5. Tim hieu cua hai tap hop (A/B)");
					Console.WriteLine("Tap hop A:");
					Xuat(a);
					Console.WriteLine("Tap hop B:");
					Xuat(b);
					Console.WriteLine("\nHieu cua hai tap hop tren la: ");
					Hieu(a, b);
					break;
				case 6:
					Console.WriteLine("\n6. Tinh phan tu bu cua tap A trong U (U/A)");
					Console.WriteLine("Tap hop U:");
					Xuat(u);
					Console.WriteLine("Tap hop A:");
					Xuat(a);
					Console.WriteLine("\nHieu cua hai tap hop tren la: ");
					Bu(u, a);
					break;
				case 7:
					Console.WriteLine("\n7. Tinh hieu doi xung cua A va B ((A/B)v(B/A)");
					Console.WriteLine("Tap hop A:");
					Xuat(a);
					Console.WriteLine("Tap hop B:");
					Xuat(b);
					Console.WriteLine("\nHieu doi xung cua hai tap hop tren la: ");
					HieuDoiXung(a, b);
					break;
				default:
					break;
			}
			Console.ReadKey();
		}
		static void Xuat(List<int> u)
		{

			foreach (var i in u)
			{
				Console.Write("{0} ", i);
			}
			Console.WriteLine();
		}
		static string KiemTra(List<int> a, int b)
		{
			foreach (var i in a)
			{
				if (i == b)
				{
					return "co";
				}
			}
			return "khong";
		}
		static void HamGiao(List<int> a, List<int> b)
		{
			var kq = a.Intersect(b).OrderByDescending(x => x);

			foreach (var i in kq)
			{
				Console.Write("{0}  ", i);
			}
			Console.WriteLine();
		}
		static void HamHop(List<int> a, List<int> b)
		{
			var kq = a.Union(b).OrderBy(x => x);   //Hàm Union: Hàm hợp
			foreach (var i in kq)
			{
				Console.Write("{0}  ", i);
			}
		}
		static void Hieu(List<int> a, List<int> b)
		{
			var kq = a.Intersect(b);              //Hàm Intersect: Hàm hiệu
			List<int> c = new List<int>();
			foreach (var i in a)
			{
				foreach (var o in kq)
				{
					if (i == o)
					{
						c.Add(i);
					}
				}
			}
			foreach (var w in c)
			{
				a.Remove(w);
			}
			foreach (var x in a)
			{
				Console.Write("{0} ", x);
			}
		}
		static void Bu(List<int> u, List<int> a)
		{

			List<int> c = new List<int>();
			foreach (var i in u)
			{
				foreach (var o in a)
				{
					if (i == o)
					{
						c.Add(i);
					}
				}
			}
			foreach (var w in c)
			{
				u.Remove(w);
			}
			foreach (var x in u)
			{
				Console.Write("{0} ", x);

			}
		}
		static void HieuDoiXung(List<int> a, List<int> b)
		{
			var kq = a.Union(b);
			List<int> c = new List<int>();
			List<int> hop = new List<int>();
			foreach (var w in kq)
			{
				hop.Add(w);
			}
			var giao = a.Intersect(b);


			foreach (var u in giao)
			{
				hop.Remove(u);
			}
			foreach (var x in hop)
			{
				Console.Write("{0} ", x);
			}
		}
	}
}

