# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🧹 Cleaning up database..."
UserBadge.destroy_all
Submission.destroy_all
Assignment.destroy_all
Quiz.destroy_all
Enrollment.destroy_all
Training.destroy_all
User.destroy_all
Badge.destroy_all

puts "🏅 Creating Badges..."
silver = Badge.create!(name: "Silver Scholar", level: :silver, criteria: "25 Learning Hours", image_url: "https://via.placeholder.com/150/C0C0C0/FFFFFF?text=Silver")
gold = Badge.create!(name: "Gold Guru", level: :gold, criteria: "50 Learning Hours", image_url: "https://via.placeholder.com/150/FFD700/FFFFFF?text=Gold")
platinum = Badge.create!(name: "Platinum Pro", level: :platinum, criteria: "100 Learning Hours", image_url: "https://via.placeholder.com/150/E5E4E2/000000?text=Platinum")

puts "👥 Creating Users..."

# Super Admin
super_admin = User.create!(
  name: "Vikram Sharma",
  email: "superadmin@wissen.com",
  password: "password",
  role: :super_admin,
  designation: "Chief Learning Officer",
  department: "Executive"
)

# Admin
admin = User.create!(
  name: "Priya Patel",
  email: "admin@wissen.com",
  password: "password",
  role: :admin,
  designation: "L&D Manager",
  department: "HR"
)

# Engineering Manager
eng_manager = User.create!(
  name: "Rajesh Kumar",
  email: "rajesh@wissen.com",
  password: "password",
  role: :employee,
  designation: "Engineering Director",
  department: "Engineering"
)

# Design Manager
design_manager = User.create!(
  name: "Sneha Reddy",
  email: "sneha@wissen.com",
  password: "password",
  role: :employee,
  designation: "Design Lead",
  department: "Design"
)

# Sales Manager
sales_manager = User.create!(
  name: "Amit Singh",
  email: "amit@wissen.com",
  password: "password",
  role: :employee,
  designation: "Sales Director",
  department: "Sales"
)

# Engineering Team (reports to Rajesh)
alice = User.create!(
  name: "Alice Johnson",
  email: "alice@wissen.com",
  password: "password",
  role: :employee,
  designation: "Senior Developer",
  department: "Engineering",
  manager: eng_manager
)

bob = User.create!(
  name: "Bob Williams",
  email: "bob@wissen.com",
  password: "password",
  role: :employee,
  designation: "Full Stack Developer",
  department: "Engineering",
  manager: eng_manager
)

charlie = User.create!(
  name: "Charlie Brown",
  email: "charlie@wissen.com",
  password: "password",
  role: :employee,
  designation: "Junior Developer",
  department: "Engineering",
  manager: eng_manager
)

# Design Team (reports to Sneha)
david = User.create!(
  name: "David Chen",
  email: "david@wissen.com",
  password: "password",
  role: :employee,
  designation: "UI Designer",
  department: "Design",
  manager: design_manager
)

eva = User.create!(
  name: "Eva Martinez",
  email: "eva@wissen.com",
  password: "password",
  role: :employee,
  designation: "UX Researcher",
  department: "Design",
  manager: design_manager
)

# Sales Team (reports to Amit)
frank = User.create!(
  name: "Frank Wilson",
  email: "frank@wissen.com",
  password: "password",
  role: :employee,
  designation: "Sales Executive",
  department: "Sales",
  manager: sales_manager
)

grace = User.create!(
  name: "Grace Lee",
  email: "grace@wissen.com",
  password: "password",
  role: :employee,
  designation: "Account Manager",
  department: "Sales",
  manager: sales_manager
)

puts "📚 Creating Trainings..."

# === PAST TRAININGS (Completed) ===

