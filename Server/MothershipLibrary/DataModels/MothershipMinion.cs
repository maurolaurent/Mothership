using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MothershipLibrary.DataModels
{
    public class MothershipMinion : Client
    {
        public MothershipMinion() { }

        public static bool ReviseIfMinionExistsByName(string name)
        {

            MothershipEntities mca = new MothershipEntities();

            var minion = from m in mca.Client
                         where m.Name == name
                         select m;

            if (minion.Count() > 0)
            {
                return true;
            }

            else { return false; }

        }

        public static Client GetMinionByName(string name)
        {

            MothershipEntities mca = new MothershipEntities();

            var minion =  from m in mca.Client
                          where m.Name == name
                          select m;

            if (minion.Count() > 0)
            {
                return minion.FirstOrDefault();
            }

            else { throw new Exception(); }

        }

        public static Client CreateMinion(string name, string[] info)
        { 
            
            Client cli = new Client();
            cli.Name = name;
            cli.Id = Guid.NewGuid();

            MothershipEntities mca = new MothershipEntities();
            mca.Client.Add(cli);


            List<Client_Info> lst_clif = new List<Client_Info>();

            foreach (var ii in info)
            {
                var information = ii.Split(':');

                Client_Info clif = new Client_Info();
                clif.ClientId = cli.Id;
                clif.InfoType = GetInfoType(information[0]);
                clif.InfoDetail = information[1];
                clif.Id = Guid.NewGuid();
                clif.PreferredConnection = false;

                mca.Client_Info.Add(clif);
            }
            
            mca.SaveChanges();

            return cli;

        }

        private static int GetInfoType(string p)
        {
         
            if (p.Contains(CommStrings.Tier1MothershipCommunicationMessageT1MSCOMM.ToString())) { return 0; }
            if (p.Contains(CommStrings.CommHostName.ToString())) { return 1; }
            if (p.Contains(CommStrings.CommComputerName.ToString())) { return 2; }
            if (p.Contains(CommStrings.CommComputerOS.ToString())) { return 3; }
            if (p.Contains(CommStrings.CommEthernetIp.ToString())) { return 4; }
            if (p.Contains(CommStrings.CommWireless80211Ip.ToString())) { return 5; }

            return 0;         
        }

    }
}

