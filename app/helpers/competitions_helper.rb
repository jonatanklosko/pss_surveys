module CompetitionsHelper
  def surveys_count_badge(surveys)
    submitted = surveys.count(&:submitted?)
    total = surveys.count
    badge_type = if submitted == total
                   "success"
                 elsif submitted.to_f / total < 0.2
                   "danger"
                 elsif submitted.to_f / total < 0.5
                   "warning"
                 else
                   "info"
                 end
    content_tag :span, "#{submitted} z #{total}", class: "badge badge-#{badge_type}"
  end
end