# Past Training 1 - Completed by many (30 hours)
t_security_basics = Training.create!(
  title: "Cybersecurity Fundamentals",
  description: "Essential security practices for all employees. Learn about password hygiene, phishing prevention, and secure data handling.",
  training_type: :online,
  mode: :mandatory,
  start_time: 3.months.ago,
  end_time: 3.months.ago + 30.hours,
  capacity: 100,
  instructor: "Security Team",
  status: :published,
  assignment_scope: :assign_all,
  skills: ["Security Awareness", "Phishing Prevention", "Data Privacy"]
)

# Past Training 2 - Completed by Engineering (25 hours)
t_react_advanced = Training.create!(
  title: "React & Redux Masterclass",
  description: "Advanced React patterns, Redux toolkit, and performance optimization techniques.",
  training_type: :online,
  mode: :optional,
  start_time: 2.months.ago,
  end_time: 2.months.ago + 25.hours,
  capacity: 50,
  instructor: "Alice Johnson",
  department_target: "Engineering",
  status: :published,
  assignment_scope: :assign_department,
  target_departments: ["Engineering"],
  skills: ["React", "Redux", "JavaScript", "Frontend Performance"]
)

# Past Training 3 - Completed by some (20 hours)
t_cloud_aws = Training.create!(
  title: "AWS Cloud Practitioner",
  description: "Comprehensive introduction to AWS services, cloud architecture, and best practices.",
  training_type: :classroom,
  mode: :optional,
  start_time: 2.months.ago + 10.days,
  end_time: 2.months.ago + 10.days + 20.hours,
  capacity: 30,
  instructor: "Cloud Solutions Team",
  status: :published,
  assignment_scope: :assign_all,
  skills: ["AWS", "Cloud Computing", "S3", "EC2"]
)

# Past Training 4 - Design specific (15 hours)
t_figma_pro = Training.create!(
  title: "Figma Pro Workflows",
  description: "Master Figma components, auto-layout, and design systems for scalable UI design.",
  training_type: :online,
  mode: :optional,
  start_time: 1.month.ago,
  end_time: 1.month.ago + 15.hours,
  capacity: 25,
  instructor: "Sneha Reddy",
  department_target: "Design",
  status: :published,
  assignment_scope: :assign_department,
  target_departments: ["Design"],
  skills: ["Figma", "UI Design", "Design Systems", "Prototyping"]
)

# Past Training 5 - Sales specific (10 hours)
t_sales_excellence = Training.create!(
  title: "Sales Excellence Program",
  description: "Advanced sales techniques, negotiation skills, and client relationship management.",
  training_type: :classroom,
  mode: :mandatory,
  start_time: 1.month.ago + 5.days,
  end_time: 1.month.ago + 5.days + 10.hours,
  capacity: 20,
  instructor: "Amit Singh",
  department_target: "Sales",
  status: :published,
  assignment_scope: :assign_department,
  target_departments: ["Sales"],
  skills: ["Sales Strategy", "Negotiation", "CRM"]
)

# Past Training 6 - Leadership (50 hours) - For managers
t_leadership = Training.create!(
  title: "Leadership Excellence Program",
  description: "Comprehensive leadership training covering team management, strategic thinking, and executive presence.",
  training_type: :classroom,
  mode: :mandatory,
  start_time: 4.months.ago,
  end_time: 4.months.ago + 50.hours,
  capacity: 15,
  instructor: "External Consultant - John Maxwell",
  status: :published,
  assignment_scope: :assign_specific,
  target_user_ids: [eng_manager.id, design_manager.id, sales_manager.id],
  skills: ["Leadership", "Team Management", "Strategic Planning", "Emotional Intelligence"]
)

# === UPCOMING TRAININGS ===

t_rails_advanced = Training.create!(
  title: "Ruby on Rails 8 Advanced Patterns",
  description: "Deep dive into Rails 8 features including Hotwire, Turbo Frames, and Stimulus controllers.",
  training_type: :classroom,
  mode: :optional,
  start_time: 5.days.from_now,
  end_time: 5.days.from_now + 8.hours,
  capacity: 20,
  instructor: "DHH (Video)",
  department_target: "Engineering",
  status: :published,
  assignment_scope: :assign_department,
  target_departments: ["Engineering"],
  skills: ["Ruby on Rails", "Hotwire", "Turbo", "Stimulus"]
)

