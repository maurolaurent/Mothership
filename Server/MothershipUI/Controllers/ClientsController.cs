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
using MothershipLibrary.DataModels;

namespace MothershipUI.Controllers
{
   [Authorize]
    public class ClientsController : Controller
    {
        private MothershipEntities db = new MothershipEntities();

        // GET: Clients
        public async Task<ActionResult> Index()
        {
            var client = db.Client.Include(c => c.Client_Comm);
            return View(await client.ToListAsync());
        }

        // GET: Clients/Details/5
        public async Task<ActionResult> Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = await db.Client.FindAsync(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            return View(client);
        }

        // GET: Clients/Create
        public ActionResult Create()
        {
            ViewBag.Id = new SelectList(db.Client_Comm, "Id", "Id");
            return View();
        }

        // POST: Clients/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id,Name")] Client client)
        {
            if (ModelState.IsValid)
            {
                client.Id = Guid.NewGuid();
                db.Client.Add(client);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.Id = new SelectList(db.Client_Comm, "Id", "Id", client.Id);
            return View(client);
        }

        // GET: Clients/Edit/5
        public async Task<ActionResult> Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = await db.Client.FindAsync(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            ViewBag.Id = new SelectList(db.Client_Comm, "Id", "Id", client.Id);
            return View(client);
        }

        // POST: Clients/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,Name")] Client client)
        {
            if (ModelState.IsValid)
            {
                db.Entry(client).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Id = new SelectList(db.Client_Comm, "Id", "Id", client.Id);
            return View(client);
        }

        // GET: Clients/Delete/5
        public async Task<ActionResult> Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = await db.Client.FindAsync(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            return View(client);
        }

        // POST: Clients/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(Guid id)
        {
            Client client = await db.Client.FindAsync(id);
            db.Client.Remove(client);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<JsonResult> ProbeMinion(Guid? id) {

            string[] res = new string[] { };

            Client client = await db.Client.FindAsync(id);

            var _ip = from c in client.Client_Info                   
                      select c;

            string connType = string.Empty;

            if (_ip.Count() > 0)
            {
                foreach (Client_Info sc in _ip)
                {
                    if (sc.InfoType == (int)CommStrings.CommEthernetIp)
                    {
                        res = MothershipLibrary.Logic.MinionCommunication.RunCommand("ipconfig", sc.InfoDetail);
                        connType = CommStrings.CommEthernetIp.ToString();

                        Client_Info temp = db.Client_Info.Where(x => x.Id == sc.Id).FirstOrDefault();
                        temp.PreferredConnection = true;
                        db.Client_Info.Attach(temp);
                        db.Entry(temp).State = EntityState.Modified;
                        db.SaveChanges();
                    }

                    if (sc.InfoType == (int)CommStrings.CommWireless80211Ip)
                    { 
                        res = MothershipLibrary.Logic.MinionCommunication.RunCommand("ipconfig", sc.InfoDetail);
                        connType = CommStrings.CommWireless80211Ip.ToString();

                        Client_Info temp = db.Client_Info.Where(x => x.Id == sc.Id).FirstOrDefault();
                        temp.PreferredConnection = true;
                        db.Client_Info.Attach(temp);
                        db.Entry(temp).State = EntityState.Modified;
                        db.SaveChanges();
                    }
                }                     

            }

            if (res.Length > 0)
            {
                return Json(new string[] { "OK", connType }, JsonRequestBehavior.AllowGet);
            }
            else {
                return Json(new string[] { "Offline", "No Connection" }, JsonRequestBehavior.AllowGet);
            }

            
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
