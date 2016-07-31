defmodule DailyRallyItemsTest do
  use ExUnit.Case

  alias Acceptunes.DailyRallyItems

  test "should call the rally endpoint" do
    datetime = Timex.now 
                |> Timex.beginning_of_day
                |> Timex.format!("{ISO:Extended:Z}")
    result = DailyRallyItems.get(12345)
    assert result.status_code == 200
    assert result.total_results == 2
    assert result.object_ids == [56064976699, 59699635251]
  end


end
