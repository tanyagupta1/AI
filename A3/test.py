from durable.lang import *

# assert_fact('animal', { 'subject': 'Kermit', 'predicate': 'eats', 'object': 'flies' })

# input is courses taken and grades, and interests

# categorize courses into categories of interests
# if interest exceeds a certain threshold, check the bucket of courses taken
# establish a heirarchy based on avg cgpa in that bucket
# if a certain course is not taken ,eliminate certain career paths

# career paths: 
# 1. Economics - NA,Product Manager,Brand Manager ,Investment Banking, Professor/Researcher
# 2. Entrepreneurship - Entrepreneur
# 3. Security -NA, Security Engineer, Researcher
# 4. Mathematics - NA, Quant, Researcher
# 5. SSH
# 7. Software Engineering - Tester, Software developer, researcher
# 8. Theoretical Computer Science - 
# 9. Data Science -Data Engineer,Data Analyst, Data scientist, researcher
# 10. Electronics- na, electronics engineer, researcher

# rules of type {interest, avg grade, no_of_courses, courses taken with grades}

with ruleset('interest'): # a
    @when_all(m.interest_magnitude>2)
    def explore_interest(c):
        c.assert_fact('avg_grade',{})

        

    

with ruleset('avg_grade'):
    
    @when_all(pri(0),(m.interest=='Data Science') & (m.avg_grade>9) &(m.no_of_courses>3) )
    def ML_researcher(c):
        c.assert_fact('career_path', { 'path': 'ML Researcher'})

    @when_all(pri(1),(m.interest=='Data Science') & (m.courses.anyItem((item.BDA >= 8))) )
    def data_analyst(c):
        c.assert_fact('career_path', { 'path': 'Data Analyst'})
    
    

with ruleset('career_path'):

    # ML chains
    @when_all(m.path=='ML Researcher')
    def data_scientist(c):
        c.assert_fact({ 'path': 'Data Scientist'})

    @when_all(m.path=='Data Scientist')
    def data_analyst(c):
        c.assert_fact({ 'path': 'Data Analyst'})

    @when_all(+m.path)
    def output(c):
        print('You can be {0}'.format(c.m.path))
    
    

# assert_fact('avg_grade',{'interest':'Data Science', 'avg_grade':9.5,'no_of_courses':5,'courses':[{'BDA':9.5}]})
# print(get_facts('career_path'))

# input
print("Rate interest in these areas on a scale of 1-5")
interests = {
            'Economics':0,
            'Entrepreneurship':0,
            'Security':0,
            'Mathematics':0,
            'Software Engineering':0, 
            'Theoretical Computer Science':0,
            'Data Science':0,
            'Electronics':0,
            'SSH':0
            }
courses = {
            'Economics':['MicroEconomics','MacroEconomics','Foundations of Finance','Econometrics I','Money and Banking','Game Theory'],
            'Entrepreneurship':['Relevance of Intellectual Property for Startups','Entrepreneurial Communication','Entrepreneurial Khichadi','Entrepreneurial Finance','New Venture Planning','Creativity, Innovation, and Inventive Problem Solving','Healthcare Innovation and Entrepreneurship Essentials'],
            'Security':['Network Security','Topics in Adaptive Cybersecurity','Privacy and Security in Online Social Media','Introduction to Blockchain and Cryptocurrency','Theory of Modern cryptography','Multimedia Security','Network Anonymity and Privacy','Foundations of Computer Security','Networks and System Security II','Topics in Cryptanalysis'],
            'Mathematics':[],
            'Software Engineering':[], 
            'Theoretical Computer Science':[],
            'Data Science':[],
            'Electronics':[],
            'SSH':[]
            }

courses_done=[] # entry made if interest>2
for key in interests.keys():
    interests[key] = int(input(key+': '))
    if(interests[key]>2):
        interest_courses_done={}
        grade_sum=0
        for course in courses[key]:
            grade = int(input("Grade in "+course+": "))
            if(grade>0):
                interest_courses_done[course]=grade
                grade_sum+=grade

        courses_done.append({'interest':key, 'avg_grade':grade_sum/len(interest_courses_done),'courses':interest_courses_done})
print(courses_done)





print(interests)