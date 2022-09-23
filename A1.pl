core(cse,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, ece113, cse201, cse231, cse121, cse202, cse222, cse232, com301A, esc207A]).
core(csb,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, bio101, cse201, cse231, mth203, bio221, bio214, cse222, cse202, ece113, bio221, bio213, bio361, bio512, com301A, esc207A]).
core(csam,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, des101, des202, cse231, cse201, des201, mth203, cse222, des204, cse202, cse232, ssh201, com301A, esc207A]).
core(csd, [cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, ece113, cse201, cse231, cse121, cse202, cse222, cse232, com301A, esc207A]).
core(ece,[cse101, ece111, mth100, des130, com101, cse102, cse112, mth201, ece113, ece215, ece270, ece250, mth203, ece230,ece214, ece240,mth204, com301A, esc207A]).
eco_minor_courses([eco311,eco301,eco221]).
ent_minor_courses([ent411,ent412,ent415]).


:- dynamic(suggested/1).
:- dynamic(done/1).

reset_electives:-
    retractall(suggested(_)),
    retractall(done(_)),
    fail.
reset_electives.
getPre([]):-
    write("Enter: "),
    nl,
    read(Pre),
    dif(Pre, stop),
    assertz(done(Pre)),
    getPre([]).

print_list([]).
print_list([X|Y]):-
    write(X),nl,
    print_list(Y).

get_rec() :-
    write("input branch "),nl,read(Branch),
    get_core(Branch).

get_core(Branch) :-
    core(Branch,X),
    write("Type y. if you have taken this core course, else type n.: "),nl,
    interactive_get_core([],[],X).
    


check_res(y,TBD,DONE,[X|Y]):-
    assertz(done(X)),interactive_get_core(TBD,[X|DONE],Y). 

check_res(n,TBD,DONE,[X|Y]):-
   interactive_get_core([X|TBD],DONE,Y).

interactive_get_core(CORE_TBD,CORE_DONE,[]):-
    write("complete these core courses: "),nl,print_list(CORE_TBD)
    ,nl,write("these done:"),nl,print_list(CORE_DONE),
    nl,write("eligible for these:"),nl,
    \+get_electives(CORE_DONE),!,
    write("Which of these have you done?"),nl,
    \+getPre([]),nl,write("List of all courses you are eligible for: "),nl,!,\+get_electives2(),!,
    get_interest(INTEREST),write("for your career:"),nl,!,get_interest_electives(INTEREST,CORE_DONE),!,
    \+eco_minor(),!,\+ent_minor().

interactive_get_core(TBD,DONE,[X|Y]):-
    write(X),nl,read(RES),nl,check_res(RES,TBD,DONE,[X|Y]).

eco_minor():-
    nl,write("do you want a minor degree in Economics?"),nl,read(ECO),check_eco(ECO).
check_eco(y):-
    write("You have not completed these mandatory courses:"),nl,
    eco_minor_courses(ECOL),!,contains(ECOC,ECOL),\+done(ECOC),
    nl,write(ECOC),assertz(suggested(ECOC)),fail.
check_eco(n) :-fail.

ent_minor():-
    nl,write("do you want a minor degree in Entrepreneurship?"),nl,read(ENT),check_ent(ENT).
check_ent(y):-
    write("You have not completed these mandatory courses:"),nl,
    ent_minor_courses(ENTL),!,contains(ENTC,ENTL),\+done(ENTC),
    nl,write(ENTC),assertz(suggested(ENTC)),fail.
check_ent(n) :-fail.

get_interest(INTEREST):-
    write("Enter career path (the name):"),
    nl,write("1. data_science"),
    nl,write("2. cybersecurity"),
    nl,write("3. biotech"),
    nl,write("4. entrepreneurship"),
    nl,write("5. none"),
    nl,read(INTEREST).

get_electives(CORE):-
    course(C,NM,PRE), list_has_list(PRE,CORE),
    write(C),write(":"),write(NM),nl,fail.

get_electives2():-
    course(C,NM,PRE),prereqsdone(PRE),
    write(C),write(":"),write(NM),nl,fail.

prereqsdone([H|T]):-
    done(H),prereqsdone(T).
prereqsdone([]).

not_contains(X,[]).
not_contains(X,[Y|Z]):-
    X=\=Y,not_contains(X,Z).

contains(X,[X|_]).
contains(X,[Y|Z]):-
    contains(X,Z).
list_has_list([],_).
list_has_list([H|T],L):-
    contains(H,L),list_has_list(T,L).

get_interest_electives(INTEREST,CORE_DONE):-
    career_path(INTEREST,CAR_COURSES), \+check_pre(CAR_COURSES,CORE_DONE).

