using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MothershipService.Logic
{
    public class CommandRunner
    {

        public static List<string> sb = new List<string>();

        public static string[] InvokeCommand(string command)
        {

            try
            {
                
                //Initialize command logging
                sb.Add(Environment.NewLine);
                sb.Add("-----------------------------------------");
                sb.Add("Response message from Mothership service");
                sb.Add("Time: " + DateTime.Now.ToLongDateString());
                sb.Add("-----------------------------------------");

                ProcessStartInfo cmdStartInfo = new ProcessStartInfo();
                cmdStartInfo.FileName = @"C:\Windows\System32\cmd.exe";
                cmdStartInfo.RedirectStandardOutput = true;
                cmdStartInfo.RedirectStandardError = true;
                cmdStartInfo.RedirectStandardInput = true;
                cmdStartInfo.UseShellExecute = false;
                cmdStartInfo.CreateNoWindow = true;

                Process cmdProcess = new Process();
                cmdProcess.StartInfo = cmdStartInfo;
                cmdProcess.ErrorDataReceived += cmd_Error;
                cmdProcess.OutputDataReceived += cmd_DataReceived;
                cmdProcess.EnableRaisingEvents = true;
                cmdProcess.Start();
                cmdProcess.BeginOutputReadLine();
                cmdProcess.BeginErrorReadLine();

                cmdProcess.StandardInput.WriteLine(command);     //Execute command          
                cmdProcess.StandardInput.WriteLine("exit");     //Execute exit.

         

                cmdProcess.WaitForExit();

                return sb.ToArray();
            }
            catch (Exception ex)
            {
                sb.Add(@"An error ocurred. \r\n Message: " + ex.Message);
                return sb.ToArray();
            }
        }

        static void cmd_DataReceived(object sender, DataReceivedEventArgs e)
        {
            sb.Add(e.Data);        
        }

        static void cmd_Error(object sender, DataReceivedEventArgs e)
        {
            sb.Add(e.Data);  
        }

    }
}

