Implementation Plan - WissenForge (L&D Portal)
Goal Description
Build a lightweight, scalable L&D Portal MVP to manage employee training, including role-based access, training creation, assignments, enrollments, and attendance tracking.

Technology Stack
Backend: Ruby on Rails 7.x
Database: PostgreSQL
Frontend: Rails Fullstack (Hotwire: Turbo & Stimulus) + TailwindCSS for modern, responsive UI.
Authentication: Devise
Authorization: Pundit (or Cancancan)
Database Schema Design (Proposed)
Users
id, email, password_digest, role (enum: employee, admin, super_admin), department, name, designation, manager_id
Logic: A "Manager" is any User who has reportees (users with manager_id pointing to them). Admin/Super Admin can also be Managers.
Associations: has_many :enrollments, has_many :trainings, through: :enrollments
Trainings
id, title, description, type (classroom, online), mode (mandatory, optional), start_time, end_time, capacity, instructor, department_target (optional), status (pending_approval, published, archived)
Associations: has_many :enrollments
Enrollments
id, user_id, training_id, status (enrolled, completed, cancelled, waitlisted), attendance (boolean), score (integer), completion_date (datetime)
Associations: belongs_to :user, belongs_to :training
Quizzes & Assignments
Quiz: training_id, questions (jsonb or separate table)
Assignment: training_id, title, description, due_date
Submission: user_id, assignment_id, file_url, grade
Badges & Certificates
Badge: id, name, criteria (hours/courses count), image_url, level (Silver, Gold, Platinum)
UserBadge: user_id, badge_id, awarded_at
Certificate: Generated PDF stored or generated on-fly for completed trainings/badges.
Badges/Gamification (Good-to-have)
id, name, criteria, image_url
UserBadges join table.
User Review Required
Roles: "Manager" is treated as a logical relationship (User with reportees), not a strict permission role like Admin.
Approvals: Mandatory trainings MUST be approved by Super Admin before they are published/assignable.
Proposed Changes
Application Setup
[NEW] [Rails App]
Initialize new Rails app with PostgreSQL and Tailwind.
Models & Database
[NEW] [User Model]
Devise setup, Role management.
[NEW] [Training Model]
Core logic for creating and managing trainings.
[NEW] [Enrollment Model]
Tracking user participation.
Controllers
[NEW] [TrainingsController]
Actions: index, show, new, create, edit, update (scoped by role).
[NEW] [EnrollmentsController]
Actions: create (enroll), update (mark complete/attend).
[NEW] [DashboardController]
Role-specific dashboards.
Verification Plan
Manual Verification
Admin Flow: Create a training -> Assign to Department -> Check DB.
Super Admin Flow: Approve a mandatory training.
Employee Flow: Login -> See Dashboard -> Enroll in open training -> Check 'My Trainings'.
Attendance: Admin marks attendance -> Employee sees completion in Profile.
Quizzes & Assignments: Employee submits assignment/takes quiz -> Admin grades -> Score updates.
Badges: Employee hits 25 hours -> System auto-awards Silver Badge -> Certificate generated.


🔐 Super Admin: superadmin@wissen.com / password
   → Can approve mandatory trainings, view all reports

👤 Admin: admin@wissen.com / password
   → Can create trainings, view all reports

👔 Engineering Manager: rajesh@wissen.com / password
   → Has 3 reportees, earned ALL badges (Platinum!)

👔 Design Manager: sneha@wissen.com / password
   → Has 2 reportees, earned Gold badge

👔 Sales Manager: amit@wissen.com / password
   → Has 2 reportees, earned Gold badge

👨‍💻 Senior Dev: alice@wissen.com / password
   → Earned Gold badge, multiple completed trainings

👨‍💻 Developer: bob@wissen.com / password
   → Earned Gold badge

👩‍🎨 Designer: david@wissen.com / password
   → Earned Silver badge

💼 Sales: grace@wissen.com / password
   → Has pending mandatory training (Security)

============================================================
                    KEY DATA POINTS
============================================================

📊 Total Users: 12
📚 Total Trainings: 10 (9 published, 1 pending)
📝 Total Enrollments: 34 (25 completed)
🏅 Total Badges Awarded: 16
📋 Total Assignments: 3
📤 Total Submissions: 3