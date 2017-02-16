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
using MothershipService;
using MothershipLibrary;
using MothershipLibrary.DataModels;
using System.Timers;
using System.Data.Entity;

namespace MothershipWinService
{
    public partial class MothershipWinService : ServiceBase
    {
        static List<Job> scheduledJobs = new List<Job>();
        static List<Job> newlyScheduledJobs = new List<Job>();
        static System.Threading.Timer _timer;

        internal static ServiceHost myServiceHost = null;

        public MothershipWinService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            if (myServiceHost != null)
            {
                myServiceHost.Close();
            }
            myServiceHost = new ServiceHost(typeof(ReceiveCommService));
            myServiceHost.Open();

            //Also start the logic that process the scheduled jobs
            try
            {
                ManageScheduledJobs();
                StartJobDaemon();
            }
            catch (Exception ex)
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling Timer Error", "Error initiating job scheduling." + ex.Message, EventLogEntryType.Error);      
                throw;
            }
            
        }      

        protected override void OnStop()
        {
            if (myServiceHost != null)
            {
                myServiceHost.Close();
                myServiceHost = null;
            }
        }

        private static int GetJobListToSend(bool firstRun) {           

            DateTime currentTime = DateTime.Now;
            MothershipEntities me = new MothershipEntities();
            int newJobs = 0;

            var _scheduledJobs = from j in me.Job
                                 where j.ToExecute >= currentTime
                                 && j.Status == 0     
                                 select j;

            scheduledJobs = _scheduledJobs.ToList();
            newJobs = scheduledJobs.Count;

            return newJobs;

          /*  if (firstRun)
            {
                scheduledJobs = _scheduledJobs.ToList();
                newJobs = scheduledJobs.Count;
            }
            else
            {
                foreach (Job _j in _scheduledJobs)
                {
                    var rr = CheckIfIdInArray(_j, scheduledJobs);

                   // var r = scheduledJobs.Exists(x => x == _j);

                    if (firstRun)
                    {
                        //Add the new job
                        scheduledJobs.Add(_j);
                    }
                    else
                    {
                        if (rr)
                        {
                            scheduledJobs.Add(_j); //We need to keep track of our jobs
                            newlyScheduledJobs.Add(_j); //This collection is for the daemon only. It gets flushed when its done sending these new jobs.
                            newJobs++;
                        }
                    }
                }
            }*/

        }

        private static bool CheckIfIdInArray(Job _j, List<Job> scheduledJobs)
        {
            foreach (Job jjj in scheduledJobs)
            {
                if (_j.Id == jjj.Id)
                {
                    return true;
                }
            }

            return false;
        }

        private static void ManageScheduledJobs()
        {

            GetJobListToSend(true);      

            MothershipEvent.CreateSystemEvent("Job Scheduling is being started for " + scheduledJobs.Count.ToString() + " job(s).", "", EventLogEntryType.Information);

            for (int i = 0; i < scheduledJobs.Count; i++)
            {
                int millisecs = MothershipLibrary.Tools.GetMillisecondsFromDatetimes(scheduledJobs[i].Created, scheduledJobs[i].ToExecute);
                StartJobTimer(millisecs, scheduledJobs[i]);
            }

        }

        protected static void StartJobDaemon()
        {
            try
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling daemon has started", "", EventLogEntryType.Information);

                System.Timers.Timer timer = new System.Timers.Timer(1000);
                timer.Enabled = true;
                timer.Elapsed += (sender, e) => OnJobTimerDaemonFired(sender, e, DateTime.Now);
                timer.AutoReset = true;
                timer.Start();

            }
            catch (Exception ex)
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling daemon failed" + ex.Message, "", EventLogEntryType.Error);
            }
        }

        protected static void StartJobTimer(int millisecondToRun, Job job)
        {
            try
            {
 
                System.Timers.Timer timer = new System.Timers.Timer(1000);
                timer.Enabled = true;
                timer.Elapsed += (sender, e) => OnJobTimerFired(sender, e, job);
                timer.Elapsed += (sender, e) => OnJobTimerTrackOfTime(sender, e, job);
                timer.AutoReset = true;
                timer.Start();

                //If the thread started, we have no longer use for the job collection tracking
                scheduledJobs.Remove(job);
               
            }
            catch (Exception ex)
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling Timer Error initiating job scheduling for " + job.Name + "." + ex.Message, "", EventLogEntryType.Error);            
            }
        }

        static void OnJobTimerDaemonFired(object Sender, System.Timers.ElapsedEventArgs e, DateTime dt)
        {
            int newJobs = GetJobListToSend(false);      

            if (newJobs > 0)
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling Timer Daemon is running at" + dt.ToLongDateString() + " and found " + newJobs + " new jobs.", "", EventLogEntryType.Information);

                foreach (Job jjj in scheduledJobs)
                {
                    int millisecs = MothershipLibrary.Tools.GetMillisecondsFromDatetimes(jjj.Created, jjj.ToExecute);
                    StartJobTimer(millisecs, jjj);
                }
            }

        }

          static void OnJobTimerFired(object Sender, System.Timers.ElapsedEventArgs e, Job job) {

            try
            {
                int millisecs = MothershipLibrary.Tools.GetMillisecondsFromDatetimes(DateTime.Now, job.ToExecute);
                TimeSpan ts = TimeSpan.FromMilliseconds(millisecs);
                string dtermineBySec = DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();
                string jobdtermine = job.ToExecute.ToShortDateString() + " " + job.ToExecute.ToShortTimeString();
                bool runTime = dtermineBySec == jobdtermine;

               /* MothershipEvent.CreateSystemEvent("Job Scheduling Timer for [" + job.Name + "] is running. It will be run at:" +
                                              job.ToExecute.ToLongDateString() + " , which is in " + Math.Round(ts.TotalMinutes).ToString() +
                                              " minutes. RUNTIME: " + runTime + " DTERMINEBYSEC:" + dtermineBySec + " JOBDTERMINE: " + jobdtermine
                                              , "", EventLogEntryType.Information);*/

                if (runTime)
                {
                    MothershipEvent.CreateSystemEvent("Job Scheduling Timer is running on Job " + job.Name + " at " + dtermineBySec, "", EventLogEntryType.Information);
                    RunJob(job);
                    ((Timer)Sender).Dispose(); //For garbage collection purposes, i know i am threading a lot, so the resources should liberate themselves after they expire 
                    MothershipEvent.CreateSystemEvent("Job " + job.Name + " ran successfully at " + DateTime.Now.ToLongDateString(), "", EventLogEntryType.Information);
                }
            }
            catch (Exception ex)
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling Timer Job execution failed. Reason: " + ex.Message, "", EventLogEntryType.Error);
               
            }

                     
        }

         static void OnJobTimerTrackOfTime(object Sender, System.Timers.ElapsedEventArgs e, Job job)
        {
            int millisecs = MothershipLibrary.Tools.GetMillisecondsFromDatetimes(DateTime.Now, job.ToExecute);
            TimeSpan ts = TimeSpan.FromMilliseconds(millisecs);

            string dtermineBySec = DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();
            string jobdtermine = job.ToExecute.ToShortDateString() + " " + job.ToExecute.ToShortTimeString();

            bool runTime = dtermineBySec == jobdtermine;

            /*MothershipEvent.CreateSystemEvent("Job Scheduling Timer for [" + job.Name + "] is running. It will be run at:" +
                                               job.ToExecute.ToLongDateString() + " , which is in " + Math.Round(ts.TotalMinutes).ToString() +
                                               " minutes. RUNTIME: " + runTime + " DTERMINEBYSEC:" + dtermineBySec + " JOBDTERMINE: " + jobdtermine
                                               , "", EventLogEntryType.Information);*/

             

        }

        static void RunJob(Job refjob) {
            try
            {
                MothershipEntities db = new MothershipEntities();
                bool doneWithRunErrors = false;
                string[] res = new string[] { };

                Job job = db.Job.Find(refjob.Id);

                Client client = db.Client.Find(job.Client);

                var _ip = from c in client.Client_Info
                          select c;

                string connType = string.Empty;

                if (_ip.Count() > 0)
                {
                    foreach (Client_Info sc in _ip)
                    {
                        if (sc.InfoType == (int)CommStrings.CommEthernetIp && !String.IsNullOrEmpty(sc.InfoDetail))
                        {
                            res = MothershipLibrary.Logic.MinionCommunication.RunCommand(job.Command, sc.InfoDetail);
                            connType = CommStrings.CommEthernetIp.ToString();
                            if (res.Length > 1)
                            {
                                break;
                            }
                        }

                        if (sc.InfoType == (int)CommStrings.CommWireless80211Ip && !String.IsNullOrEmpty(sc.InfoDetail)) 
                        {
                            res = MothershipLibrary.Logic.MinionCommunication.RunCommand(job.Command, sc.InfoDetail);
                            connType = CommStrings.CommWireless80211Ip.ToString();
                            if (res.Length > 1)
                            {
                                break;
                            }
                        }
                    }

                }
                
                if (res.Length == 1) //If it fails
                {
                    MothershipEvent.CreateSystemEvent(res[0],"", EventLogEntryType.Error);
                    doneWithRunErrors = true;
                    job.Response = "Error running the command";
                    job.Executed = DateTime.Now;
                    job.Status = 2;
                }
                else
                {
                    job.Response = MothershipLibrary.Tools.StringArrayToHtmlText(res);
                    job.Executed = DateTime.Now;
                    job.Status = 1; //0=Waiting, 1=Executed, 2=Error
                }

                db.Job.Attach(job);
                db.Entry(job).State = EntityState.Modified; 
                db.SaveChanges();

                scheduledJobs.Remove(refjob);
            }
            catch (Exception ex)
            {
                MothershipEvent.CreateSystemEvent("Job Scheduling Timer Job execution failed. Reason: " + ex.Message, "", EventLogEntryType.Error);
            }

        }
         
    }
}
