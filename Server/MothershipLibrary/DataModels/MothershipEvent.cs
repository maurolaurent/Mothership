using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MothershipLibrary.DataModels
{
    //Extension class for Audit
    public class MothershipEvent : Audit
    {

        public MothershipEvent() { }

        /// <summary>Mothership event that inherits from Audit entity to include system audit messages into database.
        /// <para>- string message. Message to store</para>
        /// <para>- string details. Details about the message to store</para>
        /// </summary>
        public static bool CreateMothershipEvent(string message, string details) {

            try
            {
                Audit mv = new Audit();
                      mv.Id = Guid.NewGuid();
                      mv.EventTime = DateTime.Now;
                      mv.Message = message;
                      mv.Details = details;
                MothershipEntities mca = new MothershipEntities();
                mca.Audit.Add(mv);
                mca.SaveChanges();

                return true;

            }
            catch (Exception)
            {
                WriteSystemMessage("Mothership Service",
                                   "Fatal Error",
                                   "Audit Database Unreachable",
                                    EventLogEntryType.Error,
                                    666);
                return false;
            }

            
        }

        public static bool CreateSystemEvent(string message, string details,  EventLogEntryType type)
        {
            WriteSystemMessage("Mothership Service",
                                 message,
                                 details,
                                  type,
                                  02);
            return false;
        }

        /// <summary>Mothership event that inherits from Client_Comm that stores communications from minions into database.
        /// <para>- string message. Message to store</para>
        /// <para>- string maessages. The output of the messages relayed by the minion</para>
        /// </summary>
        public static bool CreateMothershipEvent(string message, string[] messages, Guid client)
        {

            try
            {
                List<Client_Comm_Line> lst_ccl = new List<Client_Comm_Line>();
                Client_Comm cliComm = new Client_Comm();
                cliComm.Client = client;
                cliComm.Date = DateTime.Now;
                cliComm.Id = Guid.NewGuid();

                MothershipEntities mca = new MothershipEntities();
                mca.Client_Comm.Add(cliComm);
                mca.SaveChanges();

                MothershipEntities mcb = new MothershipEntities();
                for (int i = 0; i < messages.Length; i++)
                {
                    Client_Comm_Line ccl = new Client_Comm_Line()
                    {
                        CommId = cliComm.Id,
                        Line = i,
                        Text = messages[i],
                        Id = Guid.NewGuid()
                    };
                    mcb.Client_Comm_Line.Add(ccl);                    
                }

                mcb.SaveChanges();

                return true;

            }
            catch (Exception)
            {
                WriteSystemMessage("Mothership Service",
                                   "Fatal Error",
                                   "Audit Database Unreachable",
                                    EventLogEntryType.Error,
                                    666);
                return false;
            }


        }

        private static void WriteSystemMessage(string source, string log, string ev, EventLogEntryType EventLogEntryType, int eventCode)
        {
            EventLog.WriteEntry(source, log, EventLogEntryType, eventCode);
        }

    
    }
}
