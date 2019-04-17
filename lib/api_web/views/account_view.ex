defmodule ApiWeb.AccountView do
  use ApiWeb, :view
  alias ApiWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("summary.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account_summary.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      name: account.name,
      balance: account.balance,
      status: account.status}
  end

  def render("account_summary.json", %{account: account}) do 
    %{
      name: account.name,
      balance: account.balance
    }
  end
end
