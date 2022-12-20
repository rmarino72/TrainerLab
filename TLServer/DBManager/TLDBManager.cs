using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using Dapper;
using RMLibs.Logging;
using RMLibs.SQLDBManager.MySql;
using RMLibs.Utilities;
using TLServer.BO;
using TLServer.DAO;

namespace TLServer.DBManager
{
	public class TLDBManager : MySqlDapperManager
	{

		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="logger"></param>
		protected TLDBManager(Logger logger = null):base(logger)
		{ 
		}

		public List<StringValue> GetRegions()
		{
            try
            {
                string query = String.Format("SELECT DISTINCT Region AS Value FROM province ORDER BY Region");
				return conn.Query<StringValue>(query).ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }

        }

		public List<Province> GetProvinces()
		{
			try
			{
				return conn.GetList<Province>().ToList();
			}
			catch (Exception ex)
			{
				Error(ex);
				throw;
			}
		}

        public List<Province> GetProvincesByRegion(string region)
        {
            try
            {
                string query = string .Format("SELECT * FROM province WHERE region = {0} ORDER BY Name", Apex(region));
                return conn.Query<Province>(query).ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<City> GetCities()
		{
            try
            {
                return conn.GetList<City>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }
        
        public List<City> GetCitiesByProvince(string province)
        {
            try
            {
                string query = string.Format("SELECT * FROM city WHERE Province = {0} ORDER BY Name", Apex(province));
                return conn.Query<City>(query).ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<Role> GetRoles()
        {
            try
            {
                return conn.GetList<Role>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;

            }
        }

        public List<Sex> GetSexes()
		{
            try
            {
                return conn.GetList<Sex>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public User GetUserByEmail(string Email)
		{
			try
			{
				string query = String.Format("SELECT * FROM user WHERE Email = {0}", Apex(Email));
				return conn.Query<User>(query).FirstOrDefault();
			}
			catch (Exception ex)
			{
				Error(ex);
				throw;
			}
		}

		public void UpdateUser(User user)
		{
			try
			{
				user.LastUpdateDateTime = DateTime.Now;
				conn.Update(user);
			}
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public List<FullUserView> GetFullUsers()
		{
			try
			{
				return conn.GetList<FullUserView>().ToList();
			}
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public FullUserView GetFullUserByEmail(string Email)
		{
            try
            {
                string query = String.Format("SELECT * FROM fulluserview WHERE Email = {0}", Apex(Email));
                return conn.Query<FullUserView>(query).FirstOrDefault();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void NewUser(FullUserView fullUser)
        {
            try
            {
                using (TransactionScope ts = CreateTransactionScope())
                {
                    User user = new User();
                    user.Email = fullUser.Email;
                    user.Password = "na";
                    user.Role = fullUser.Role;
                    user.CreationDateTime = DateTime.Now;
                    user.LastUpdateDateTime = DateTime.Now;
                    conn.Insert(user);

                    UserData userData = new UserData();
                    userData.AddressStreet = fullUser.AddressStreet;
                    userData.AddressStreetNumber = fullUser.AddressStreetNumber;
                    userData.BirthDate = fullUser.BirthDate;
                    userData.CAP = fullUser.CAP;
                    userData.City = fullUser.City;
                    userData.Email = fullUser.Email;
                    userData.FirstName = fullUser.FirstName;
                    userData.LastName = fullUser.LastName;
                    userData.LastUpdateDateTime = DateTime.Now;
                    userData.Phone = fullUser.Phone;
                    userData.Province = string.IsNullOrEmpty(fullUser.Province) ? null : fullUser.Province;
                    userData.Region = fullUser.Region;
                    userData.Sex = fullUser.Sex;
                    conn.Insert(userData);

                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public UserData GetUserDataByEmail(string Email)
        {
            try
            {
                string query = String.Format("SELECT * FROM userdata WHERE Email = {0}", Apex(Email));
                return conn.Query<UserData>(query).FirstOrDefault();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void UpdateUser(FullUserView fullUser)
        {
            try
            {
                User user = GetUserByEmail(fullUser.Email);
                UserData userData = GetUserDataByEmail(fullUser.Email);

                user.Role = fullUser.Role;
                user.LastUpdateDateTime = DateTime.Now;

                userData.AddressStreet = fullUser.AddressStreet;
                userData.AddressStreetNumber = fullUser.AddressStreetNumber;
                userData.BirthDate = fullUser.BirthDate;
                userData.CAP = fullUser.CAP;
                userData.City = fullUser.City;                
                userData.FirstName = fullUser.FirstName;
                userData.LastName = fullUser.LastName;
                userData.LastUpdateDateTime = DateTime.Now;
                userData.Phone = fullUser.Phone;
                userData.Province = string.IsNullOrEmpty(fullUser.Province) ? null: fullUser.Province;
                userData.Region = fullUser.Region;
                userData.Sex = fullUser.Sex;

                using (TransactionScope ts = CreateTransactionScope())
                {
                    conn.Update(user);
                    conn.Update(userData);
                    ts.Complete();
                }

            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<SlotStatus> GetSlotStatuses()
        {
            try
            {
                return conn.GetList<SlotStatus>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<FullSlotView> GetSlotByInterval(DateTimeInterval interval)
        {
            try
            {
                string query = string.Format(
                    "SELECT * FROM fullslotview WHERE StartDateTime >= {0} AND EndDateTime < {1} ORDER BY StartDateTime",
                    Apex(DateTimeUtils.DateTimeToMySqlString(interval.Start)),
                    Apex(DateTimeUtils.DateTimeToMySqlString(interval.End))
                    );

                return conn.Query<FullSlotView>(query).ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public bool VerifySlot(Slot slot)
        {
            try
            {
                string stdt = DateTimeUtils.DateTimeToMySqlString(slot.StartDateTime);
                string eddt = DateTimeUtils.DateTimeToMySqlString(slot.EndDateTime);
                string query = "" +
                    "SELECT * " +
                    "FROM slot " +
                    "WHERE Id <> {0} " +
                    "AND (" +
                    "   ({1} >= slot.StartDateTime AND {2} < slot.EndDateTime) OR" +
                    "   ({3} > slot.StartDateTime AND {4} <= slot.EndDateTime))";

                string fullQuery = string.Format(query, slot.Id, Apex(stdt), Apex(stdt), Apex(eddt), Apex(eddt));

                List<Slot> slots = conn.Query<Slot>(fullQuery).ToList();
                return slots.Count == 0;
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void NewSlot(Slot slot)
        {
            try
            {
                conn.Insert(slot);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public Slot GetSlotById(int id)
        {
            try
            {
                return conn.Get<Slot>(id);
            }
            catch(Exception ex)
            {
                Error(ex);
                throw;

            }
        }

        public void UpdateSlot(Slot slot)
        {
            try
            {
                conn.Update(slot);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void DeleteSlot(int id)
        {
            try
            {
                conn.Delete<Slot>(id);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }
	}
}

