require './i'

class ValidateError < StandardError
  def initialize(message)
    super(message.to_json)
  end
end

class App
  def call(env)
    req = Rack::Request.new(env)

    if req.path_info == '/users' && req.get?
      users = Accounts::ListUsersService.new.run

      [200, {'Content-Type' => 'application/json'}, users.to_json]
    elsif req.path_info == '/users' && req.post?
      params = JSON.parse(req.body.read, symbolize_names: true)
      result = Accounts::CreateUserService.new.run(params)

      [201, {'Content-Type' => 'application/json'}, result]
    else
      [200, {'Content-Type' => 'text/plain'}, "Hello from Rack 3: #{env}"]
    end
  rescue ValidateError => e
    [422, {'Content-Type' => 'application/json'}, e.message]
  end
end
