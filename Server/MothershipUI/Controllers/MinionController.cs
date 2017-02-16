using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using MothershipLibrary;

namespace MothershipUI.Controllers
{
    public class MinionController : ApiController
    {
        private MothershipEntities db = new MothershipEntities();

        // GET: api/Minion
        public IQueryable<Client> GetClient()
        {
            return db.Client;
        }

        // GET: api/Minion/5
        [ResponseType(typeof(Client))]
        public async Task<IHttpActionResult> GetClient(Guid id)
        {
            Client client = await db.Client.FindAsync(id);
            if (client == null)
            {
                return NotFound();
            }

            return Ok(client);
        }

        // PUT: api/Minion/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutClient(Guid id, Client client)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != client.Id)
            {
                return BadRequest();
            }

            db.Entry(client).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ClientExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Minion
        [ResponseType(typeof(Client))]
        public async Task<IHttpActionResult> PostClient(Client client)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Client.Add(client);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ClientExists(client.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = client.Id }, client);
        }

        // DELETE: api/Minion/5
        [ResponseType(typeof(Client))]
        public async Task<IHttpActionResult> DeleteClient(Guid id)
        {
            Client client = await db.Client.FindAsync(id);
            if (client == null)
            {
                return NotFound();
            }

            db.Client.Remove(client);
            await db.SaveChangesAsync();

            return Ok(client);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ClientExists(Guid id)
        {
            return db.Client.Count(e => e.Id == id) > 0;
        }
    }
}