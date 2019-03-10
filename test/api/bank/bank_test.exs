defmodule Api.BankTest do
  use Api.DataCase

  alias Api.Bank

  describe "accounts" do
    alias Api.Bank.Account

    @valid_attrs %{balance: 120.5, name: "some name", status: 42}
    @update_attrs %{balance: 456.7, name: "some updated name", status: 43}
    @invalid_attrs %{balance: nil, name: nil, status: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bank.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Bank.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Bank.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Bank.create_account(@valid_attrs)
      assert account.balance == 120.5
      assert account.name == "some name"
      assert account.status == 42
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Bank.update_account(account, @update_attrs)
      assert account.balance == 456.7
      assert account.name == "some updated name"
      assert account.status == 43
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_account(account, @invalid_attrs)
      assert account == Bank.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Bank.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Bank.change_account(account)
    end
  end
end
