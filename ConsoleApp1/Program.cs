using System.Data;
using Npgsql;

namespace ConsoleApp1 {
    class Program {
        static void Main(string[] args) {

            // TestDbmsCon();
            // InsertTool();
            ReadTools();
            Console.ReadKey();

        }

        private static void ReadTools() {
            using (NpgsqlConnection con = GetConnection()) {
                // string query = @"SELECT * FROM tool";
                string query = @"SELECT * FROM tools_api.ui_get_tools()";
                NpgsqlCommand cmd = new NpgsqlCommand(query, con);
                con.Open();

                int val;
                NpgsqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read()) {

                    Console.WriteLine(reader[0].ToString());
                    Console.WriteLine(reader[1].ToString());
                    Console.WriteLine(reader[2].ToString());
                    Console.WriteLine("-------------------------");
                }

                con.Close(); //close the current connection

            }
        }

        private static void InsertTool() {
            using (NpgsqlConnection con = GetConnection()) {
                string query = @"INSERT INTO tool (""name"", description) VALUES ('Шуруповерт Makita 3', 'Классная штука этот шурик')";
                NpgsqlCommand cmd = new NpgsqlCommand(query, con);
                con.Open();
                int n = cmd.ExecuteNonQuery();
                if (n == 1) {
                    Console.WriteLine("Record Inserted");
                }
            }
        }

        private static void TestDbmsCon() {
            using (NpgsqlConnection con = GetConnection()) {
                con.Open();
                if (con.State == ConnectionState.Open ) {
                    Console.WriteLine("Connected");
                }
            }
        }

        private static NpgsqlConnection GetConnection() {
            return new NpgsqlConnection(@"Server=localhost;Port=5432;User Id=my_tools_ta;Password=6FsXDeF9a6;Database=db_my_tools;Pooling=true;SearchPath=tools_api;");
        }
    }
}
