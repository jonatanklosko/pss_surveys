class User < ApplicationRecord
  has_and_belongs_to_many :organized_competitions, class_name: "Competition", join_table: "competitions_organizers",
                                                   foreign_key: :organizer_id

  def self.find_or_initialize_from_wca_data(user_json_data)
    user_json_data.deep_symbolize_keys!
    User.find_or_initialize_by(wca_user_id: user_json_data[:id]).tap do |user|
      user.wca_id = user_json_data[:wca_id]
      user.name = user_json_data[:name]
      user.avatar_thumb_url = user_json_data[:avatar][:thumb_url]
    end
  end

  def admin?
    %w(2013KOSK01 2007POLK01 2011SZAT01 2012TRZA01 2012DROZ02 2014PACE01).include? wca_id
  end
end
