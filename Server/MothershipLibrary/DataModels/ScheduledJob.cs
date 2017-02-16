using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace MothershipLibrary.DataModels
{
    public class ScheduledJob : Job
    {

        public ScheduledJob() {}

        public ScheduledJob(Job job) {
     
            Watch watch = new Watch(); //Utility watch
            
            Timer = new Timer(new TimerCallback(ProcessTimerEvent),
                                   watch,
                                   watch.GetMillisecondsFromDatetimes(job.Created,job.ToExecute),
                                   System.Threading.Timeout.Infinite //Supposedly, one time only
                                   );

        }

        public static Timer Timer { get; set; } //"Physically adding the watch, will be eventually disposed"

        public bool Started { get; set; }

        public bool Finished { get; set; }

        public int Countdown { get; set; }

        private void ProcessTimerEvent (object obj) //Equiping each job  with its own watch
        {
            if (!this.Started) //Can't process the event without Started being set
	        {
		        Started = true;
	        }
            --Countdown;
            // If countdown is complete, exit the program.
            if (Countdown == 0)
            {
                Finished = true;
                //Fire the job command
                Timer.Dispose();              
            }            
        }
    }

    class Watch
    {
        public string GetTimeString()
        {
            string str = DateTime.Now.ToString();
            int index = str.IndexOf(" ");
            return (str.Substring(index + 1));
        }

        public int GetMillisecondsFromDatetimes(DateTime start, DateTime end) {
            TimeSpan span = end - start;
            int ms = (int)span.TotalMilliseconds;
            return ms;
        }
    }

}

