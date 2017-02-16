using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MothershipLibrary.RunCommandService;


namespace MothershipLibrary.Logic
{
    public class MinionCommunication
    {
        
        public static string[] RunCommand(string cmd, string ip)
        {
            try
            {
                string client = "net.tcp://"+ ip +":8523/RunCommandService";
                string[] rval = new string[] {};
                RunCommandService.RunCommandServiceClient runCommandClient =
                    new RunCommandService.RunCommandServiceClient("netTcpBinding_RunCommandService", client);                
                 rval = runCommandClient.InvokeCommand(cmd);
                runCommandClient.Close();
                return rval;
            }
            catch (Exception ex)
            {
                return new string[] { "Ip Used:" + ip + " Message:" + ex.Message + " StackTrace:" + ex.StackTrace };

            }


        }

    }
}
