core(cse,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, ece113, cse201, cse231, cse121, cse202, cse222, cse232, com301A, esc207A]).

core(csb,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, bio101, cse201, cse231, mth203, bio221, bio214, cse222, cse202, ece113, bio221, bio213, bio361, bio512, com301A, esc207A]).

core(csam,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, des101, des202, cse231, cse201, des201, mth203, cse222, des204, cse202, cse232, ssh201, com301A, esc207A]).

core(csd, [cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, ece113, cse201, cse231, cse121, cse202, cse222, cse232, com301A, esc207A]).

core(ece,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, ece113, ece215, ece270, ece250, mth203, ece230,ece214, ece240,mth204, com301A, esc207A]).
eco_minor_courses([eco101,eco301,eco201]).
prereq(cse400,[cse300,cse200,cse100]).
prereq(cse500,[cse300,cse200,cse90]).
print_list([]).
print_list([X|Y]):-
    write(X),nl,
    print_list(Y).

get_rec() :-
    write("input branch "),nl,read(Branch),
    get_core(Branch).

get_core(Branch) :-
    core(Branch,X),
    eco_minor(),!,
    write("Type y. if you have taken this core course, else type n.: "),nl,
    interactive_get_core([],[],X).
    


check_res(y,TBD,DONE,[X|Y]):-
    interactive_get_core(TBD,[X|DONE],Y). 

check_res(n,TBD,DONE,[X|Y]):-
   interactive_get_core([X|TBD],DONE,Y).

interactive_get_core(CORE_TBD,CORE_DONE,[]):-
    write("complete these core courses: "),nl,print_list(CORE_TBD)
    ,nl,write("these done:"),nl,print_list(CORE_DONE),
    nl,write("eligible for these:"),nl,
    \+get_electives(CORE_DONE).

interactive_get_core(TBD,DONE,[X|Y]):-
    write(X),nl,read(RES),nl,check_res(RES,TBD,DONE,[X|Y]).

eco_minor():-
    write("do you want to minor in Economics?"),nl,read(ECO),check_eco(ECO).
check_eco(y):-
    write("do these core courses:"),nl,eco_minor_courses(L),print_list(L).
check_eco(n).


get_electives(CORE):-
    course_information(C,NM,PRE,_,_,_,_,_), list_has_list(PRE,CORE),
    write(NM),nl,fail.

not_contains(X,[]).
not_contains(X,[Y|Z]):-
    X=\=Y,not_contains(X,Z).

contains(X,[X|_]).
contains(X,[Y|Z]):-
    contains(X,Z).
list_has_list([],_).
list_has_list([H|T],L):-
    contains(H,L),list_has_list(T,L).


