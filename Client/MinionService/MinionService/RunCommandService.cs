using MinionService.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace MinionService
{

    public class RunCommandService : IRunCommandService
    {
        public string[] InvokeCommand(string value)
        {
            CommandRunner cr = new CommandRunner(); //If left static, would append the results rather than returning a new set

            return cr.InvokeCommand(value); 
        }

       /* public CompositeType GetDataUsingDataContract(CompositeType composite)
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
        }*/
    }
   
}
