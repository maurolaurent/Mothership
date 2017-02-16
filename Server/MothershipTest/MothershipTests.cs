using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MothershipLibrary.DataModels;
using System.Collections.Generic;

namespace MothershipTest
{
    [TestClass]
    public class MothershipTests
    {
        [TestMethod]
        public void ProbeMothership()
        {
            MothershipLibrary.Probes.MothershipProbe mpr = new MothershipLibrary.Probes.MothershipProbe();
            bool validMother = mpr.ProbeMothership();
            Assert.IsTrue(validMother);

        }

        [TestMethod]
        public void ProbeMinion()
        {
            MothershipLibrary.Probes.MothershipProbe mpr = new MothershipLibrary.Probes.MothershipProbe();
            bool validMinion = mpr.ProbeMinion();
            Assert.IsTrue(validMinion);

        }
    }

   
}
