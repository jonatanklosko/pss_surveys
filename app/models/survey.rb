class Survey < ApplicationRecord
  belongs_to :competition

  after_initialize :set_secret_id

  private def set_secret_id
    self.secret_id = SecureRandom.uuid
  end
end
