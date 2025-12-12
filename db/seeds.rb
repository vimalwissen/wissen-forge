# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Cleaning up database..."
UserBadge.destroy_all
Submission.destroy_all
Assignment.destroy_all
Quiz.destroy_all
Enrollment.destroy_all
Training.destroy_all
User.destroy_all
Badge.destroy_all

puts "Creating Badges..."
silver = Badge.create!(name: "Silver Scholar", level: :silver, criteria: "25 Learning Hours", image_url: "https://via.placeholder.com/150/C0C0C0/FFFFFF?text=Silver")
gold = Badge.create!(name: "Gold Guru", level: :gold, criteria: "50 Learning Hours", image_url: "https://via.placeholder.com/150/FFD700/FFFFFF?text=Gold")
platinum = Badge.create!(name: "Platinum Pro", level: :platinum, criteria: "100 Learning Hours", image_url: "https://via.placeholder.com/150/E5E4E2/000000?text=Platinum")

puts "Creating Users..."
# Super Admin
super_admin = User.create!(
  name: "Super Admin",
  email: "superadmin@wissen.com",
  password: "password",
  role: :super_admin,
  designation: "Chief Learning Officer",
  department: "HR"
)

# Admin
admin = User.create!(
  name: "Admin User",
  email: "admin@wissen.com",
  password: "password",
  role: :admin,
  designation: "L&D Manager",
  department: "L&D"
)

# Manager
manager = User.create!(
  name: "Manager Mike",
  email: "manager@wissen.com",
  password: "password",
  role: :employee, # Managers are employees with subordinates
  designation: "Engineering Manager",
  department: "Engineering"
)

# Employees reporting to Manager
emp1 = User.create!(
  name: "Alice Engineer",
  email: "alice@wissen.com",
  password: "password",
  role: :employee,
  designation: "Senior Developer",
  department: "Engineering",
  manager: manager
)

emp2 = User.create!(
  name: "Bob Developer",
  email: "bob@wissen.com",
  password: "password",
  role: :employee,
  designation: "Junior Developer",
  department: "Engineering",
  manager: manager
)

# Independent Employee
emp3 = User.create!(
  name: "Charlie Design",
  email: "charlie@wissen.com",
  password: "password",
  role: :employee,
  designation: "UI/UX Designer",
  department: "Design"
)

puts "Creating Trainings..."
t1 = Training.create!(
  title: "Ruby on Rails Advanced Patterns",
  description: "Deep dive into Rails internals and patterns.",
  training_type: :classroom,
  mode: :optional,
  start_time: 2.days.from_now,
  end_time: 2.days.from_now + 4.hours,
  capacity: 20,
  instructor: "DHH",
  department_target: "Engineering",
  status: :published
)

t2 = Training.create!(
  title: "Cybersecurity Awareness 2025",
  description: "Mandatory security training for all employees.",
  training_type: :online,
  mode: :mandatory,
  start_time: 1.week.from_now,
  end_time: 1.week.from_now + 2.hours,
  capacity: 1000,
  instructor: "SecTeam",
  status: :published
)

t3 = Training.create!(
  title: "Design Systems 101",
  description: "Introduction to our new design system.",
  training_type: :classroom,
  mode: :optional,
  start_time: 3.days.from_now,
  end_time: 3.days.from_now + 6.hours,
  capacity: 15,
  instructor: "Charlie Design",
  department_target: "Design",
  status: :pending_approval # Needs approval
)

# Past Training (for badges history)
t_past_1 = Training.create!(
  title: "React Fundamentals",
  description: "Basic React concepts.",
  training_type: :online,
  mode: :optional,
  start_time: 1.month.ago,
  end_time: 1.month.ago + 10.hours,
  capacity: 50,
  instructor: "Frontend Lead",
  status: :published
)

t_past_2 = Training.create!(
  title: "Cloud Architecture",
  description: "AWS basics.",
  training_type: :classroom,
  mode: :optional,
  start_time: 2.months.ago,
  end_time: 2.months.ago + 20.hours, # Long training
  capacity: 30,
  instructor: "Cloud Team",
  status: :published
)

puts "Creating Enrollments & History..."
# Manager Mike History
Enrollment.create!(user: manager, training: t_past_1, status: :completed, completion_date: 1.month.ago, score: 95)
Enrollment.create!(user: manager, training: t_past_2, status: :completed, completion_date: 2.months.ago, score: 88)
# Award Silver Badge to Manager (25+ hours) - Manual award since service isn't called here
UserBadge.create!(user: manager, badge: silver, awarded_at: Time.current)

# Alice's Enrollments
Enrollment.create!(user: emp1, training: t1, status: :enrolled)
Enrollment.create!(user: emp1, training: t2, status: :enrolled)

# Bob's Enrollments
Enrollment.create!(user: emp2, training: t2, status: :enrolled)

puts "Creating Assignments..."
Assignment.create!(
  training: t1,
  title: "Refactor Legacy Controller",
  description: "Apply the service object pattern to the provided controller code.",
  due_date: 3.days.from_now
)

puts "Seeding completed successfully!"
puts "Login Credentials:"
puts "Super Admin: superadmin@wissen.com / password"
puts "Admin: admin@wissen.com / password"
puts "Manager: manager@wissen.com / password"
puts "Employee: alice@wissen.com / password"