t_compliance_2025 = Training.create!(
  title: "Annual Compliance Training 2025",
  description: "Mandatory annual compliance training covering ethics, harassment prevention, and workplace policies.",
  training_type: :online,
  mode: :mandatory,
  start_time: 1.week.from_now,
  end_time: 1.week.from_now + 4.hours,
  capacity: 500,
  instructor: "HR Team",
  status: :published,
  assignment_scope: :assign_all,
  skills: ["Compliance", "Ethics", "Workplace Safety"]
)

t_ai_ml = Training.create!(
  title: "AI/ML for Business Leaders",
  description: "Understanding AI and Machine Learning applications for business decision making.",
  training_type: :online,
  mode: :optional,
  start_time: 2.weeks.from_now,
  end_time: 2.weeks.from_now + 12.hours,
  capacity: 40,
  instructor: "Tech Innovation Team",
  status: :published,
  assignment_scope: :assign_all,
  skills: ["Artificial Intelligence", "Machine Learning", "Data Strategy"]
)

# Pending Approval Training (created by Admin, needs Super Admin approval)
t_agile_scrum = Training.create!(
  title: "Agile & Scrum Certification Prep",
  description: "Prepare for your Agile Scrum certification with hands-on exercises and mock exams.",
  training_type: :classroom,
  mode: :mandatory,
  start_time: 3.weeks.from_now,
  end_time: 3.weeks.from_now + 16.hours,
  capacity: 25,
  instructor: "Certified Scrum Trainer",
  status: :pending_approval,
  assignment_scope: :assign_department,
  target_departments: ["Engineering", "Design"],
  skills: ["Agile", "Scrum", "Project Management"]
)

puts "📝 Creating Enrollments & Completions..."

# === SECURITY BASICS - Mandatory for all (Most people completed) ===
[eng_manager, alice, bob, charlie, design_manager, david, eva, sales_manager, frank].each do |user|
  Enrollment.create!(user: user, training: t_security_basics, status: :completed, completion_date: 3.months.ago + 2.days, score: rand(80..100), attendance: true)
end
# Grace hasn't completed yet
Enrollment.create!(user: grace, training: t_security_basics, status: :enrolled, attendance: false)

# === REACT ADVANCED - Engineering only ===
Enrollment.create!(user: alice, training: t_react_advanced, status: :completed, completion_date: 2.months.ago + 3.days, score: 95, attendance: true)
Enrollment.create!(user: bob, training: t_react_advanced, status: :completed, completion_date: 2.months.ago + 3.days, score: 88, attendance: true)
Enrollment.create!(user: charlie, training: t_react_advanced, status: :completed, completion_date: 2.months.ago + 5.days, score: 82, attendance: true)
Enrollment.create!(user: eng_manager, training: t_react_advanced, status: :completed, completion_date: 2.months.ago + 2.days, score: 90, attendance: true)

# === AWS CLOUD - Some completed ===
Enrollment.create!(user: alice, training: t_cloud_aws, status: :completed, completion_date: 2.months.ago + 15.days, score: 92, attendance: true)
Enrollment.create!(user: bob, training: t_cloud_aws, status: :completed, completion_date: 2.months.ago + 14.days, score: 85, attendance: true)
Enrollment.create!(user: eng_manager, training: t_cloud_aws, status: :completed, completion_date: 2.months.ago + 12.days, score: 88, attendance: true)

# === FIGMA PRO - Design team ===
Enrollment.create!(user: david, training: t_figma_pro, status: :completed, completion_date: 1.month.ago + 2.days, score: 96, attendance: true)
Enrollment.create!(user: eva, training: t_figma_pro, status: :completed, completion_date: 1.month.ago + 3.days, score: 94, attendance: true)
Enrollment.create!(user: design_manager, training: t_figma_pro, status: :completed, completion_date: 1.month.ago + 1.day, score: 89, attendance: true)

