# frozen_string_literal: true

class Page < ApplicationRecord
  validate :json_parse

  private

  def json_parse
    JSON.parse(page_data)
  rescue JSON::ParserError
    errors.add(:page_data, 'JSON invalid.')
  end
end
