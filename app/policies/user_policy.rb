class UserPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.admin?
  end

  def show?
    @user.admin?
  end

  def gerencial?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

end
