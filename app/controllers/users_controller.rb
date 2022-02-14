class UsersController
  def index(
    req,
    odt_builder = I::User::ListOdtBuilder,
    policy = I::User::ListPolicy,
    service = I::User::ListService,
    representation = I::User::ListRepresentation
  )
    odt = odt_builder.new(req.query_string).run
    policy.new(odt).run
    users = service.new.run(odt)
    response = representation.new(users).run

    [200, {'Content-Type' => 'application/json'}, response]
  end
end
