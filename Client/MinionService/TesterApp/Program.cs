using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using TesterApp.RunCommandService;
using MothershipLibrary.DataModels;
using System.Configuration;

namespace TesterApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Welcome to Minion Prober");
            Console.WriteLine(Environment.NewLine);
            Console.WriteLine("Please start by selecting a client to relay commands to: \n\r 1) Mauro-Laptop \n\r 2) Gabriel-PC ");
            Console.WriteLine(Environment.NewLine);
            Console.WriteLine("Otherwise, press 3 to probe the Mothership");
            string client = Console.ReadLine();
            string command = string.Empty;


            string[] res = new string[] {};
            switch (client)
            {
                case "1":
                    Console.WriteLine("Enter the command to be relayed:");   
                    command = Console.ReadLine();
                    res = RunCommand(command, client);
                    break;
                case "2":
                    Console.WriteLine("Enter the command to be relayed:");   
                    command = Console.ReadLine();
                    res = RunCommand(command, client);
                    break;
                case "3":
                    ProbeMothership();
                    break;
                default:
                    break;
            }

            if (res.Length != 0)
            {
                foreach (string item in res)
                {
                    if (String.IsNullOrEmpty(item))
                    {
                        Console.WriteLine("\n\r");
                    }
                    else { Console.WriteLine(item); }
                }    
            }

            Console.ReadLine();
        }

        private static void ProbeMothership() {
            var mothership = ConfigurationManager.AppSettings["MothershipURI"] + "ReceiveCommService";
          
            ReceiveCommService.ReceiveCommServiceClient receiveCommClient =
                new ReceiveCommService.ReceiveCommServiceClient("netTcpBinding_ReceiveCommService", mothership);

            List<string> commands = new List<string>();
            commands.Add(CommStrings.Tier1MothershipCommunicationMessageT1MSCOMM + ".CommType:100");
            commands.Add(CommStrings.CommHostName + ":" + Dns.GetHostName());
            commands.Add(CommStrings.CommComputerName + ":" + Environment.MachineName);
            commands.Add(CommStrings.CommComputerOS + ":" + Environment.OSVersion);
            //Return IPs of the host
            commands.Add(CommStrings.CommEthernetIp + ":" + GetLocalIPv4(NetworkInterfaceType.Ethernet));
            commands.Add(CommStrings.CommWireless80211Ip + ":" +  GetLocalIPv4(NetworkInterfaceType.Wireless80211));
          
            bool response = receiveCommClient.GetData(commands.ToArray());
            receiveCommClient.Close();

            Console.WriteLine("Response from Mothership:" + (response == true ? "Connection sucess" : "Failure: Connection not established"));
             
        }

        public static string GetLocalIPv4(NetworkInterfaceType _type)
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

        private static string[] RunCommand(string cmd, string client)
        {
            try
            {
                
                switch (client)
                {
                    case "1":
                        client = "net.tcp://192.168.0.3:8523/RunCommandService";
                        break;
                    case "2":
                        client = "net.tcp://192.168.0.5:8523/RunCommandService";
                        break;
                    default:
                        client = "net.tcp://localhost:8523/RunCommandService";
                        break;
                }                

                RunCommandService.RunCommandServiceClient runCommandClient =
                    new RunCommandService.RunCommandServiceClient("netTcpBinding_RunCommandService", client);

                string[] rval = runCommandClient.InvokeCommand(cmd);
                runCommandClient.Close();
                return rval;
            }
            catch (Exception ex)
            {

                List<string> lstExp = new List<string>();

                lstExp.Add("Message: " + ex.Message);
                lstExp.Add("Stack Trace: " + ex.StackTrace);
                lstExp.Add("Source: " + ex.Source);


                return lstExp.ToArray();

            }

       
        }
    }
}
