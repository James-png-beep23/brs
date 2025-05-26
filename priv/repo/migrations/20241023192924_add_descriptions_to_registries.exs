defmodule Brs.Repo.Migrations.AddDescriptionsToRegistries do
  use Ecto.Migration

  def change do
    alter table(:registries) do
      add_if_not_exists :description, :string
    end
  end

end
