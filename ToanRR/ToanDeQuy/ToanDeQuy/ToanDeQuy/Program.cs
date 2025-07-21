using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToanDeQuy
{
    internal class Program
    {
       
        static void Main(string[] args)
        {
            int n;
            Console.WriteLine("Nhap vao n:");
            n =int.Parse(Console.ReadLine());
            Console.WriteLine(GiaiThua(n));
        }
        static int GiaiThua(int n)
        {
            if (n == 0) return 1;
            else if (n == 1) return 3;
            else return (5 * GiaiThua(n - 1) - 6 * GiaiThua(n - 2) - n + 3);
        }
    }
}