# === SALES EXCELLENCE - Sales team ===
Enrollment.create!(user: frank, training: t_sales_excellence, status: :completed, completion_date: 1.month.ago + 7.days, score: 91, attendance: true)
Enrollment.create!(user: grace, training: t_sales_excellence, status: :completed, completion_date: 1.month.ago + 7.days, score: 88, attendance: true)
Enrollment.create!(user: sales_manager, training: t_sales_excellence, status: :completed, completion_date: 1.month.ago + 6.days, score: 95, attendance: true)

# === LEADERSHIP - Managers ===
Enrollment.create!(user: eng_manager, training: t_leadership, status: :completed, completion_date: 4.months.ago + 5.days, score: 92, attendance: true)
Enrollment.create!(user: design_manager, training: t_leadership, status: :completed, completion_date: 4.months.ago + 5.days, score: 90, attendance: true)
Enrollment.create!(user: sales_manager, training: t_leadership, status: :completed, completion_date: 4.months.ago + 5.days, score: 93, attendance: true)

# === UPCOMING TRAINING ENROLLMENTS ===
Enrollment.create!(user: alice, training: t_rails_advanced, status: :enrolled)
Enrollment.create!(user: bob, training: t_rails_advanced, status: :enrolled)
Enrollment.create!(user: eng_manager, training: t_rails_advanced, status: :enrolled)

Enrollment.create!(user: alice, training: t_compliance_2025, status: :enrolled)
Enrollment.create!(user: bob, training: t_compliance_2025, status: :enrolled)
Enrollment.create!(user: david, training: t_compliance_2025, status: :enrolled)

Enrollment.create!(user: eng_manager, training: t_ai_ml, status: :enrolled)
Enrollment.create!(user: sales_manager, training: t_ai_ml, status: :enrolled)

puts "🏆 Awarding Badges..."

# Calculate hours and award badges
# Alice: 30 (security) + 25 (react) + 20 (aws) = 75 hours → Gold Badge
UserBadge.create!(user: alice, badge: silver, awarded_at: 2.months.ago)
UserBadge.create!(user: alice, badge: gold, awarded_at: 1.month.ago)

# Bob: 30 (security) + 25 (react) + 20 (aws) = 75 hours → Gold Badge  
UserBadge.create!(user: bob, badge: silver, awarded_at: 2.months.ago)
UserBadge.create!(user: bob, badge: gold, awarded_at: 1.month.ago)

# Rajesh (eng_manager): 30 (security) + 25 (react) + 20 (aws) + 50 (leadership) = 125 hours → Platinum!
UserBadge.create!(user: eng_manager, badge: silver, awarded_at: 4.months.ago)
UserBadge.create!(user: eng_manager, badge: gold, awarded_at: 3.months.ago)
UserBadge.create!(user: eng_manager, badge: platinum, awarded_at: 2.months.ago)

# Charlie: 30 (security) + 25 (react) = 55 hours → Gold Badge
UserBadge.create!(user: charlie, badge: silver, awarded_at: 2.months.ago)
UserBadge.create!(user: charlie, badge: gold, awarded_at: 1.month.ago)

# David: 30 (security) + 15 (figma) = 45 hours → Silver Badge
UserBadge.create!(user: david, badge: silver, awarded_at: 1.month.ago)

# Eva: 30 (security) + 15 (figma) = 45 hours → Silver Badge
UserBadge.create!(user: eva, badge: silver, awarded_at: 1.month.ago)

# Sneha (design_manager): 30 (security) + 15 (figma) + 50 (leadership) = 95 hours → Gold Badge
UserBadge.create!(user: design_manager, badge: silver, awarded_at: 3.months.ago)
UserBadge.create!(user: design_manager, badge: gold, awarded_at: 1.month.ago)

