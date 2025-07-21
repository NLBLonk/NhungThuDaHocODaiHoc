using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab1_Cau2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int[] dayMau = { 1, 2, 3, 4 };
            Console.WriteLine("0");
            for (int i = 0; i < dayMau.Length; i++) {
                Console.WriteLine("[{0}]", dayMau[i]);
                for (int j = 0; j < dayMau.Length; j++) {
                    if (dayMau[i] > dayMau[j]) {
                        Console.WriteLine("[{0},{1}]", dayMau[j], dayMau[i]);
                        for (int k = 0; k < dayMau.Length; k++) {
                            if (dayMau[j] > dayMau[k]) {
                                Console.WriteLine("[{0},{1},{2}]", dayMau[k], dayMau[j], dayMau[i]);
                                for (int l = 0; l < dayMau.Length; l++) {
                                    if (dayMau[k] > dayMau[l]) {
                                        Console.WriteLine("[{0},{1},{2},{3}]", dayMau[l], dayMau[k], dayMau[j], dayMau[i]);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Console.ReadKey();
        }

    }
}

