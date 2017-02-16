using MothershipLibrary.DataModels;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace MothershipMinionService
{
    static class Program
    {

        

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {
            try
            {                
                ServiceBase[] ServicesToRun;
                ServicesToRun = new ServiceBase[] 
            { 
                new MothershipMinionService() 
            };
                ServiceBase.Run(ServicesToRun);
                
            }
            catch (Exception ex)
            {
                
                throw;
            }

        

            
        }

       
    }
}
