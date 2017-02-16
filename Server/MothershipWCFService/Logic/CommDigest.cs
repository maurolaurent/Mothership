using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MothershipLibrary;
using MothershipLibrary.DataModels;

namespace MothershipWCFService.Logic
{
    public class CommDigest
    {
        internal static bool EstablishCommunication(string[] values)
        {
            string _commType = values[0].Split(':')[1];

            switch (_commType)
            {
                case "100": //Minion service started
                            //Extract the data given the communication tye template
                    string hostName = string.Empty;
                    string computerName = string.Empty;
                    string computerOS = string.Empty;
                    string EthernetIp = string.Empty;
                    string Wireless80211Ip = string.Empty;

                    foreach (string ss in values)
                    {
                        var rss = ss.Split(':');
                        if (rss[0] == CommStrings.CommHostName.ToString()) { hostName = rss[1]; }
                        if (rss[0] == CommStrings.CommComputerName.ToString()) { computerName = rss[1]; }
                        if (rss[0] == CommStrings.CommComputerOS.ToString()) { computerOS = rss[1]; }
                        if (rss[0] == CommStrings.CommEthernetIp.ToString()) { EthernetIp = rss[1]; }
                        if (rss[0] == CommStrings.CommWireless80211Ip.ToString()) { Wireless80211Ip = rss[1]; }
                    }
                
                    //We need to know if the communication is from a new client
                    bool exists = MothershipMinion.ReviseIfMinionExistsByName(computerName);
                    bool newMinion = false;
                    Client minion = new Client();
                    if (!exists)
                    {
                        minion = MothershipMinion.CreateMinion(computerName, values);
                        newMinion = true;
                    }
                    else {
                        minion = MothershipMinion.GetMinionByName(computerName);
                    }


                    //Lastly, include the message of successful collection into the database
                    string sucessCommMessage = "Minion communication sucess. ";
                    string newMinionMessage = sucessCommMessage + "A new minion, " + computerName + " has joined to the Mothership.";

                    if (!newMinion)
                    {
                        MothershipEvent.CreateMothershipEvent(sucessCommMessage, values, minion.Id);
                    }
                    else {
                        MothershipEvent.CreateMothershipEvent(newMinionMessage, values, minion.Id);
                    }

                    return true;

                default:
                    return false;
            }



        }
    }
}
