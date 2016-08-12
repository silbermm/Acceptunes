defmodule Acceptunes.DailyRallyItems do

  @rally_api Application.get_env(:acceptunes, :rally_api)
  @timezone Application.get_env(:acceptunes, :current_timezone) 

  def today do
    { date, time } = :os.timestamp |> :calendar.now_to_local_time
    month = format_month_day(elem(date,1))
    day = format_month_day(elem(date,2))
    formated = "#{elem(date,0)}-#{month}-#{day}T00:00:00Z"
    #datetime = Timex.now(@timezone) 
                #|> Timex.beginning_of_day
    #            |> Timex.format!("{ISO:Extended:Z}")
  end

  def format(response) do
    case response do
      {:ok, response} -> 
        object_ids = Enum.map(response.body["Results"], fn(obj) ->
          obj["ObjectID"]
        end)
        %Acceptunes.RallyResult{
          status_code: response.status_code,
          total_results: response.body["TotalResultCount"],
          object_ids: object_ids
        }
      {:error, err} -> %Acceptunes.RallyResult{}
    end
  end

  def get(projectId) do
    @rally_api.query(:get, projectId, today) |> format
  end

  defp format_month_day(num) do
    cond do
      num < 10 -> "0#{num}"
      true -> "#{num}"
    end

  end

end
