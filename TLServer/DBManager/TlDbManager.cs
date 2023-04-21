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
	public class TlDbManager : MySqlDapperManager
	{

		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="logger"></param>
		protected TlDbManager(Logger logger = null):base(logger)
		{ 
		}

        public TLServer.DAO.Config GetConfig()
        {
            try
            {
                return Conn.GetList<TLServer.DAO.Config>().First();
            }
            catch(Exception ex)
            {
                Error(ex);
                throw;

            }
        }

        public void UpdateConfig(TLServer.DAO.Config config)
        {
            try
            {
                Conn.Update(config);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public List<StringValue> GetRegions()
		{
            try
            {
                const string query = "SELECT DISTINCT Region AS Value FROM province ORDER BY Region";
                return Conn.Query<StringValue>(query).ToList();
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
				return Conn.GetList<Province>().ToList();
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
                string query = $"SELECT * FROM province WHERE region = {Apex(region)} ORDER BY Name";
                return Conn.Query<Province>(query).ToList();
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
                return Conn.GetList<City>().ToList();
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
                string query = $"SELECT * FROM city WHERE Province = {Apex(province)} ORDER BY Name";
                return Conn.Query<City>(query).ToList();
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
                return Conn.GetList<Role>().ToList();
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
                return Conn.GetList<Sex>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public User GetUserByEmail(string email)
		{
			try
			{
				string query = $"SELECT * FROM user WHERE Email = {Apex(email)}";
				return Conn.Query<User>(query).FirstOrDefault();
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
				Conn.Update(user);
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
				return Conn.GetList<FullUserView>().ToList();
			}
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public FullUserView GetFullUserByEmail(string email)
		{
            try
            {
                string query = $"SELECT * FROM fulluserview WHERE Email = {Apex(email)}";
                return Conn.Query<FullUserView>(query).FirstOrDefault();
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
                    Conn.Insert(user);

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
                    Conn.Insert(userData);

                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public UserData GetUserDataByEmail(string email)
        {
            try
            {
                string query = $"SELECT * FROM userdata WHERE Email = {Apex(email)}";
                return Conn.Query<UserData>(query).FirstOrDefault();
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
                    Conn.Update(user);
                    Conn.Update(userData);
                    ts.Complete();
                }

            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void UpdateUserData(UserData userData)
        {
            try
            {
                Conn.Update(userData);
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
                return Conn.GetList<SlotStatus>().ToList();
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

                return Conn.Query<FullSlotView>(query).ToList();
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

                List<Slot> slots = Conn.Query<Slot>(fullQuery).ToList();
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
                Conn.Insert(slot);
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
                return Conn.Get<Slot>(id);
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
                Conn.Update(slot);
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
                Conn.Delete<Slot>(id);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<FullAnthropometryView> GetAnthropometries(string email)
        {
            try
            {
                string query = $"SELECT * FROM fullanthropometryview WHERE Email = {Apex(email)}";
                return Conn.Query<FullAnthropometryView>(query).ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public FullAnthropometryView GetAnthropometryById(int id)
        {
            try
            {
                string query = $"SELECT * FROM fullanthropometryview where Id = {id}";
                return Conn.Query<FullAnthropometryView>(query).FirstOrDefault();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void NewAnthropometry(Anthropometry anthropometry)
        {
            try
            {
                Conn.Insert(anthropometry);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void UpdateAnthropometry(Anthropometry anthropometry)
        {
            try
            {
                Conn.Update(anthropometry);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<Plicometry> GetPlicometries(string email)
        {
            try
            {
                string query = $"SELECT * FROM plicometry WHERE Email = {Apex(email)}";
                return Conn.Query<Plicometry>(query).ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public Plicometry GetPlicometryById(int id)
        {
            try
            {
                return Conn.Get<Plicometry>(id);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void NewPlicometry(Plicometry plicometry)
        {
            try
            {
                Conn.Insert(plicometry);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void UpdatePlicometry(Plicometry plicometry)
        {
            try
            {
                Conn.Update(plicometry);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public List<MuscularGroup> GetMuscularGroups()
        {
            try
            {
                return Conn.GetList<MuscularGroup>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public MuscularGroup GetMuscularGroupById(int id)
        {
            try
            {
                return Conn.Get<MuscularGroup>(id);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public MuscularGroup GetMuscularGroupByName(string name)
        {
            try
            {
                string query = string.Format("SELECT * FROM musculargroup WHERE name = {0}", Apex(name));
                return Conn.Query<MuscularGroup>(query).FirstOrDefault();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void NewMuscularGroup(MuscularGroup muscularGroup)
        {
            try
            {
                Conn.Insert(muscularGroup);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }
        
        public void UpdateMuscularGroup(MuscularGroup muscularGroup)
        {
            try
            {
                Conn.Update(muscularGroup);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }
        
        public void DeleteMuscularGroup(int Id)
        {
            try
            {
                Conn.Delete<MuscularGroup>(Id);
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

    }
}

