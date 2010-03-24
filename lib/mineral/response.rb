module Mineral
  class Response
    attr_accessor :code
    attr_accessor :headers
    attr_accessor :body
    
    def initialize(*args)
      unless args.empty?
        if args.size == 1 && args[0].is_a?(Hash)
          opts = args[0]
          @code = opts[:code]
          @headers = opts[:headers]
          @body = opts[:body]
        else
          @code = args[0]
          @headers = args[1]
          @body = args[2]
        end
        @body = [@body] unless @body.is_a? Array
      end
    end
    
    def to_rack
      [@code, @headers, @body]
    end
  end
end