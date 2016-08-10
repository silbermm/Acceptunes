defmodule DailyRallyItemsTest do
  use ExUnit.Case

  alias Acceptunes.DailyRallyItems

  test "should call the rally endpoint" do
    { date, time } = :os.timestamp |> :calendar.now_to_datetime
    formated = "#{elem(date,0)}-#{elem(date,1)}-#{elem(date,2)} 00:00:00Z"
    result = DailyRallyItems.get(12345)
    assert result.status_code == 200
    assert result.total_results == 2
    assert result.object_ids == [56064976699, 59699635251]
  end


end
