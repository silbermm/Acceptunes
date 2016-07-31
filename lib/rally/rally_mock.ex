defmodule RallyMock do

  def query(:get, projectId, accepted_date) do
    {:ok,
      %HTTPoison.Response{
        body: %{
          "ETLDate" => "2016-07-29T03:11:49.901Z",
          "Errors" => [],
          "GeneratedQuery" => %{
            "fields" => %{"ObjectID" => 1, "Project" => 1},
            "find" => %{"$and" => [%{
                  "_ValidFrom" => %{ "$lte" => "2016-07-29T03:11:49.901Z"},
                  "_ValidTo" => %{"$gt" => "2016-07-29T03:11:49.901Z"}
                }],
              "AcceptedDate" => %{"$gte" => "#{accepted_date}"},
              "ScheduleState" => %{"$in" => [22244455060]},
              "_ProjectHierarchy" => projectId,
              "_ValidFrom" => %{"$lte" => "2016-07-29T03:11:49.901Z"}},
            "limit" => 100, "skip" => 0
          },
          "HasMore" => false,
          "PageSize" => 100,
          "Results" => [
            %{"ObjectID" => 56064976699 },
            %{"ObjectID" => 59699635251}
          ],
          "StartIndex" => 0,
          "TotalResultCount" => 2,
          "Warnings" => [],
        },
        headers: [
          {"Date", "Fri, 29 Jul 2016 03:12:52 GMT"},
        ],
        status_code: 200
      }
    }
  end

end
