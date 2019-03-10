defmodule Api.Bank.Account do
  use Ecto.Schema
  import Ecto.Changeset


  schema "accounts" do
    field :balance, :float
    field :name, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :balance, :status])
    |> validate_required([:name, :balance, :status])
  end
end
