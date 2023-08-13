require_relative "../expense_report"

RSpec.describe ExpenseReport do
  it "prints out an empty list of expenses" do
    report = ExpenseReport.new
    time = Time.new(0)

    expected_result = "Expenses: 0000-01-01 00:00:00 -0456\nMeal Expenses: 0\nTotal Expenses: 0\n"

    expect { report.print_report(*[], time) }.to output(expected_result).to_stdout
  end
  
  it "prints out a list of expenses" do
    expenses = [
      Expense.new(ExpenseType.new(:breakfast), 1000),
      Expense.new(ExpenseType.new(:breakfast), 1001),
      Expense.new(ExpenseType.new(:lunch), 2000),
      Expense.new(ExpenseType.new(:lunch), 2001),
      Expense.new(ExpenseType.new(:dinner), 5000),
      Expense.new(ExpenseType.new(:dinner), 5001),
      Expense.new(ExpenseType.new(:car_rental), 13000),
      Expense.new(ExpenseType.new(:car_rental), 92233720368547)
    ]

    report = ExpenseReport.new
    time = Time.new(0)

    expected_result = "Expenses: 0000-01-01 00:00:00 -0456\nBreakfast\t1000\t \nBreakfast\t1001\tX\nLunch\t2000\t \nLunch\t2001\tX\nDinner\t5000\t \nDinner\t5001\tX\nCar Rental\t13000\t \nCar Rental\t92233720368547\t \nMeal Expenses: 16003\nTotal Expenses: 92233720397550\n"

    expect { report.print_report(*expenses, time) }.to output(expected_result).to_stdout
  end
end
