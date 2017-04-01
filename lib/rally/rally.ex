defmodule Rally do
  @moduledoc """
  Provides the query method for Rally.
  """
  use HTTPoison.Base
  require IEx
  @rally_api_key Application.get_env(:acceptunes, :rally_api_key)
  @workspace_id Application.get_env(:acceptunes, :rally_workspace_id)

  def headers do
    %{
      "ZSESSIONID" => @rally_api_key
    }
  end

  def query(:get, projectId, accepted_date) do
    query = [
        ~s({"__At":"current",),
        ~s("Project":"#{projectId}",),
        ~s("ScheduleState":"Accepted",),
        ~s("AcceptedDate":{"$gte":"#{accepted_date}"}})
    ]
    path = %{
      "find" => Enum.join(query),
      "fields" => ~s(["ObjectID"]),
      "start" => 0,
      "pagesize" => 100,
      "removeUnauthorizedSnapshots" => true
    }
    IEx.pry
    get("find=%7B%22__At%22:%22current%22,%22Project%22:#{projectId},%20%22ScheduleState%22:%22Accepted%22,%22AcceptedDate%22:%20%7B%20%22$gte%22:%20%22#{accepted_date}%22%7D%20%7D&fields=%5B%22ObjectID%22%5D&start=0&pagesize=100&removeUnauthorizedSnapshots=true", headers)
  end

  def process_url("/" <> path), do: process_url(path)
  def process_url(path), do: "https://rally1.rallydev.com/analytics/v2.0/service/rally/workspace/#{@workspace_id}/artifact/snapshot/query.js?" <> path

  def process_response_body(body) do
    body
    |> Poison.decode
    |> validate_decode
  end

  defp validate_decode({:ok, data}), do: data
  defp validate_decode({:error, reason}) do
    "{\"error\": \"#{reason}\"}"
  end
end
