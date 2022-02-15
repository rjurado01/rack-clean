require './i'

class ValidateError < StandardError
  def initialize(message)
    super(message.to_json)
  end
end

class UnauthorizedError < StandardError; end
class NotFoundError < StandardError; end

# binding.pry

class App
  def call(env)
    req = Rack::Request.new(env)

    if req.path_info == '/users' && req.get?
      Accounts::Users::ListController.new.run(req)
    elsif req.path_info == '/users' && req.post?
      Accounts::Users::CreateController.new.run(req)
    else
      [200, {'Content-Type' => 'text/plain'}, "Hello from Rack 3: #{env}"]
    end
  rescue UnauthorizedError
    [403, nil, '']
  rescue NotFoundError
    [404, nil, '']
  rescue ValidateError => e
    [422, {'Content-Type' => 'application/json'}, e.message]
  end
end
