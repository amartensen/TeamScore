using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class video_video : System.Web.UI.Page
{
    public class video
    {
        public string videoID { get; set; }
        public string tmMemberID { get; set; }
        public string vid_title { get; set; }
        public string vid_location { get; set; }
        public string vid_tourny { get; set; }
        public string vid_school { get; set; }
    }

    [WebMethod]
    public static List<video> getMemberVideo(string tmMemberID)
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT videoID, tmMemberID, vid_title, vid_location, vid_tourny, vid_school FROM video WHERE (tmMemberID = @tmMemberID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@tmMemberID", tmMemberID);
            SqlDataReader reader = command.ExecuteReader();

            List<video> _videos = new List<video>();
            while (reader.Read())
            {
                _videos.Add(new video()
                {
                    tmMemberID = reader["tmMemberID"].ToString(),
                    videoID = reader["videoID"].ToString(),
                    vid_title = reader["vid_title"].ToString(),
                    vid_tourny = reader["vid_tourny"].ToString(),
                    vid_school = reader["vid_school"].ToString(),
                    vid_location = reader["vid_location"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _videos;
        }
    }

    [WebMethod]
    public static video[] getVideo(int videoID)
    {
        //MembershipUser user = Membership.GetUser();
        //string user_ID = user.ProviderUserKey.ToString();

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {


            string sql = "SELECT videoID, vid_title, vid_location FROM video WHERE (videoID = @videoID)";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);

            command.Parameters.AddWithValue("@videoID", videoID);
            SqlDataReader reader = command.ExecuteReader();

            var _video = new List<video>();
            while (reader.Read())
            {
                var tm = new video();
                tm.videoID = reader["videoID"].ToString();
                tm.vid_location = reader["vid_location"].ToString();
                tm.vid_title = reader["vid_title"].ToString();
                _video.Add(tm);
            }


            //Close connections
            reader.Close();
            connection.Close();

            return _video.ToArray();
        }
    }
}