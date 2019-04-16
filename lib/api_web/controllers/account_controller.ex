defmodule ApiWeb.AccountController do
  use ApiWeb, :controller

  alias Api.Bank
  alias Api.Bank.Account
  alias Api.Bank.Account.AccountActions

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    accounts = Bank.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Bank.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
    account = Bank.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Bank.get_account!(id)
    with {:ok, %Account{} = account} <- Bank.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Bank.get_account!(id)
    with {:ok, %Account{}} <- Bank.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end

  def transfer(conn, %{"from" => account_from_id, "to" => account_to_id, "ammount" => ammount}) do
    with {:ok, %Account{}} <- AccountActions.transfer(account_from_id, account_to_id, ammount) do
      send_resp(conn, :ok, "ok")
    end
  end

  def deposit(conn, %{"account" => account_id, "ammount" => ammount})do
    with {:ok, %Account{}} <- AccountActions.deposit(account_id, ammount) do
      send_resp(conn, :ok, "success")
    end
  end

  def withdraw(conn, %{"account" => account_id, "ammount" => ammount})do
    with {:ok, %Account{}} <- AccountActions.withdraw(account_id, ammount) do
      send_resp(conn, :ok, "success")
    end
  end

end
