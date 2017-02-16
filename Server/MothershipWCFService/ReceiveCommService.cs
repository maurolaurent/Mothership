using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using MothershipLibrary;
using MothershipLibrary.Validations;
using MothershipLibrary.DataModels;
using MothershipWCFService.Logic;


namespace MothershipService
{
    
    public class ReceiveCommService : IReceiveCommService
    {
        /// <summary>Entry point for minion received data. Validates if communication is valid, then relays to facade.
        /// <para>- string[] values. Values of the communication. Header of array must be Comm Type:, otherwise invalid. Header can be extended with tokens for extra security.</para>
        /// </summary>
        public bool GetData(string[] values)
        {
            try
            {
                if (CommsValidation.ValidateIfValidCommunication(values[0]))
                {
                    return CommDigest.EstablishCommunication(values);
                }
                else {
                    throw new Exception("Minion message communication failed: Invalid communication header");
                }
            }
            catch (Exception ex)
            {
                MothershipEvent.CreateSystemEvent(ex.Message + " " + ex.StackTrace, "", System.Diagnostics.EventLogEntryType.Error);                
                return false;
            }

        }

        /// <summary>Validates is minion communication header is valid
        /// <para>- string p. Minion communication header.</para>
        /// </summary>
        

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }

    
}
