defmodule Acceptunes.DailyRallyItems do
  @moduledoc """
  Handles getting daily rally items by formatting todays date.
  """
  require Logger
  require IEx

  def today do
    {date, _time} = :os.timestamp |> :calendar.now_to_local_time
    date
    |> format_month
    |> format_day
    |> format_date
  end

  def format(response, today) do
    case response do
      {:ok, %HTTPoison.Response{body: %{"Results": nil}}} ->
        Logger.error("Got an empty result from Rally")
        %Acceptunes.RallyResult{}
      {:ok, %HTTPoison.Response{body: %{"Errors" => []} = body}} ->
        Logger.info("No new items")
        %Acceptunes.RallyResult{}
      {:ok, %HTTPoison.Response{body: %{"Errors" => err} = body}} ->
        Logger.error("Unable to get accepted items #{err}")
        %Acceptunes.RallyResult{}
        Logger.info("New item(s) as of #{today}")
      {:ok, response} ->
        Logger.info("New items as of #{today}")
        #object_ids = Enum.map(response.body["Results"], fn(obj) ->
          #obj["ObjectID"]
        #end)
        %Acceptunes.RallyResult{
          status_code: response.status_code,
          total_results: response.body["TotalResultCount"],
          #object_ids: object_ids
        }
      {:error, err} -> 
        %Acceptunes.RallyResult{}
    end
  end

  def get(projectId) do
    :get |> Rally.query(projectId, today) |> format(today)
  end

  defp format_month({year, month, day}) when month < 10 do
    {year, "0#{month}", day}
  end
  defp format_month({year, month, day}), do: {year, "#{month}", day}

  defp format_day({year, month, day}) when day < 10 do
    {year, month, "0#{day}"}
  end
  defp format_day({year, month, day}), do: {year, month, "#{day}"}

  defp format_date({year, month, day}) do
    "#{year}-#{month}-#{day}T04:00:00Z"
  end
end
