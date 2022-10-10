require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(str)
        salaries.has_key?(str)
    end

    def >(startup_2)
        @funding > startup_2.funding
    end

    def hire(emp_name, title)
        if !valid_title?(title)
            raise 'This is an error'
        else
            employees << Employee.new(emp_name, title)
        end
    end

    def size
        @employees.length
    end

    def pay_employee(emp)
        if @salaries[emp.title] <= @funding
            emp.pay(@salaries[emp.title])
            @funding -= @salaries[emp.title]
        else
            raise 'error'
        end
    end

    def payday
        @employees.each {|ele| pay_employee(ele)}
    end

    def average_salary
        arr = []
        @employees.each do |ele|
            arr << @salaries[ele.title]
        end
        arr.sum / arr.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |title, money|
            if !@salaries.has_key?(title)
                @salaries[title] = money
            end
        end

        startup.employees.each { |emp| @employees << emp }

        startup.close
    end



end
