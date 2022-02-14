module Global
  ListDto = Struct.new(
    :company_id,
    :current_user_id,
    :filters,
    :page,
    :order
  )

  class ListDtoMapper
    def run(current_user, req)
      ListDto.new(
        current_user.company_id,
        current_user.id,
        req.params['filter'],
        req.params['page'],
        req.params['order']
      )
    end
  end
end
