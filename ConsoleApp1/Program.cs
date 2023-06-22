using System.Data;
using Npgsql;

namespace ConsoleApp1 {
    class Program {
        static void Main(string[] args) {

            // TestDbmsCon();
            InsertTool();
            Console.ReadKey();

        }

        private static void InsertTool() {
            using (NpgsqlConnection con = GetConnection()) {
                string query = @"INSERT INTO tool (""name"", description) VALUES ('Шуруповерт Makita 2', 'Классная штука этот шурик')";
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
