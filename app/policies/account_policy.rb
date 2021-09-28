class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: @user.try(:id))
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    user_is_owner_of_record?
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    user == @record.user
  end
end
