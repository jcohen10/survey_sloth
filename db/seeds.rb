richard = Student.create(name: "Richard")
raghav = Student.create(name: "Raghav")

stephen = Teacher.create(name: "Stephen")

dbc_1 = Klass.create(name: "Active Record 101")
dbc_2 = Klass.create(name: "Sinatra 101")



# richard = Student.first
# raghav = Student.all[1]
# stephen = Teacher.first
# dbc_1 = Klass.first
# dbc_2 = Klass.all[1]
# stephen.klasses # => should be empty array
# stephen.klasses << dbc_1 << dbc_2