import pymysql

conn = pymysql.connect(host='localhost', user='root', password='', db='university', charset='utf8mb4')

cursor = conn.cursor()

# student table 정의
sql_student = """create table student (
    sno char(7) not null,
    sname varchar(20),
    grade int default 1, 
    dept varchar(20),
    primary key(sno))"""

# course table 정의
sql_course = """create table course (
    cno char(4) not null,
    cname varchar(30),
    credit int, 
    profname varchar(20),
    dept varchar(20),
    primary key(cno))"""

# enroll table 정의
sql_enroll = """create table enroll (
    sno varchar(7) not null,
    cno varchar(4) not null,
    final int,
    lettergrade varchar(2),
    primary key(sno, cno),
    foreign key(sno) references student(sno),
    foreign key(cno) references course(cno))"""


# 정의한 table을 생성
cursor.execute("set foreign_key_checks = 0")
cursor.execute("drop table IF EXISTS student cascade")
cursor.execute("drop table IF EXISTS course cascade")
cursor.execute("drop table IF EXISTS enroll cascade")
cursor.execute(sql_student)
cursor.execute(sql_course)
cursor.execute(sql_enroll)
cursor.execute("set foreign_key_checks = 1")


# execute 실행 함수
def execution(sql):
    try:
        cursor.execute(sql)
    except Exception as error:
        print(error)


# input, output 파일 열기
r_file = open("input.txt", "r", encoding="UTF-8")
w_file = open("output.txt", "w")


# 함수명 : insert_record_student()
# 입력값 : sno, sname, grade, dept
# insert 수행
def insert_record_student(sno, sname, grade, dept):
    sql = "insert into student values('" + sno + "', '" + sname + "', " + grade + ",'" + dept + "')"
    execution(sql)



# 함수명 : insert_record_course()
# 입력값 : cno, cname, credit, profname, dept
# course 테이블에 입력값 insert 수행
def insert_record_course(cno, cname, credit, profname, dept):
    sql = "insert into course values('" + cno + "', '" + cname + "', " + credit + ", '" + profname + "', '" + dept + "')"
    execution(sql)


# 함수명 : insert_record_enroll()
# 입력값 : sno, cno, final, lettergrade
# enroll 테이블에 입력값 insert 수행
def insert_record_enroll(input_value):
    (sno, cno, final, lettergrade) = input_value.split(" ")  # 입력값을 enroll의 각 값에 배정
    sql = "insert into enroll values('" + sno + "', '" + cno + "', " + final + ", '" + lettergrade + "')"
    execution(sql)


# student 검색 함수 : student 테이블의 모든 값을 검색
def search_student():
    cursor.execute("select * from student")
    rows = cursor.fetchall()

    print("학번                  이름      학년                   학과")
    for row in rows:
        sno = row[0]
        sname = row[1]
        grade = row[2]
        dept = row[3]
        w_file.write("%7s %20s %5d %20s" % (sno, sname, grade, dept) + "\n")
        print("%7s %20s %5d %20s" % (sno, sname, grade, dept))


# course 검색 함수 : course 테이블의 모든 값을 검색
def search_course():
    cursor.execute("select * from course")
    rows = cursor.fetchall()
    print("학수번호                  과목명      학점                   담당교수                   학과")
    for row in rows:
        cno = row[0]
        cname = row[1]
        credit = row[2]
        profname = row[3]
        dept = row[4]
        w_file.write("%7s %20s %5d %20s %20s" % (cno, cname, credit, profname, dept) + "\n")
        print("%7s %20s %5d %20s %20s" % (cno, cname, credit, profname, dept))



# enroll 검색 함수 : enroll 테이블의 모든 값을 검색
def search_enroll():
    cursor.execute("select * from enroll")
    rows = cursor.fetchall()
    print("학번                  과목번호      기말점수                   학점")
    for row in rows:
        sno = row[0]
        cno = row[1]
        final = row[2]
        lettergrade = row[3]
        w_file.write("%7s %20s %5d %20s" % (sno, cno, final, lettergrade) + "\n")
        print("%7s %20s %5d %20s" % (sno, cno, final, lettergrade))


# 입력파일 함수
# input 파일의 값을 Line 으로 읽어 해당 번호에 맞는 함수를 실행
def input_file():
    while True:
        line = r_file.readline()
        if not line:
            break
        line = line.strip()

        if line == "0":
            w_file.write("0: 종료" + "\n")
            print("0: 종료")
            return

        elif line == "1":
            w_file.write("1: student 레코드 검색" + "\n")
            print("1: student 레코드 검색")
            search_student()

        elif line == "2":
            w_file.write("2: course 레코드 검색" + "\n")
            print("2: course 레코드 검색")
            search_course()

        elif line == "3":
            w_file.write("3: enroll 레코드 검색" + "\n")
            print("3: enroll 레코드 검색")
            search_enroll()

        elif line == "4":
            print("4: enroll 레코드 삽입")
            w_file.write("4: enroll 레코드 삽입" + "\n")
            continue  # 4번의 경우 다음 줄을 읽기 위해 continue

        else:
            print(line)
            w_file.write(line + "\n")
            insert_record_enroll(line)


# 하드코딩으로 기존 값 입력
def do_insert():
    insert_record_student("B922019", "김영희", "4", "기계")
    insert_record_student("B990617", "홍철수", "3", "컴퓨터")

    insert_record_course("C101", "동역학", "3", "김공과", "기계")
    insert_record_course("C102", "데이터베이스", "4", "유대학", "컴퓨터")


# 함수 실행
do_insert()
input_file()

cursor.execute("set foreign_key_checks = 0")
cursor.execute("drop table IF EXISTS student cascade")
cursor.execute("drop table IF EXISTS course cascade")
cursor.execute("drop table IF EXISTS enroll cascade")
cursor.execute("set foreign_key_checks = 1")

conn.close()
r_file.close()
w_file.close()
