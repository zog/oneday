class DayPolicy < AdminPolicy
  def show?
    true
  end

  def edit?
    only_super_admin || user == record.user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
