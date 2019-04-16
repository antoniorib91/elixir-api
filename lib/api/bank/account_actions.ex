defmodule Api.Bank.Account.AccountActions do

  alias Api.Bank

  def transfer(from_id, to_id, ammount) do
    ammount = String.to_float(ammount)
    withdraw(from_id, ammount)
    deposit(to_id, ammount)
  end


  def withdraw(id, ammount) do
    account = Bank.get_account!(id)
    new_balance = account.balance - ammount
    Bank.update_account(account, %{balance: new_balance})
  end

  def deposit(id, ammount) do
    account = Bank.get_account!(id)
    new_balance = account.balance + ammount
    Bank.update_account(account, %{balance: new_balance})
  end


end
