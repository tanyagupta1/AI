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
# 9. Data Science -Data Analyst, Data scientist, researcher
# 10. Electronics- na, electronics engineer, researcher

# rules of type {interest, avg grade, courses taken with grades}
with ruleset('avg_grade'):

    @when_all((m.interest=='Data Science') & (m.avg_grade>9))
    def ML_researcher(c):
        c.assert_fact('career_path', { 'path': 'ML Researcher'})


with ruleset('career_path'):

    @when_all(m.path=='ML Researcher')
    def data_scientist(c):
        c.assert_fact({ 'path': 'Data Scientist'})

    @when_all(m.path=='Data Scientist')
    def data_analyst(c):
        c.assert_fact({ 'path': 'Data Analyst'})

    @when_all(+m.path)
    def output(c):
        print('You can be an {0}'.format(c.m.path))

# assert_fact('career_path', { 'path': 'ML Researcher'})
assert_fact('avg_grade',{'interest':'Data Science', 'avg_grade':9.5})