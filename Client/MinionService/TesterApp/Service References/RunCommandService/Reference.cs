﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TesterApp.RunCommandService {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="RunCommandService.IRunCommandService")]
    public interface IRunCommandService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IRunCommandService/InvokeCommand", ReplyAction="http://tempuri.org/IRunCommandService/InvokeCommandResponse")]
        string[] InvokeCommand(string value);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IRunCommandService/InvokeCommand", ReplyAction="http://tempuri.org/IRunCommandService/InvokeCommandResponse")]
        System.Threading.Tasks.Task<string[]> InvokeCommandAsync(string value);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IRunCommandServiceChannel : TesterApp.RunCommandService.IRunCommandService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class RunCommandServiceClient : System.ServiceModel.ClientBase<TesterApp.RunCommandService.IRunCommandService>, TesterApp.RunCommandService.IRunCommandService {
        
        public RunCommandServiceClient() {
        }
        
        public RunCommandServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public RunCommandServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public RunCommandServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public RunCommandServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public string[] InvokeCommand(string value) {
            return base.Channel.InvokeCommand(value);
        }
        
        public System.Threading.Tasks.Task<string[]> InvokeCommandAsync(string value) {
            return base.Channel.InvokeCommandAsync(value);
        }
    }
}
