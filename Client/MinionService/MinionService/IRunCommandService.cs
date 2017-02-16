using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace MinionService
{
    [ServiceContract]
    public interface IRunCommandService
    {

        [OperationContract]
        string[] InvokeCommand(string value);

   //     [OperationContract]
      //  CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here
    }

}
