defmodule Api.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :balance, :float
      add :status, :integer

      timestamps()
    end

  end
end
