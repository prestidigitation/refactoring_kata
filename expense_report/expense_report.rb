#!/usr/bin/ruby

class Expense
  attr_reader :type, :amount
  def initialize(type, amount)
    @type = type
    @amount = amount
  end

  def is_meal?
    type == :dinner || type == :breakfast
  end

  def get_name
    expenseName = ""
    case type
    when :breakfast
        expenseName = "Breakfast"
    when :dinner
        expenseName = "Dinner"
    when :car_rental
        expenseName = "Car Rental"
    end
  end

  def is_over_limit?
    type == :dinner && amount > 5000 || type == :breakfast && amount > 1000
  end
end

class ExpenseReport
  def print_report(*expenses, time)
    total = 0
    mealExpenses = 0
    # puts "Expenses: #{Time.now}"
    puts "Expenses: #{time}"
    for expense in expenses
      if expense.is_meal?
        mealExpenses += expense.amount
      end
      expense_name = expense.get_name
      mealOverExpensesMarker = expense.is_over_limit? ? "X" : " "
      puts "#{expense_name}\t#{expense.amount}\t#{mealOverExpensesMarker}"
      total += expense.amount
    end
    puts "Meal Expenses: #{mealExpenses}" + "\n"
    puts "Total Expenses: #{total}" + "\n"
  end
end
