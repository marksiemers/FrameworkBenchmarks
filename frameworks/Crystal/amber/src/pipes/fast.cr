class Amber::Pipe::Fast < Amber::Pipe:Base
  macro context_with(content_type)
    context.response.status_code = 200
    context.response.headers["Server"] = "Amber"
    context.response.headers["Date"] = Time.now.to_s
    context.response.headers["Content-Type"] = {{content_type}}
  end

  def call(context : HTTP::Server::Context)
    case context.request.path
    when "/json"
      context_with "application/json"
      {message: "Hello, World!"}.to_json(context.response)
    when "/plaintext"
      context_with "text/plain"
      context.response.print "Hello, World!"
    else
      call_next(context)
    end
  end
end
