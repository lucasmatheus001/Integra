module UsersHelper
  def find_user_by_id(id)
    user = User.where(id: id).first
    user.present? ? user.name : 'Usuário não encontrado'
  end
end