# Frank: 30 (security) + 10 (sales) = 40 hours → Silver Badge
UserBadge.create!(user: frank, badge: silver, awarded_at: 1.month.ago)

# Grace: 10 (sales only, security pending) = 10 hours → No badge yet

# Amit (sales_manager): 30 (security) + 10 (sales) + 50 (leadership) = 90 hours → Gold Badge
UserBadge.create!(user: sales_manager, badge: silver, awarded_at: 3.months.ago)
UserBadge.create!(user: sales_manager, badge: gold, awarded_at: 1.month.ago)

puts "📋 Creating Assignments..."

# Assignment for Rails training
Assignment.create!(
  training: t_rails_advanced,
  title: "Build a Turbo Frame Component",
  description: "Create a Turbo Frame-powered infinite scroll component for a blog post list. Document your approach and submit a GitHub link.",
  due_date: 7.days.from_now
)

Assignment.create!(
  training: t_rails_advanced,
  title: "Stimulus Controller Challenge",
  description: "Refactor the provided JavaScript code into a Stimulus controller. Demonstrate proper use of targets, values, and actions.",
  due_date: 10.days.from_now
)

# Assignment for AWS training (past, with submissions)
aws_assignment = Assignment.create!(
  training: t_cloud_aws,
  title: "AWS Architecture Diagram",
  description: "Design a scalable web application architecture using AWS services. Submit your diagram with explanations.",
  due_date: 2.months.ago + 18.days
)

# Submissions for AWS assignment
Submission.create!(user: alice, assignment: aws_assignment, file_url: "https://drive.google.com/alice-aws-diagram", grade: 95)
Submission.create!(user: bob, assignment: aws_assignment, file_url: "https://drive.google.com/bob-aws-diagram", grade: 88)
Submission.create!(user: eng_manager, assignment: aws_assignment, file_url: "https://drive.google.com/rajesh-aws-diagram", grade: 92)

puts ""
puts "✅ Seeding completed successfully!"
puts ""
puts "=" * 60
puts "                    LOGIN CREDENTIALS"
puts "=" * 60
puts ""
puts "🔐 Super Admin: superadmin@wissen.com / password"
puts "   → Can approve mandatory trainings, view all reports"
puts ""
puts "👤 Admin: admin@wissen.com / password"
puts "   → Can create trainings, view all reports"
puts ""
puts "👔 Engineering Manager: rajesh@wissen.com / password"
puts "   → Has 3 reportees, earned ALL badges (Platinum!)"
puts ""
puts "👔 Design Manager: sneha@wissen.com / password"
puts "   → Has 2 reportees, earned Gold badge"
puts ""
puts "👔 Sales Manager: amit@wissen.com / password"
puts "   → Has 2 reportees, earned Gold badge"
puts ""
puts "👨‍💻 Senior Dev: alice@wissen.com / password"
puts "   → Earned Gold badge, multiple completed trainings"
puts ""
puts "👨‍💻 Developer: bob@wissen.com / password"
puts "   → Earned Gold badge"
puts ""
puts "👩‍🎨 Designer: david@wissen.com / password"
puts "   → Earned Silver badge"
puts ""
puts "💼 Sales: grace@wissen.com / password"
puts "   → Has pending mandatory training (Security)"
puts ""
puts "=" * 60
puts "                    KEY DATA POINTS"
puts "=" * 60
puts ""
puts "📊 Total Users: #{User.count}"
puts "📚 Total Trainings: #{Training.count} (#{Training.published.count} published, #{Training.pending_approval.count} pending)"
puts "📝 Total Enrollments: #{Enrollment.count} (#{Enrollment.completed.count} completed)"
puts "🏅 Total Badges Awarded: #{UserBadge.count}"
puts "📋 Total Assignments: #{Assignment.count}"
puts "📤 Total Submissions: #{Submission.count}"
puts ""
