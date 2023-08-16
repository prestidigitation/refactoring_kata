#!/usr/bin/ruby
# frozen_string_literal: true

class ExpenseType
  attr_reader :type, :limit, :name

  TYPES = {
    dinner: { limit: 5000, meal: true },
    lunch: { limit: 2000, meal: true },
    breakfast: { limit: 1000, meal: true },
    car_rental: {}
  }.freeze

  def initialize(type)
    @type = type
    type_properties = TYPES.fetch(type) { raise ArgumentError, 'Invalid Expense Type' }
    @meal = type_properties.fetch(:meal, false)
    @name = type_properties.fetch(:name) { type.to_s.split('_').map(&:capitalize).join(' ') }
    @limit = type_properties.fetch(:limit, nil)
  end

  def meal?
    meal
  end

  private

  attr_reader :meal
end

class Expense
  attr_reader :type, :amount

  def initialize(type, amount)
    @type = type
    @amount = amount
  end

  def meal?
    type.meal?
  end

  def name
    type.name
  end

  def over_limit?
    if !type.limit
      false
    else
      amount > type.limit
    end
  end
end

class ExpenseReport
  def print_report(*expenses, time)
    puts "Expenses: #{time}"
    meal_expenses = meal_expenses_total(expenses)
    total = all_expenses_total(expenses)
    expenses.each { |expense| print_single_expense(expense) }
    puts "Meal Expenses: #{meal_expenses}\n"
    puts "Total Expenses: #{total}\n"
  end

  def meal_expenses_total(expenses)
    expenses.sum { |expense| expense.meal? ? expense.amount : 0 }
  end

  def all_expenses_total(expenses)
    expenses.sum(&:amount)
  end

  def print_single_expense(expense)
    meal_over_expenses_marker = expense.over_limit? ? 'X' : ' '
    puts "#{expense.name}\t#{expense.amount}\t#{meal_over_expenses_marker}"
  end
end
