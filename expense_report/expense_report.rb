#!/usr/bin/ruby

class Expense
  attr_reader :type, :amount
  def initialize(type, amount)
    @type = type
    @amount = amount
  end
end

class ExpenseReport
  def print_report(*expenses, time)
    total = 0
    mealExpenses = 0
    # puts "Expenses: #{Time.now}"
    puts "Expenses: #{time}"
    for expense in expenses
      if expense.type == :dinner || expense.type == :breakfast
        mealExpenses += expense.amount
      end
      expenseName = ""
      case expense.type
      when :breakfast
          expenseName = "Breakfast"
      when :dinner
          expenseName = "Dinner"
      when :car_rental
          expenseName = "Car Rental"
      end
      mealOverExpensesMarker = expense.type == :dinner && expense.amount > 5000 || expense.type == :breakfast && expense.amount > 1000 ? "X" : " "
      puts "#{expenseName}\t#{expense.amount}\t#{mealOverExpensesMarker}"
      total += expense.amount
    end
    puts "Meal Expenses: #{mealExpenses}" + "\n"
    puts "Total Expenses: #{total}" + "\n"
  end
end
