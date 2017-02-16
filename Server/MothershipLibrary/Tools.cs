using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MothershipLibrary
{
    public class Tools
    {

        public static int GetMillisecondsFromDatetimes(DateTime start, DateTime end)
        {
            TimeSpan span = end - start;
            int ms = (int)span.TotalMilliseconds;
            return ms;
        }

        public static string StringArrayToHtmlText(string[] arr) {

            string result = "";

            foreach (string ss in arr)
            {
                if (String.IsNullOrEmpty(ss) || String.IsNullOrWhiteSpace(ss))
                {
                    result += Environment.NewLine;
                }
                else {
                    result += ss + Environment.NewLine; ;
                }
            }

            return result;
        }

    }
}
