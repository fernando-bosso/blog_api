defmodule BlogApi.Blog.FavoriteTest do
  @moduledoc false
  use ExUnit.Case
  use BlogApi.DataCase
  alias BlogApi.Blog.Favorite
  import BlogApi.Factory

  describe "schema" do
    test "schema metadata" do
      assert Favorite.__schema__(:source) == "favorites"

      assert Favorite.__schema__(:fields) == [
               :id,
               :user_id,
               :article_id,
               :inserted_at,
               :updated_at
             ]

      assert Favorite.__schema__(:primary_key) == [:id]
    end
  end

  describe "given valid parameters" do
    test "changeset/2" do
      favorite = %Favorite{}
      user = insert(:user)
      article = insert(:article, author: user)

      params = %{
        "user_id" => user.id,
        "article_id" => article.id
      }

      changes = %{
        user_id: user.id,
        article_id: article.id
      }

      changeset = Favorite.changeset(favorite, params)
      assert changeset.params == params
      assert changeset.data == favorite
      assert changeset.changes == changes
      assert changeset.validations == []
      assert changeset.required == [:user_id, :article_id]
      assert changeset.valid?
    end
  end

  describe "given invalid parameters" do
    test "changeset/2" do
      favorite = %Favorite{}
      user = insert(:user)
      article = insert(:article, author: user)

      params = %{
        "user_id" => user.id
      }

      changes = %{
        user_id: user.id
      }

      refute Favorite.changeset(favorite, params).valid?
    end
  end
end
