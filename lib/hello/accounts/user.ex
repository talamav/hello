defmodule Hello.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :name, :string
    # field :role, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end

  @doc false
  def user_changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def admin_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
    |> validate_number(:age, greater_than: 18, message: "Incorrect age")
    |> validate_name()
  end

  defp validate_name(changeset) do
    name = get_field(changeset, :name)
    if String.starts_with?(name, "A") do
      changeset
    else
      add_error(changeset, :name, "Our rule requires the name to start with A")
    end
  end
end
