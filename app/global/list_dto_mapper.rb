module Global
  ListDto = Struct.new(
    :user_id,
    :user_role,
    :company_id,
    :filters,
    :page,
    :order
  )

  class ListDtoMapper
    def run(current_user, req)
      page = req.params['page'] || {}
      order = req.params['order'] || {}

      ListDto.new(
        current_user.id,
        current_user.role,
        current_user.company_id,
        req.params['filter'] || {},
        page,
        order
      )
    end
  end
end
