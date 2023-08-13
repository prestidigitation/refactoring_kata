#!/usr/bin/ruby

class ExpenseType
  attr_reader :type, :limit

  TYPES = {
    dinner: { limit: 5000, meal: true },
    lunch: { limit: 2000, meal: true },
    breakfast: { limit: 1000, meal: true },
    car_rental: {}
  }.freeze

  def initialize(type)
    @type = type
    type_properties = TYPES.fetch(type) { raise ArgumentError, "Invalid Expense Type" }
    @meal = type_properties.fetch(:meal, false)
    @name = type_properties.fetch(:name, nil)
    @limit = type_properties.fetch(:limit, nil)
  end

  def is_meal?
    meal
  end

  def get_name
    if name.nil?
      type.to_s.split("_").map(&:capitalize).join(" ")
    else
      name
    end 
  end

  private

  attr_reader :meal, :name
end

class Expense
  attr_reader :type, :amount
  def initialize(type, amount)
    @type = type
    @amount = amount
  end

  def is_meal?
    type.is_meal?
  end

  def get_name
    type.get_name
  end

  def is_over_limit?
    if !type.limit
      false
    else
      amount > type.limit
    end
  end
end

class ExpenseReport
  def print_report(*expenses, time)
    # puts "Expenses: #{Time.now}"
    puts "Expenses: #{time}"
    meal_expenses = get_meal_expenses(expenses)
    total = get_total(expenses)
    expenses.each { |expense| print_single_expense(expense) }
    puts "Meal Expenses: #{meal_expenses}" + "\n"
    puts "Total Expenses: #{total}" + "\n"
  end

  def get_meal_expenses(expenses)
    expenses.sum { |expense| expense.is_meal? ? expense.amount : 0 }
  end

  def get_total(expenses)
    expenses.sum { |expense| expense.amount }
  end

  def print_single_expense(expense)
    meal_over_expenses_marker = expense.is_over_limit? ? "X" : " "
    puts "#{expense.get_name}\t#{expense.amount}\t#{meal_over_expenses_marker}"
  end
end
