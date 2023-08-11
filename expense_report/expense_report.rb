#!/usr/bin/ruby

class ExpenseType
  attr_reader :type
  def initialize(type)
    @type = type
  end

  def is_meal?
    type == :dinner || type == :breakfast
  end

  def get_name
    type.to_s.split("_").map(&:capitalize).join(" ")
  end
end

class Expense
  attr_reader :type, :amount
  def initialize(type, amount)
    @type = ExpenseType.new(type)
    @amount = amount
  end

  def is_over_limit?
    type.type == :dinner && amount > 5000 || type.type == :breakfast && amount > 1000
  end
end

class ExpenseReport
  def print_report(*expenses, time)
    total = 0
    meal_expenses = 0
    # puts "Expenses: #{Time.now}"
    puts "Expenses: #{time}"
    expenses.each do |expense|
      expense_type = expense.type
      if expense_type.is_meal?
        meal_expenses += expense.amount
      end
      expense_name = expense_type.get_name
      meal_over_expenses_marker = expense.is_over_limit? ? "X" : " "
      puts "#{expense_name}\t#{expense.amount}\t#{meal_over_expenses_marker}"
      total += expense.amount
    end
    puts "Meal Expenses: #{meal_expenses}" + "\n"
    puts "Total Expenses: #{total}" + "\n"
  end
end