check_pre(CAR_COURSES,CORE_DONE):-
    contains(C,CAR_COURSES),course(C,NM,PRE), list_has_list(PRE,CORE_DONE),
    write(NM),nl,fail.


career_path(data_science,[cse515,cse529,cse506,cse508]).
career_path(cybersecurity,[cse546,cse345,cse655,cse350,cse749]).
career_path(biotech,[cse441,cse585,bio321,bio524,bio361,bio545,bio211,bio534,bio213,bio531,bio542,bio532]).
career_path(entrepreneurship,[ent411,ent413,ent416]).
career_path(economist,[eco314,eco503,eco322,eco221,eco331,eco311,eco201,eco301,eco223]).

course(bio321, "Algorithms in Bioinformatics", [cse222]).
course(bio524, "Biomedical Image Processing", []).
course(bio361, "Biophysics", []).
course(bio545, "Biostatistics", []).
course(bio211, "Cell Biology", []).
course(bio534, "Introduction to Computational Neuroscience", []).
course(bio213, "Introduction to Quantitative Biology", [mth100]).
course(bio531, "Introduction to Mathemaical Biology", [mth100]).
course(bio542, "ML for biomedical applications", []).
course(bio532, "Network Biology", []).
course(cse320, "Advanced Algorithms", [cse102]).
course(cse441, "Advanced Biometrics", [mth201]).
course(cse562, "Advanced Computer Vision", [cse343]).
course(cse577, "Advanced Internet of Things", [cse343]).
course(cse642, "Advanced Machine Learning", [mth201, cse343]).
course(cse631, "Advanced Operating Systems", [cse231]).
course(cse201, "Advanced Programming", [cse101, cse102]).
course(cse734, "Advanced Topics in Mobile Computing", [cse232, cse231]).
course(cse661, "Affective Computing", [cse101, cse102, cse201]).
course(cse222, "Algorithm Design and Analysis", [cse102]).
course(cse546, "Applied Cryptography", [cse121]).
course(cse529, "Approximation Algorithms", [cse222]).
course(cse643, "Artificial Intelligence", [cse102]).
course(cse515, "Bayesian Machine Learning", [mth201]).
course(cse557, "Big Data Analytics", [cse202]).
course(cse640, "Collaborative Filtering", [mth100]).
course(cse636, "Communication Networks", [mth201]).
course(cse301, "Compilers", [mth100, cse101, cse201, cse102]).
course(cse421, "Complexity Theory", [cse102, mth201, cse322, cse121]).
course(cse511, "Computer Architecture", []).
course(cse333, "Computer Graphics", [cse101]).
course(cse232, "Computer Networks", [cse101, cse231, cse222]).
course(cse112, "Computer Organization", [ece111]).
course(cse344, "Computer Vision", [mth100]).
course(cse585, "Computing for Medicine", []).
course(cse606A,"Data Lifecycle Management", [cse343]).
course(cse506, "Data Mining", [cse202, cse101, mth100, mth201]).
course(cse558, "Data Science", [cse101, cse343]).
course(cse102, "Data Structures And Algorithms", [cse101]).
course(cse606, "Data Warehouse", [cse202]).
course(cse507, "Database System Implementation", [cse202, cse102]).
course(cse504, "Decision Procedures", [cse102, cse201, mth210]).
course(cse641, "Deep Learning", []).
course(cse501, "Designing Human Centered Systems", []).
course(cse121, "Discrete Mathematics", []).
course(cse530, "Distributed Systems: Concepts And Designs", [cse232, cse222]).
course(cse663, "EdgeAI", [cse343]).
course(cse345, "Foundations of Computer Security", []).
course(cse502, "Foundations of Parallel Programming", [cse102, cse101, cse201]).
course(cse202, "Fundamentals of Database Management System", [cse102]).
course(cse5GP, "Geometry Processing", [cse101]).
course(cse560, "GPU Computing", [cse101]).
course(cse656, "Information Integration and Applications", [cse202]).
course(cse508, "Information Retrieval", [cse202, cse201, cse102]).
course(cse528, "Introduction to Blockchain and Cryptocurrency", []).
course(cse525, "Introduction to Graduate Algorithms", [cse222]).
course(cse140, "Introduction to Intelligent Systems", []).
course(cse571, "Introduction to Media Computing", []).
course(cse101, "Introduction to Programming", []).
course(cse622, "Introduction to Quantum Computing", [mth100]).
course(cse555, "Introduction to Spatial Computing", [cse102, cse202]).
course(cse343, "Machine Learning", [mth100, mth201, mth101]).
course(ece577, "Machine Learning Techniques for Real Time Control", []).
course(cse559, "Mining Large Networks", [cse222, cse101, mth201]).
course(cse556, "Mobile and Middleware Systems", [cse535, cse232]).
course(cse535, "Mobile Computing", [cse101]).
course(cse319, "Modern Algorithm Design", [cse232]).
course(cse563, "Multimedia Computing and Applications", []).
course(cse694F, "Multimedia Security", [ece350]).
course(cse556, "Natural Language Processing", [cse101, cse222, mth201, mth100]).
course(cse233, "Network Adminstration", []).
course(cse749, "Network Anonymity and Privacy", []).
course(cse655, "Network Science", []).
course(cse350, "Network Security", []).
course(cse354, "Network and System Security", [cse231, cse232]).
course(cse231, "Operating Systems", [cse102]).
course(cse634, "Parallel Runtimes for Modern Processors", [cse201, cse231]).
course(cse645, "Privacy and Security in Online Social Media", []).
course(cse561, "Probabilistic Graphic Models", [mth201]).
course(cse503, "Program Analysis", [cse201, cse102]).
course(cse584, "Program Verification", [mth210]).
course(cse523, "Randomized Algorithms", [cse222, cse121, mth201]).
course(cse564, "Reinforcement Learning", [mth201]).
course(cse633, "Robotics", []).
course(cse552, "Security Engineering", [cse231]).
course(cse632, "Sematic Web", [cse101, cse202]).
course(cse576, "Smart Sensing for Internet of Things", []).
course(cse565, "Software Defined Networking", [cse232]).
course(cse583, "Software Development using Open Source", []).
course(cse582, "Software Production Evolution and Maintenance", []).
course(cse572, "Speech and Audio Processing", [mth100, ece250]).
course(cse609, "Statistical Computation", [mth201]).
course(cse342, "Statistical Machine Learning", [cse101, mth201]).
course(cse322, "Theory Of Computation", [mth210]).
course(cse516, "Thories of Deep Learning", []).
course(cse524, "Theory of Modern cryptography", []).
course(cse651, "Topics in Adaptive Cybersecurity", [cse345]).
course(cse701, "Topics in SE: AI in SE", []).
course(cse660, "Trustworthy AI systems", [cse643, cse343]).
course(cse570, "Virtual Reality", []).
course(cse538, "Wireless Networks", [cse232]).
course(ece573, "Advanced Embedded Logic Design", [cse234]).
course(ece315, "Analog CMOS Circuit Design", []).
course(ece431, "Antennas Theory and Design", [ece230]).
course(ece581, "Autonomous Driving", [ece570]).
course(ece215, "Circuit Thoery and Design", []).
course(ece554, "Compressive Sensing", [mth100]).
course(ece560, "Data Processing and Management", []).
course(ece111, "Digital Circuits", []).
course(ece340, "Digital Communication Systems", [ece240]).
course(ece510, "Digital Hardware Design", [ece270]).
course(ece351, "Digital Signal Processing", [ece250]).
course(ece314, "Digital VLSI Design", [ece270]).
course(ece270, "Embedded Logic Design", []).
course(ece230, "Fields and Waves", [mth100]).
course(ece522, "Integrated Circuit Fabrication", []).
course(ece214, "Integrated Electronics", [ece111, ece113, des130]).
course(ece519, "Intelligent Application Implementation on Hetrogeneous Platforms", [cse112]).
course(ece517, "Introduction to Nanoelectronics", []).
course(ece570, "Linear Systems Thoery", []).
course(ece520, "Low Voltage Analog Circuit Design", [ece315]).
course(ece611, "Memory Design and testing", [ece111, ece113]).
course(ece612, "Mixed Signal Design", [ece315]).
course(ece343, "Mobile Communications", [ece240]).
course(ece579, "Nonlinear and Adaptive Control of RObotic Systems", []).
course(ece534, "Optical Communications Systems", [ece240]).
course(ece532, "Optical Fiber Networks for Industry", []).
course(ece571, "Optimal Control Systems", []).
course(ece545, "Photonics: Fundamentals & Applications", [ece230]).
course(ece543, "Principals of Digital Communication Systems", [ece240]).
course(ece240, "Principals of Communication Systems", [ece250, mth201]).
course(ece501, "Probability and Random Processes", [ece240]).
course(ece524, "Quantum Materials and Devices", []).
course(ece432, "Radar Systems", [ece250]).
course(ece321, "RF Circuit Design", [ece230]).
course(ece533, "Satellite Navigation and Sensor Fusion", [ece351]).
course(ece250, "Signals and Systems", [mth100]).
course(ece318, "Solid State Devices", []).
course(ece557, "Speech Recognition and Understanding", [ece250]).
course(ece672, "Statistical Signal Processing", [mth100, mth201, ece250]).
course(ece513, "VLSI Design Flow", [ece101]).
course(ece537, "Wireless Communication from 3G to 5G", [ece240]).
course(ece538, "Wireless Networks", [ece232]).
course(ece539, "Wireless System Implementation", [ece240]).
course(mth212, "Abstract Algebra I", []).
course(mth513, "Abstract Algebra II", [mth100, mth212]).
course(mth510, "Advanced Linear Algebra", [mth100]).
course(mth302, "Algebra", []).
course(mth512, "Algebraic Number Theory", []).
course(mth516, "Analytic Number Theory", [mth341]).
course(mth544, "Calculas in R^N", [mth100, mth203]).
course(mth576, "Categorical Data Analysis", [mth201]).
course(mth514, "Coding Theory", [mth100, mth212, mth513]).
course(mth517, "Combinatorial Optimization", [mth374]).
course(mth311, "Combinatorics and Its Applications", [mth100]).
course(mth341, "Complex Analysis", [mth240]).
course(mth577, "Convex Optimization", [mth100]).
course(mth204, "Diffrential Equations", [mth203]).
course(mth210, "Discrete Structures", []).
course(mth545, "Finite & Spectral Element Methods", [mth100, mth203, mth204]).
course(mth375, "Fluid Mechainics", [mth204]).
course(mth310, "Graph Theory", []).
course(mth571, "Integral Transforms", [mth204]).
course(mth343, "Introduction to Dynamical Systems", []).
course(mth542, "Introduction to Functial Analysis", [mth100]).
course(mth300, "Introduction to Mathematical Logic", []).
course(mth550, "Introduction to PDE", [mth204]).
course(mth100, "Linear Algebra", []).
course(mth374, "Linear Optimization", [mth100]).
course(mth203, "Multivariate Calculas", []).
course(mth211, "Number Theory", []).
course(mth270, "Numerical Methods", [mth100, mth204]).
course(mth562, "Point Set Topology", []).
course(mth201, "Probability and Statistics", []).
course(mth240, "Real Analyisis", []).
course(mth372, "Statistical Inference", [mth201]).
course(mth518, "Topics in Number Theory", [mth211]).
course(des506, "Advanced topics in Human Centered Computing", [des204]).
course(des101, "Design Drawing and Visualization", []).
course(des509, "Design Futures", [des519]).
course(des519, "Design of Interactive Systems", []).
course(des201, "Design Process and Perspectives", [des101]).
course(des512, "Game design and Development", []).
course(des520, "Human Centered AI", [des204, cse343]).
course(des204, "Human Computer Interaction", []).
course(des502, "Introduction to 2D animation", [des518]).
course(des302, "Introduction to Animation and Graphics", []).
course(des102, "Introduction to HCI", []).
course(des518, "Introduction to Motion Graphics", [des518]).
course(des130, "Prototyping Interactive Systems", []).
course(des504, "Narratives in Visual Communication", []).
course(des202, "Visual Design and Communication", [des101]).
course(des513, "WARDI", []).
course(ssh311, "Advanced Writing", []).
course(ssh321, "Applied Ethics", []).
course(psy305, "Attention and Perception", []).
course(eco314, "Behavioroul Economics", [mth201]).
course(psy301, "Cognitive Psychology", []).
course(ssh124, "Critical Thinking", []).
course(soc206, "Business Anthropology", []).
course(eco503, "Decision Theory", []).
course(eco221, "Econometrics I", [mth201]).
course(eco322, "Econometrics II", [eco221]).
course(eco331, "Foundations of Finance", []).
course(eco311, "Game Theory", []).
course(ssh121, "Introduction to Philosophy", []).
course(psy201, "Introduction to Psychology", [ssh101]).
course(eco201, "Macroeconomics", []).
course(psy306, "Learning and Memory", []).
course(eco301, "Microeconomics", []).
course(eco223, "Money and Banking", []).
course(ssh323, "New Media and Politics", []).
course(ssh324, "Philosophy of Mind", [ssh121]).
course(psy202, "Positive Psychology", []).
course(psy302, "Social Psychology", []).
course(soc210, "Sociological Theory", []).
course(ssh211, "Theatre Appreciation", []).
course(soc302, "Urban Sociology", []).
course(ent416, "Creativity Innovation and Inventive Problem Solving", []).
course(ent411, "Entrepreneurial Communication", []).
course(ent412, "Entrepreneurial Khichadi", []).
course(ent413, "Entrepreneurial Finance", []).
course(ent415, "New Venture Planning", []).
course(esc205, "Environmental Sciences", []).
