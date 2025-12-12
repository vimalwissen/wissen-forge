You are expert fullstack project developer we have to develop a L&D portal for our project. Build using ruby on rails fullstack development and use postgresql as database.
Please go through the provided file and design the tasks and execution plan for it. It should look modern and responsive frontend. 
This is the problem statement:

Build-AI-Thon – Problem Statement & 
Requirements 
As part of this Build-AI-Thon, your challenge is to create a lightweight L&D Portal MVP that 
can scale. The solution must demonstrate role-based access, training creation, assignment 
workflows, enrollment, attendance tracking, and a functional learning profile for employees. 
The final code must be pushed to a public Git repository and the Git repo link must be 
emailed to: ai_committee@wissen.com. 
Must-Have Features 
● Login with roles: Employee, Admin, Super Admin. 
● Employee Learning Profile with tech stack, certifications, and training history. 
● Admin can create trainings and assign to all, departments, or specific employees. 
● Mandatory trainings require Super Admin approval. 
● Employees can view upcoming, department-specific, and mandatory trainings. 
● Employees can enroll in open trainings and view assigned trainings. 
● System tracks attendance and completion and shows it in the Learning Profile. 
Good-to-Have Features 
● Managers can view reportees’ learning profiles and mandatory completion status. 
● Reports for department-wise, director-wise, and mandatory training completion. 
● Gamification with quizzes/games 
● Auto creation of badges for 25/50/100 learning hours annually. 
● Certificate generator for Silver, Gold, and Platinum badges.

-----

Please add the sample data and users with different roles in seeds.rb file so we can just start and able to see the data

-----

This looks good. You are an UI expert make modern design which fills up the screen. You can use images by generating on your own, logos  and icons. Make it so that user want to be on the website as much as possible. 


-----

Only superadmin supposed to give approval on the mandatory training created by other admin. no approval is required for the training created by superadmin. Also show mandatory training to be completed as a seprate.


----
when creating trainings ,Admin  needs to have option to assign to all, departments, or specific employees. Employees can view upcoming, department-specific, and mandatory trainings.
Managers can view reportees’ learning profiles and mandatory completion status.  Reports for department-wise, director-wise, and mandatory training completion. 

-----

Admin and superadmin should be able to assign trainings to department or specific employees but while creating the training it is not required to assign that time. training is common for all assiging just enrolls the uses of that department or specific users

------
Tech Stack and skills should be available in my profile sections with the completion of the trainings. And manager and admins should be able to see the details. Also update the seed file to incorparate these changes

-------
You are a code coverage expert and you can complete the test coverage of big big projects and you complete the test coverage with unit testcases. Please make it 100% code coverage for unit testing

------

Put filter on training page with tech stack, skill and training type