# encoding: utf-8

require 'gooddata'

GoodData.logging_on

GoodData.with_connection do |c|
  blueprint = GoodData::Model::ProjectBlueprint.build('Acme project') do |p|
    p.add_date_dimension('committed_on')
    p.add_dataset('commits') do |d|
      d.add_fact('lines_changed')
	    d.add_attribute('name', gd_data_type: 'INT')
      d.add_date('committed_on', :dataset => 'committed_on')
    end
  end
  # This is going to fail since we are trying to upload 1.2 into INT numeric type
  data = [['lines_changed', 'name', 'committed_on'],[1.2, 'tomas', '01/01/2001']]
  project.upload(data, blueprint, 'commits')
  # This is going to pass since we are trying to upload 1 into INT numeric type
  data = [['lines_changed', 'name', 'committed_on'],[1, 'tomas', '01/01/2001']]
  project.upload(data, blueprint, 'commits')
end