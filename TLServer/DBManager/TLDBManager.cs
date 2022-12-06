using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using Dapper;
using Org.BouncyCastle.Asn1.X509.Qualified;
using RMLibs.basic;
using RMLibs.Logging;
using RMLibs.SQLDBManager.MySql;
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

		public List<FullUser> GetFullUsers()
		{
			try
			{
				return conn.GetList<FullUser>().ToList();
			}
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public FullUser GetFullUserByEmail(string Email)
		{
            try
            {
                string query = String.Format("SELECT * FROM fulluser WHERE Email = {0}", Apex(Email));
                return conn.Query<FullUser>(query).FirstOrDefault();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public void NewUser(FullUser fullUser)
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

        public void UpdateUser(FullUser fullUser)
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
	}
}

