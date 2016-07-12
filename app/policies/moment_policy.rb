class MomentPolicy < AdminPolicy
  def show?
    true
  end

  def edit?
    only_super_admin || user == record.day.user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
