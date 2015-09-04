# encoding: UTF-8

require 'gooddata'

# Connect to GoodData platform
GoodData.with_connection do |c|
  GoodData.with_project('project_id') do |project|
    fact = project.facts('fact.commits.lines_changed')
    metric = fact.create_metric(:title => "Sum of [#{fact.identifier}]")
    res = metric.execute
    puts res

    # if you like the metric you can save it of course for later usage
    metric.save

    # Default aggregation is SUM but you can also specify a different one
    metric = fact.create_metric(:title => "Min of [#{fact.identifier}]", type: :min)
  end
end