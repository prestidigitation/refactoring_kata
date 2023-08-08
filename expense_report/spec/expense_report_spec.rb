require_relative "../expense_report"

RSpec.describe "printReport" do
  it "prints out a list of expenses" do
    expenses = [
      Expense.new(:breakfast, 1000),
      Expense.new(:breakfast, 1001),
      Expense.new(:dinner, 5000),
      Expense.new(:dinner, 5001),
      Expense.new(:car_rental, 13000)
    ]

    time = Time.new(0)

    # expected_report = "Expenses: 2023-08-07 20:06:38 -0400\nBreakfast\t1000\t \nBreakfast\t1001\tX\nDinner\t5000\t \nDinner\t5001\tX\nCar Rental\t13000\t \nMeal Expenses: 12002\nTotal Expenses: 25002\n"
    expected_report = "Expenses: 0000-01-01 00:00:00 -0456\nBreakfast\t1000\t \nBreakfast\t1001\tX\nDinner\t5000\t \nDinner\t5001\tX\nCar Rental\t13000\t \nMeal Expenses: 12002\nTotal Expenses: 25002\n"

    expect { printReport(*expenses, time) }.to output(expected_report).to_stdout
  end
end
