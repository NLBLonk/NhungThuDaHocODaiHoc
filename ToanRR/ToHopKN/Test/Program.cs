using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace Test
{
    internal class Program
    {
        static int n, k;
        static int[] T;

        static void Main(string[] args)
        {
            do
            {
                Console.Write("Nhap vào gia tri cho n: ");
                n = int.Parse(Console.ReadLine());
                Console.Write("n= {");
                for (int i = 1; i <= n; i++) {
                    if (i != n) {
                        Console.Write("{0}, ", i);
                    }
                    else {
                        Console.Write("{0}", i);
                    }
                }
                Console.Write('}');
                Console.Write("\nNhap vào gia tri cho k: ");
                k = int.Parse(Console.ReadLine());
                Console.WriteLine();
            } while (n < k);
            T = new int[n + 1];
            ToHopKN();
            Console.ReadKey();
        }
        static void XuatMang(int[] A, int n)
        {
            for (int i = 1; i <= n; i++)
                Console.Write(A[i].ToString() + "  ");
            Console.WriteLine();
        }

        static void ToHopKN()
        {
            int i,p;
            int dem = 0;
            for (i = 1; i <= k; i++) {
                T[i] = i;
            }
            p = k;
            while (p>=1) {
                dem++;
                Console.Write("Tap con thu " + dem.ToString() + ": ");
                XuatMang(T, k);
                if (T[k] == n) { 
                    p--; 
                } else { 
                        p = k; 
                    }
                if (p >= 1) {
                    for (i = k; i >= p; i--) { 
                        T[i] = T[p] + i - p + 1; 
                    }  
                }
            }
            Console.Write($"=> To hop chap {k} cua {n} phan tu la {dem}");
        }
    }
}
