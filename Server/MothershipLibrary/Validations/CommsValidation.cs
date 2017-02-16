using MothershipLibrary.DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MothershipLibrary.Validations
{
    public class CommsValidation
    {

        public static bool ValidateIfValidCommunication(string p)
        {
            return p.Contains(CommStrings.Tier1MothershipCommunicationMessageT1MSCOMM.ToString());
        }

    }
}