course_information(cse320, "Advanced Algorithms", [cse102], [], [], monsoon, scse, ["Design and analysis of algorithms"]).
course_information(cse441, "Advanced Biometrics",[mth201], [cse343], [], winter, cse,["Designing biometric systems"]).
course_information(cse562, "Advanced Computer Vision", [cse343], [], [], monsoon, csai,["Computer Vision"]).
course_information(cse577, "Advanced Internet of Things", [cse343], [], [], winter, csai, ["Internet of Things", "Android Programming"]).
course_information(cse642, "Advanced Machine Learning", [mth201, cse343], [cse641], [], monsoon, csai, ["Deep Learning"]).
course_information(cse631, "Advanced Operating Systems", [cse231], [], [], winter, cse, ["Unix Systems", "OS Kernels"]).
course_information(cse201, "Advanced Programming", [cse101, cse102], [], [], monsoon, cse,["Object Oriented Programming"]).
course_information(cse734, "Advanced Topics in Mobile Computing", [cse232, cse231], [], [], winter, cse, ["Challenges in Mobile Computing Domain"]).
course_information(cse661, "Affective Computing", [cse101, cse102, cse201], [cse343, cse643], [], monsoon, dse, "Affective Computing").
course_information(cse222, "Algorithm Design and Analysis", [cse102], [], [], winter, cse, ["Design of Algorithms", "Proofs of correctness"]).
course_information(cse546, "Applied Cryptography", [cse121], [], [], monsoon, cse, ["Perfect Security", "Cryptographic Protocols"]).
course_information(cse529, "Approximation Algorithms", [cse222], [], [], winter, cse, ["Algorithms for NP Hard Problems"]).
course_information(cse643, "Artificial Intelligence", [cse102], [], [], monsoon, csai, ["Logic", "Artificial Intelligence"]).
course_information(cse515, "Bayesian Machine Learning", [mth201], [cse343, mth577], [], monsoon, csai, ["Bayesian Approach"]).
course_information(cse557, "Big Data Analytics",[cse202], [cse343], [], winter, cse, ["Data Analysis"]).
course_information(cse640, "Collaborative Filtering", [mth100], [], [], monsoon, cse, ["Recommender Systems"]).
course_information(cse636, "Communication Networks", [mth201], [ece501], [], winter, cse, ["Communication Networking"]).
course_information(cse301, "Compilers", [mth100, cse101, cse201, cse102], [], [], monsoon, cse, ["Compilers"]).
course_information(cse421, "Complexity Theory", [cse102, mth201, cse322, cse121], [], [], monsoon, cse, ["Computaional Complexity"]).
course_information(cse511, "Computer Architecture", [], [], [], monsoon, cse,["Computer Architecture"]).
course_information(cse333, "Computer Graphics", [cse101], [cse102], [], monsoon, cse, ["Computer Graphics"]).
course_information(cse232, "Computer Networks", [cse101, cse231, cse222], [], [], monsoon, cse, ["Network Analysis"]).
course_information(cse112, "Computer Organization", [ece111], [], [], winter, cse, ["Assembly Language"]).
course_information(cse344, "Computer Vision", [mth100], [], [], winter, csai, ["Computer Vision"]).
course_information(cse585, "Computing for Medicine", [], [], [], monsoon, cse, ["Health Data"]).
course_information(cse606A, "Data Lifecycle Management", [cse343], [], [], monsoon, csai, ["Data Research", "Machine Learning"]).
course_information(cse506, "Data Mining", [cse202, cse101, mth100, mth201], [], [], monsoon, cse, ["Patterns in Data"]).
course_information(cse558, "Data Science",[cse101, cse343], [mth101], [], monsoon, csai,["Exploratary Data Analysis"]).
course_information(cse102, "Data Structures And Algorithms", [cse101], [], [], winter, cse,["Data Strcutures"]).
course_information(cse606, "Data Warehouse", [cse202], [], [], winter, cse, ["Data Warehouses"]).
course_information(cse507, "Database System Implementation", [cse202, cse102], [], [], monsoon, cse, ["Database Systems"]).
course_information(cse504, "Decision Procedures", [cse102, cse201, mth210], [], [], winter, cse, ["Decision Procedures"]).
course_information(cse641, "Deep Learning", [], [cse343], [], winter, csai,["Neural Networks"]).
course_information(cse501, "Designing Human Centered Systems", [], [], [des204], monsoon, cse, ["Design Paradigms"]).
course_information(cse121, "Discrete Mathematics", [], [], [mth210], monsoon, cse, "Problem Solving Skills").
course_information(cse530, "Distributed Systems: Concepts And Designs", [cse232, cse222], [], [], monsoon, cse, ["Distrbuted Systems"]).
course_information(cse663, "EdgeAI", [cse343], [], [], winter, csai, ["On-Device AI"]).
course_information(cse345, "Foundations of Computer Security", [], [cse232], [], monsoon, cse, ["Computer Security"]).
course_information(cse502, "Foundations of Parallel Programming", [cse102, cse101, cse201], [], [], winter, cse, ["Parallel Programming"]).
course_information(cse202, "Fundamentals of Database Management System", [cse102], [], [], winter, cse, ["Database Manegement"]).
course_information(cse5GP, "Geometry Processing",[cse101], [cse102], [], winter, cse, ["3D Geometry"]).
course_information(cse560, "GPU Computing", [cse101], [cse102], [], winter, cse, ["Parallel Programming"]).
course_information(cse656, "Information Integration and Applications", [cse202], [cse102], [], monsoon, cse, ["Integrating Information", "Database Management"]).
course_information(cse508, "Information Retrieval", [cse202, cse201, cse102], [], [], winter, cse, ["Search Engines", "Information Retrieval"]).
course_information(cse528, "Introduction to Blockchain and cryptocurrency", [], [cse546], [], monsoon, cse, ["Blockchains", "Cryptocurrency"]).
course_information(cse525, "Introduction to Graduate Algorithms", [cse222], [], [], monsoon, cse,["Algorithms"]).
course_information(cse140, "Introduction to Intelligent Systems", [], [], [], winter, csai, ["Logic", "Artificial Intelligence"]).
course_information(cse571, "Introduction to Media Computing", [], [], [], monsoon, cse, ["Digital Representation"]).
course_information(cse101, "Introduction to Programming", [], [], [], monsoon, cse, ["Programming"]).
course_information(cse622, "Introduction to Quantum Computing", [mth100], [mth102],[], winter, cse, ["Quantum Computing"]).
course_information(cse555, "Introduction to Spatial Computing", [cse102, cse202], [], [], monsoon, cse, ["Spatial Computing"]).
course_information(cse343, "Machine Learning", [mth100, mth201, mth101], [], [], monsoon, csai, ["Research", "Machine Learning"]).
course_information(ece577, "Machine Learning Techniques for Real Time Control", [], [cse343, ece570], [], monsoon, cse, ["Machine Learning"]).
course_information(cse559, "Mining Large Networks",[cse222, cse101, mth201], [cse343], [], winter, cse,["Graphs", "Networks"]).
course_information(cse556, "Mobile and Middleware Systems", [cse535, cse232], [], [], monsoon, cse,["Mobile Systems"]).
course_information(cse535, "Mobile Computing", [cse101], [cse231, cse232], [], monsoon, cse, ["Mobile Systems", "Android Programming"]).
course_information(cse319, "Modern Algorithm Design", [cse232], [cse641], [], monsoon, cse, ["Algorithms"]).
course_information(cse563, "Multimedia Computing and Applications", [], [], [], winter, cse, ["Multimedia Computing"]).
course_information(cse694F, "Multimedia Security", [ece350], [], [], winter, cse,["Security", "Multimedia Computing"]).
course_information(cse556, "Natural Language Processing", [cse101, cse222, mth201, mth100], [], [], monsoon, csai, ["Natural Language Processing", "Deep Learning"]).
course_information(cse233, "Network Adminstration", [], [cse230], [], winter, cse, "Networks").
course_information(cse749, "Network Anonymity and Privacy", [], [], [], monsoon, cse, ["Networks", "Privacy"]).
course_information(cse655, "Network Science", [], [], [], winter, cse, ["Networks"]).
course_information(cse350, "Network Security", [], [], [], monsoon, cse, ["Networks", "Security"]).
course_information(cse354, "Network and System Security", [cse231, cse232], [], [], winter, cse, ["Networks", "Security"]).
course_information(cse231, "Operating Systems", [cse102], [], [], monsoon, cse, ["Operating Systems", "Kernels"]).
course_information(cse634, "Parallel Runtimes for Modern Processors",[cse201, cse231], [cse343], [], monsoon, cse, ["Parallel Processing"]).
course_information(cse645, "Privacy and Security in Online Social Media", [], [], [], winter, cse, ["Priavcy", "Security"]).
course_information(cse561, "Probabilistic Graphic Models", [mth201], [ece501], [], winter, cse, ["Probability"]).
course_information(cse503, "Program Analysis", [cse201, cse102], [cse322], [], monsoon, cse, ["Analysis"]).
course_information(cse584, "Program Verification", [mth210], [], [], monsoon, cse, ["Program Verification", "Correctness"]).
course_information(cse523, "Randomized Algorithms", [cse222, cse121, mth201], [], [], monsoon, cse,["Algorithms"]).
course_information(cse564, "Reinforcement Learning", [mth201], [], [], monsoon, csai, ["Reinforcement Learning"]).
course_information(cse633, "Robotics", [], [], [], winter, csai, ["Robotics"]).
course_information(cse552, "Security Engineering", [cse231], [], [], monsoon, cse, ["Security"]).
course_information(cse632, "Sematic Web", [cse101, cse202], [cse201], [], winter, cse, ["Web"]).
course_information(cse576, "Smart Sensing for Internet of Things", [], [], [], monsoon, csai, ["Internet of Things"]).
course_information(cse565, "Software Defined Networking", [cse232], [], [], monsoon, cse, ["Networks"]).
course_information(cse583, "Software Development using Open Source", [], [], [], monsoon, cse, ["Open Source"]).
course_information(cse582, "Software Production Evolution and Maintenance",[], [], [], monsoon, cse, ["Software Cycle"]).
course_information(cse572, "Speech and Audio Processing", [mth100, ece250], [mth201, ece351], [], monsoon, cse,["Audio"]).
course_information(cse609, "Statistical Computation", [mth201], [], [], winter, cse, ["Statistics"]).
course_information(cse342, "Statistical Machine Learning", [cse101, mth201], [], [], winter, csai, ["Statistics", "Machine Learning"]).
course_information(cse322, "Theory Of Computation", [mth210], [], [], winter, cse, ["Automata Theory"]).
course_information(cse516, "Thories of Deep Learning", [], [mth100, mth203, cse343], [], winter, csai,["Deep Learning"]).
course_information(cse524, "Theory of Modern cryptography", [], [], [], monsoon, cse, ["Cryptography"]).
course_information(cse651, "Topics in Adaptive Cybersecurity", [cse345], [], [], monsoon, cse, ["Cybersecurity"]).
course_information(cse701, "Topics in SE: AI in SE", [], [], [], monsoon, cse, ["Artificial Intelligence"]).
course_information(cse660, "Trustworthy AI systems", [cse643, cse343], [], [], winter, csai, ["Artificial Intelligence"]).
course_information(cse570, "Virtual Reality", [], [], [], winter, cse, ["Virtual Reality"]).
course_information(cse538, "Wireless Networks", [cse232], [], [], winter, cse, ["Networks"]).


electives([cse320,cse441,cse562,cse577,cse642,cse631,cse201,cse734,cse661,cse222,cse546,cse529,cse643,cse515,
cse557,cse640,cse636,cse301,cse421,cse511,cse333,cse232,cse112,cse344,cse585,cse606A,cse506,cse558,cse102,cse606,cse507,cse504,
cse641,cse501,cse121,cse530,cse663,cse345,cse502,cse202,cse5GP,cse560,cse656,cse508,cse528, cse525,cse140,cse571,cse101,cse622,
cse555,cse343,ece577,cse559,cse556,cse535, cse319,cse563,cse694F,cse556,cse233,cse749,cse655,cse350,cse354,cse231,cse634,
cse645,cse561,cse503,cse584,cse523,cse564,cse633,cse552,cse632,cse576,cse565,cse583,cse582,cse572,cse609,cse342,cse322,cse516,
cse524,cse651,cse701,cse660,cse570,cse538]).