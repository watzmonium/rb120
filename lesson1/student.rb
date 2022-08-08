class Student
  attr_accessor :name
  attr_writer :grade

  def better_than_grade?(student)
    self.grade > student.grade
  end

  protected

  attr_reader :grade

end

joe = Student.new
joe.grade = 95

bob = Student.new
bob.grade = 80
p joe.better_than_grade?(bob)