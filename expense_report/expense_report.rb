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
    case type
    when :breakfast
      "Breakfast"
    when :dinner
      "Dinner"
    when :car_rental
      "Car Rental"
    end
  end

  def is_over_limit?
    type == :dinner && amount > 5000 || type == :breakfast && amount > 1000
  end
end

class ExpenseReport
  def print_report(*expenses, time)
    total = 0
    meal_expenses = 0
    # puts "Expenses: #{Time.now}"
    puts "Expenses: #{time}"
    expenses.each do |expense|
      if expense.is_meal?
        meal_expenses += expense.amount
      end
      expense_name = expense.get_name
      meal_over_expenses_marker = expense.is_over_limit? ? "X" : " "
      puts "#{expense_name}\t#{expense.amount}\t#{meal_over_expenses_marker}"
      total += expense.amount
    end
    puts "Meal Expenses: #{meal_expenses}" + "\n"
    puts "Total Expenses: #{total}" + "\n"
  end
end
