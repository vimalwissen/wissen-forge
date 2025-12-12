class UserPolicy < ApplicationPolicy
  def show_profile?
    # User can see their own profile
    return true if user == record
    
    # Admins and Super Admins can see all profiles
    return true if user.admin? || user.super_admin?
    
    # Managers can see profiles of their subordinates (users in their allowed departments/teams)
    # For MVP simplicity: Managers can see employees in their department
    return true if user.role == "employee" && user.subordinates.include?(record) # If using subordinates logic
    
    # Or simpler role-based logic if subordinates association isn't fully set up yet:
    # return true if user.admin? # Already covered
    
    false
  end
end
