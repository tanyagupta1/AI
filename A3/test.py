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




with ruleset('avg_grade'):
    #ML
    @when_all(pri(0),(m.interest=='Data Science') & (m.avg_grade>9) &(m.no_of_courses>3) )
    def ML_researcher(c):
        c.assert_fact('career_path', { 'path': 'ML Researcher'})

    @when_all(pri(1),(m.interest=='Data Science') & (m.courses.anyItem((item.BigDataAnalytics >= 8))) )
    def data_analyst(c):
        c.assert_fact('career_path', { 'path': 'Data Analyst'})

    #Economics
    @when_all(pri(0),(m.interest=='Economics') & (m.avg_grade>=9) &(m.no_of_courses>=3) )
    def economics_researcher(c):
        c.assert_fact('career_path', { 'path': 'Economics Researcher'})

    @when_all(pri(1),(m.interest=='Economics') & (m.courses.anyItem((item.MacroEconomics >= 9))) & (m.courses.anyItem((item.MicroEconomics >= 9))))
    def economist(c):
        c.assert_fact('career_path', { 'path': 'Economist'})

    @when_all(pri(2),(m.interest=='Economics') & (m.courses.anyItem((item.FoundationsOfFinance >= 9))) )
    def investment_banker(c):
        c.assert_fact('career_path', { 'path': 'Investment Banker'})
    
    @when_all(pri(3),(m.interest=='Economics') & (m.courses.anyItem((item.ValuationAndPortfolioManagement >= 9))) )
    def investment_analyst(c):
        c.assert_fact('career_path', { 'path': 'Investment Analyst'})

    @when_all(pri(4),(m.interest=='Economics') & (m.avg_grade>=7))
    def consultant(c):
        c.assert_fact('career_path', { 'path': 'Consultant'})

    #Entrepreneurship
    @when_all(pri(0),(m.interest=='Entrepreneurship') & (m.avg_grade>=9) &(m.no_of_courses>=3) )
    def ent_prof(c):
        c.assert_fact('career_path', { 'path': 'Entrepreneurship Professor'})

    @when_all(pri(1),(m.interest=='Entrepreneurship') & (m.avg_grade>=7) )
    def ent_prof(c):
        c.assert_fact('career_path', { 'path': 'Entrepreneur'})

    @when_all((m.interest=='Entrepreneurship') & (m.courses.anyItem((item.EntrepreneurialCommunication >= 8))) )
    def sales_manager(c):
        c.assert_fact('career_path', { 'path': 'Sales Manager'})

    # software
    @when_all((m.interest=='Software Engineering') & (m.avg_grade>=8) &(m.no_of_courses>=3) )
    def devops_engineer(c):
        c.assert_fact('career_path', { 'path': 'Fullstack Developer'}) 

    @when_all((m.interest=='Software Engineering') & (m.courses.anyItem((item.GameDesignAndDevelopment>= 8))) & ((m.courses.anyItem((item.IntroductionTo2DAnimation>= 8)or(m.courses.anyItem((item.IntroductionToMotionGraphics>= 8)or(m.courses.anyItem((item.IntroductionTo3DCharacterAnimation>= 8)))))))))
    def video_game_dev(c):
        c.assert_fact('career_path', { 'path': 'Video Game Developer'})

    @when_all((m.interest=='Software Engineering') & (m.courses.anyItem((item.CloudComputing>= 8))))
    def devops_engineer(c):
        c.assert_fact('career_path', { 'path': 'Cloud Engineer'})  

    @when_all((m.interest=='Software Engineering') & (m.courses.anyItem((item.MobileComputing>= 8))))
    def devops_engineer(c):
        c.assert_fact('career_path', { 'path': 'Mobile App Developer'})   
        

    @when_all(+m.interest)
    def compulsory(c):
        pass
    

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
    
    #economics chains
    @when_all(m.path=='Economics Researcher')
    def data_scientist(c):
        c.assert_fact({ 'path': 'Economist'})

    @when_all(m.path=='Economist')
    def data_scientist(c):
        c.assert_fact({ 'path': 'Consultant'})
    
    @when_all(m.path=='Investment Analyst')
    def data_scientist(c):
        c.assert_fact({ 'path': 'Financial Consultant'})
    
    #entrepreneurship
    @when_all(m.path=='Entrepreneurship Professor')
    def entrepreneur(c):
        c.assert_fact({ 'path': 'Entrepreneur'})
    @when_all(m.path=='Entrepreneur')
    def entrepreneur(c):
        c.assert_fact({ 'path': 'Business Consultant'})

    #software
    @when_all(m.path=='Fullstack Developer')
    def entrepreneur(c):
        c.assert_fact({ 'path': 'Frontend Developer'})
    @when_all(m.path=='Fullstack Developer')
    def entrepreneur(c):
        c.assert_fact({ 'path': 'Backend Developer'})
    @when_all(m.path=='Cloud Engineer')
    def entrepreneur(c):
        c.assert_fact({ 'path': 'Devops Engineer'})

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
            'Data Science':0,
            'Electronics':0,
            'SSH':0
            }
courses = {
            'Economics':['MicroEconomics','MacroEconomics','FoundationsOfFinance','EconometricsI','MoneyAndBanking','GameTheory','ValuationAndPortfolioManagement'],
            'Entrepreneurship':['RelevanceOfIntellectualPropertyForStartups','EntrepreneurialCommunication','EntrepreneurialKhichadi','EntrepreneurialFinance','NewVenturePlanning','CreativityInnovationAndInventiveProblemSolving','Healthcare InnovationAndEntrepreneurshipEssentials'],
            'Security':['NetworkSecurity','TopicsInAdaptiveCybersecurity','PrivacyAndSecurityInOnlineSocialMedia','IntroductionToBlockchainAndCryptocurrency','TheoryOfModernCryptography','MultimediaSecurity','NetworkAnonymityAndPrivacy','FoundationsOfComputerSecurity','NetworksAndSystemSecurityII','TopicsInCryptanalysis'],
            'Mathematics':[],
            'Software Engineering':
            ['IntroductionTo2DAnimation',
            'IntroductionToMotionGraphics',
            'IntroductionTo3DCharacterAnimation',
            'GameDesignAndDevelopment',
            'MobileComputing',
            'IntroductionToProgramming',
            'DataStructuresAndAlgorithms',
            'FundamentalsOfDatabaseManagementSystem',
            'MobileComputing',
            'SoftwareDevelopmentUsingOpenSource',
            'CloudComputing'
            ], 
            'Data Science':['BigDataAnalytics','InformationRetrieval','DataScience','DeepLearning','BayesianMachineLearning','StatisticalMachineLearning','MachineLearning','ReinforcementLearning','DataMining'],
            'Electronics':[],
            'SSH':[]
            }

courses_done=[] # entry made if interest>2
for key in interests.keys():
    interests[key] = int(input(key+': '))
    if(interests[key]>2):
        interest_courses_done=[]
        grade_sum=0
        for course in courses[key]:
            grade = int(input("Grade in "+course+": "))
            if(grade>0):
                interest_courses_done.append({course:grade})
                grade_sum+=grade
        try:
            courses_done.append({'interest':key, 'avg_grade':grade_sum/len(interest_courses_done),'no_of_courses':len(interest_courses_done),'courses':interest_courses_done})
        except:
            courses_done.append({'interest':key, 'avg_grade':0,'no_of_courses':0,'courses':interest_courses_done})
for i in courses_done:
    assert_fact('avg_grade',i)




print(courses_done)
print(interests)