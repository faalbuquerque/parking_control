# frozen_string_literal: true

# This model gives base mongoid functions to specific models
class ModelBase
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer, default: 0

  before_create :update_id_incremental

  private

  def update_id_incremental
    return self.id = self.class.last.id + 1 unless self.class.last.nil?

    self.id = self.class.count + 1
  end
end
