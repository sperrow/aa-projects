class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multipier)
    @salary * multipier
  end
end


class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multipier)
    salaries = 0
    stack = [] + @employees
    until stack.empty?
      employee = stack.pop
      if employee.is_a?(Manager)
        stack += employee.employees
      end
      salaries += employee.salary
    end
    salaries * multipier
  end
end


if __FILE__ == $PROGRAM_NAME
  david = Employee.new('David', "TA", 10000, "Darren")
  shawna = Employee.new('Shawna', "TA", 12000, "Darren")
  darren = Manager.new('Darren', "TA Manager", 78000, "David", [david, shawna])
  ned = Manager.new('Ned', "Founder", 1000000, nil, [darren])
  puts ned.bonus(5) # => 500_000
  puts darren.bonus(4) # => 88_000
  puts david.bonus(3) # => 30_000
end
