using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.ServiceModel;
using MinionService;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using MothershipLibrary.DataModels;
using System.Configuration;
using System.Net;

namespace MothershipMinionService
{
    public partial class MothershipMinionService : ServiceBase
    {

        internal static ServiceHost myServiceHost = null;

        public MothershipMinionService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            if (myServiceHost != null)
            {
                myServiceHost.Close();
            }
            myServiceHost = new ServiceHost(typeof(RunCommandService));
            myServiceHost.Open();

            ProbeMothership();

            WriteSystemMessage("Mothership Minion Service",
                                   "Service started sucessfully",
                                   "Application Start",
                                   EventLogEntryType.Information,
                                   105);
        }

        protected override void OnStop()
        {
            if (myServiceHost != null)
            {
                myServiceHost.Close();
                myServiceHost = null;
            }

            SignalMothershipConnectionClosure();
        }

        private static void SignalMothershipConnectionClosure()
        {
            try
            {
                var mothership = ConfigurationManager.AppSettings["MothershipURI"] + "ReceiveCommService";
                MinionService.ReceiveCommService.ReceiveCommServiceClient receiveCommClient =
                    new MinionService.ReceiveCommService.ReceiveCommServiceClient("netTcpBinding_ReceiveCommService", mothership);

                List<string> commands = new List<string>();
                commands.Add(CommStrings.Tier1MothershipCommunicationMessageT1MSCOMM + ".CommType:199");
                commands.Add(CommStrings.CommHostName + ":" + Dns.GetHostName());
                commands.Add("Connection closed. Minion is offline");
               
                bool response = receiveCommClient.GetData(commands.ToArray());
                receiveCommClient.Close();

            }
            catch (Exception Ex)
            {
                WriteSystemMessage("Mothership Minion Service",
                                     Ex.Message + " , StackTrace: " + Ex.StackTrace,
                                      "Application Close",
                                      EventLogEntryType.Error,
                                      600);
                throw;
            }

        }

        private static void ProbeMothership()
        {
            try
            {
                var mothership = ConfigurationManager.AppSettings["MothershipURI"] + "ReceiveCommService";
                MinionService.ReceiveCommService.ReceiveCommServiceClient receiveCommClient =
                    new MinionService.ReceiveCommService.ReceiveCommServiceClient("netTcpBinding_ReceiveCommService", mothership);

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

                WriteSystemMessage("Mothership Minion Service",
                    "Probed Mothership, the connection was " + (response ? "successful" : "not established"),
                                      "Application Start",
                                      response ? EventLogEntryType.Information : EventLogEntryType.Error,
                                      600);

            }
            catch (Exception Ex)
            {
                WriteSystemMessage("Mothership Minion Service",
                                     Ex.Message + " , StackTrace: " + Ex.StackTrace,
                                      "Application Start",
                                      EventLogEntryType.Error,
                                      600);
                throw;
            }

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

        private static void WriteSystemMessage(string source, string log, string ev, EventLogEntryType EventLogEntryType, int eventCode)
        {
            EventLog.WriteEntry(source, log, EventLogEntryType, eventCode);
        }
    }
}
