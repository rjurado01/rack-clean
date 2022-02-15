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
      ListDto.new(
        current_user.id,
        current_user.role,
        current_user.company_id,
        req.params['filter'],
        req.params['page'],
        req.params['order']
      )
    end
  end
end
