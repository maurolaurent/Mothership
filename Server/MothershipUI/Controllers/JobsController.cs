using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MothershipLibrary;
using System.ComponentModel.DataAnnotations;
using MothershipLibrary.DataModels;

namespace MothershipUI.Controllers
{
    [Authorize]
    public class JobsController : Controller
    {
        private MothershipEntities db = new MothershipEntities();

        // GET: Jobs
        public async Task<ActionResult> Index()
        {
            var job = db.Job.Include(j => j.Client1);
            return View(await job.OrderBy(x => x.Created).ToListAsync());
        }

        // GET: Jobs/Details/5
        public async Task<ActionResult> Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Job job = await db.Job.FindAsync(id);
            if (job == null)
            {
                return HttpNotFound();
            }
            return View(job);
        }

        // GET: Jobs/Create
        public ActionResult Create(Guid? clientId)
        {
            ViewBag.Client = clientId;
            return View();
        }

        // POST: Jobs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<JsonResult> Create([Bind(Include = "Name,ToExecute,Client,Command")] Job job, string executeImmediately)
        {
            bool IsModelValid = ModelState.IsValid;
            bool runImmediately = executeImmediately == "on" ? true : false;
            bool doneWithRunErrors = false; //If it fails this time, it will run later
            job.Created = DateTime.Now;
            job.Status = 0; 

            if (runImmediately)
            {
                job.ToExecute = job.Created;

                var context = new ValidationContext(ModelState, serviceProvider: null, items: null);
                var validationResults = new List<ValidationResult>();

                IsModelValid = Validator.TryValidateObject(ModelState, context, validationResults, true);
               
            }

            if (IsModelValid)
            {

                //If everything is OK, choose whenter to send or archive for the Mothership service to handle the scheduling
                if (runImmediately)
                {
                    try
                    {
                        string[] res = new string[] { };

                        Client client = await db.Client.FindAsync(job.Client);

                        var _ip = from c in client.Client_Info
                                  select c;

                        string connType = string.Empty;

                        if (_ip.Count() > 0)
                        {
                            foreach (Client_Info sc in _ip)
                            {
                                if (sc.InfoType == (int)CommStrings.CommEthernetIp)
                                {
                                    res = MothershipLibrary.Logic.MinionCommunication.RunCommand(job.Command, sc.InfoDetail);
                                    connType = CommStrings.CommEthernetIp.ToString();
                                    if (res.Length > 1)
                                    {
                                        break;
                                    }
                                }

                                if (sc.InfoType == (int)CommStrings.CommWireless80211Ip)
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
                            doneWithRunErrors = true;
                            job.Response = "<p>Error running the command</p>";
                            job.Executed = DateTime.Now;
                            job.Status = 2; 
                        }
                        else {
                            job.Response = MothershipLibrary.Tools.StringArrayToHtmlText(res);
                            job.Executed = DateTime.Now;
                            job.Status = 1; //0=Waiting, 1=Executed, 2=Error
                        }
                    }
                    catch (Exception)
                    {

                      //  throw;
                    }


                }               

                job.Id = Guid.NewGuid();
                db.Job.Add(job);

                if(!doneWithRunErrors && await db.SaveChangesAsync() > 0)                
                {
                    return Json(new string[] { "OK", "Job saved sucessfully." });
                }
                else if (doneWithRunErrors && await db.SaveChangesAsync() > 0) {
                    return Json(new string[] { "OK", "Job save with runtime errors. Command will be ran later on." });
                }
                else
                {
                    return Json(new string[] { "ERROR", "Job save error. Database write failure." });
                }
            }
            else { 
                return Json(new string[] { "ERROR", "Job save error. Input is invalid." });
            }
           
           
        }

        // GET: Jobs/Edit/5
        public async Task<ActionResult> Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Job job = await db.Job.FindAsync(id);
            if (job == null)
            {
                return HttpNotFound();
            }
            ViewBag.Client = new SelectList(db.Client, "Id", "Name", job.Client);
            return View(job);
        }

        // POST: Jobs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,Name,Created,ToExecute,Executed,Client,Command,Response,Status")] Job job)
        {
            if (ModelState.IsValid)
            {
                db.Entry(job).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Client = new SelectList(db.Client, "Id", "Name", job.Client);
            return View(job);
        }

        // GET: Jobs/Delete/5
        public async Task<ActionResult> Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Job job = await db.Job.FindAsync(id);
            if (job == null)
            {
                return HttpNotFound();
            }
            return View(job);
        }

        // POST: Jobs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(Guid id)
        {
            Job job = await db.Job.FindAsync(id);
            db.Job.Remove(job);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
