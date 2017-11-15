class Amber::Pipe::Fast < Amber::Pipe:Base
  def call(context : HTTP::Server::Context)
    case context.request.path
    when "/json"
      context.response.status_code = 200
      context.response.headers["Content-Type"] = "application/json"
      {message: "Hello, World!"}.to_json(context.response)
    when "/plaintext"
      context.response.status_code = 200
      context.response.headers["Content-Type"] = "text/plain"
      context.response.print "Hello, World!"
    else
      call_next(context)
    end
  end
end
