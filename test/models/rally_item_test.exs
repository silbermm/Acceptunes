defmodule Acceptunes.RallyItemTest do
  use Acceptunes.ModelCase

  alias Acceptunes.RallyItem

  @valid_attrs %{itemId: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RallyItem.changeset(%RallyItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RallyItem.changeset(%RallyItem{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "unable to add another item with same itemId" do
    changeset = RallyItem.changeset(%RallyItem{}, @valid_attrs)
    Repo.insert!(changeset)


    changeset2 = RallyItem.changeset(%RallyItem{}, @valid_attrs)
    assert {:error, changeset} = Repo.insert(changeset2)
    assert changeset.errors[:itemId] == "has already been taken"
  end
end
