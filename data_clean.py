# Taking "gfg input file.txt" as input file
# in reading mode
with open("data.pl", "r") as input:
    with open("clean_data.pl", "w") as output:
        for line in input:
            if(line[0]!="c"):
                continue
            indx1 = line.index("(")
            indx2 = line.index(")")
            line = line[indx1+1:indx2]
            values = line.split(",")
            indx1 = line.index("[")+1
            indx2 = line.index("]")
            courses = line[indx1:indx2]
            courses = courses.split(',')
            to_write = "course("+values[0]+','+values[1]+', ['
            for c in courses:
                if(to_write[-1]=='['):
                    to_write+=c
                else:
                    to_write+=','+c
            to_write+=']).\n'
            output.write(to_write)
			
# 