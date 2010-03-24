class Handler
  def self.methods
    ['GET']
  end
  
  def self.regex
    /^\/handler\/(.+)$/
  end
  
  def self.get(request, id)
    Mineral::Response.new(200, {"Content-type" => "text/plain"}, id)
  end
end