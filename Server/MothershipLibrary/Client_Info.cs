//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MothershipLibrary
{
    using System;
    using System.Collections.Generic;
    
    public partial class Client_Info
    {
        public System.Guid ClientId { get; set; }
        public int InfoType { get; set; }
        public string InfoDetail { get; set; }
        public System.Guid Id { get; set; }
        public bool PreferredConnection { get; set; }
    
        public virtual Client Client { get; set; }
    }
}
