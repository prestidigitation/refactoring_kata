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
      Expense.new(ExpenseType.new(type: :breakfast, meal: true), 1000),
      Expense.new(ExpenseType.new(type: :breakfast, meal: true), 1001),
      Expense.new(ExpenseType.new(type: :dinner, meal: true), 5000),
      Expense.new(ExpenseType.new(type: :dinner, meal: true), 5001),
      Expense.new(ExpenseType.new(type: :car_rental), 13000),
      Expense.new(ExpenseType.new(type: :car_rental), 92233720368547)
    ]

    report = ExpenseReport.new
    time = Time.new(0)

    expected_result = "Expenses: 0000-01-01 00:00:00 -0456\nBreakfast\t1000\t \nBreakfast\t1001\tX\nDinner\t5000\t \nDinner\t5001\tX\nCar Rental\t13000\t \nCar Rental\t92233720368547\t \nMeal Expenses: 12002\nTotal Expenses: 92233720393549\n"

    expect { report.print_report(*expenses, time) }.to output(expected_result).to_stdout
  end
end
