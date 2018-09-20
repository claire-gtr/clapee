class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.user == user
  end

  def edit?
    record.user == user
  end

  def destroy?
    (record.user == user) || user_is_admin?
  end

  private

  def user_is_admin?
    if user.nil?
      false
    else
      user.admin
    end
  end

end
