using System.Data;
using Npgsql;

namespace ConsoleApp1 {
    class Program {
        static void Main(string[] args) {

            TestDbmsCon();
            Console.ReadKey();

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
