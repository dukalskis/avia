defmodule AdminApp.Product.SearchContext do
  import Ecto.Query
  alias Snitch.Data.Schema.Product
  alias Snitch.Pagination
  alias Snitch.Core.Tools.MultiTenancy.Repo

  def search_products_by_name(%{"term" => term, "page" => page} = payload) do
    Product
    |> where(
      [p],
      (ilike(p.name, ^"%#{term}%") or ilike(p.sku, ^"%#{term}%")) and is_nil(p.deleted_at)
    )
    |> preload([:images, :variants])
    |> Pagination.page(page)
  end
end