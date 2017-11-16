Amber::Server.configure do |app|
  pipeline :web do
    plug Amber::Pipe::Fast.new
  end

  routes :web do
    get "/db", BenchmarkController, :db
    get "/queries", BenchmarkController, :queries
    get "/updates", BenchmarkController, :updates
    get "/fortunes", BenchmarkController, :fortunes
    get "/plaintext", BenchmarkController, :plaintext
    get "/json", BenchmarkController, :json
  end
end
