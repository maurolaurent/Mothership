using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using MothershipLibrary.DataModels;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Net;

namespace MothershipLibrary.Probes
{
    public class MothershipProbe
    {
        public bool ProbeMothership()
        {
            try 
	        {	        
		
            var mothership = System.Configuration.ConfigurationManager.AppSettings["MothershipURI"] + "ReceiveCommService";

            ReceiveCommService.ReceiveCommServiceClient receiveCommClient =
                new ReceiveCommService.ReceiveCommServiceClient("netTcpBinding_ReceiveCommService", mothership);

            List<string> commands = new List<string>();
            commands.Add(CommStrings.Tier1MothershipCommunicationMessageT1MSCOMM + ".CommType:100");
            commands.Add(CommStrings.CommHostName + ":" + Dns.GetHostName());
            commands.Add(CommStrings.CommComputerName + ":" + Environment.MachineName);
            commands.Add(CommStrings.CommComputerOS + ":" + Environment.OSVersion);
            //Return IPs of the host
            commands.Add(CommStrings.CommEthernetIp + ":" + GetLocalIPv4(NetworkInterfaceType.Ethernet));
            commands.Add(CommStrings.CommWireless80211Ip + ":" + GetLocalIPv4(NetworkInterfaceType.Wireless80211));

            bool response = receiveCommClient.GetData(commands.ToArray());
            receiveCommClient.Close();
            MothershipEvent.CreateSystemEvent("Response from Mothership Probe:" + (response == true ? "Connection sucess" : "Failure: Connection not established"),"", System.Diagnostics.EventLogEntryType.Information);
            return true;
	        }
	        catch (Exception)
	        {
		
		        throw;
	        }


        }

        public bool ProbeMinion() { 
      
            try
            {

                var client = System.Configuration.ConfigurationManager.AppSettings["MinionURI"] + "RunCommandService";
                
                RunCommandService.RunCommandServiceClient runCommandClient =
                    new RunCommandService.RunCommandServiceClient("netTcpBinding_RunCommandService", client);

                string[] rval = runCommandClient.InvokeCommand("ipconfig");
                runCommandClient.Close();

                if (rval.Length > 1)
                {
                    return true;
                }

                else { return false; }

            }
            catch (Exception ex)
            {

                List<string> lstExp = new List<string>();

                lstExp.Add("Message: " + ex.Message);
                lstExp.Add("Stack Trace: " + ex.StackTrace);
                lstExp.Add("Source: " + ex.Source);

                MothershipEvent.CreateSystemEvent("Mothership Probe Minion Message: " + ex.Message + "Stack Trace: " + ex.StackTrace, "", System.Diagnostics.EventLogEntryType.Warning);


                return false;

            }

       
        }
        

        private static string GetLocalIPv4(NetworkInterfaceType _type)
        {
            string output = "";
            foreach (NetworkInterface item in NetworkInterface.GetAllNetworkInterfaces())
            {
                if (item.NetworkInterfaceType == _type && item.OperationalStatus == OperationalStatus.Up)
                {
                    foreach (UnicastIPAddressInformation ip in item.GetIPProperties().UnicastAddresses)
                    {
                        if (ip.Address.AddressFamily == AddressFamily.InterNetwork)
                        {
                            output = ip.Address.ToString();
                        }
                    }
                }
            }
            return output;
        }
    }
}
