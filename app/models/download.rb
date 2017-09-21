class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_upload

  scope :awaiting_approval, -> { where(apporve: nil) }
end
