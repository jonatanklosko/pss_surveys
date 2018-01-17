module SurveysHelper
  def submitted_surveys_stats(surveys)
    submitted_count = surveys.count &:submitted?
    "#{submitted_count} (#{submitted_count * 100 / surveys.count}%)"
  end

  def competition_size_bonus_points(competitors_count)
    competitors_count.to_f / 500
  end

  def mean_rating_by_question(surveys, weighted:)
    surveys
      .flat_map(&:survey_answers)
      .group_by(&:survey_question)
      .map do |question, answers|
        sum = answers.sum { |answer| weighted ? answer.rating * answer.survey.weight : answer.rating }
        divisor = weighted ? answers.map(&:survey).sum(&:weight) : answers.count
        [question, sum.to_f / divisor]
      end
      .to_h
  end

  def mean(values)
    values.sum.to_f / values.count
  end

  def competition_surveys_data(competition)
    {}.tap do |data|
      delegate_surveys, competitor_surveys = competition.surveys.partition &:delegate?
      data[:competitors_rating_by_question] = mean_rating_by_question competitor_surveys, weighted: true
      data[:delegates_rating_by_question] = mean_rating_by_question delegate_surveys, weighted: false
      data[:competition_size_bonus_points] = competition_size_bonus_points competition.competitors_count
      data[:competitors_mean_rating] = mean data[:competitors_rating_by_question].values
      data[:delegates_mean_rating] = mean data[:delegates_rating_by_question].values
      data[:total_rating] = mean([*data[:competitors_rating_by_question].values, data[:delegates_mean_rating]]) + data[:competition_size_bonus_points]
    end
  end

  def format_number(number)
    "%0.2f" % number
  end

  def rating_badge(rating)
    badge_type = case rating
                 when 9..10
                   "success"
                 when 7...9
                   "primary"
                 when 4...7
                   "warning"
                 when 0...4
                   "danger"
                 end
    content_tag :span, format_number(rating), class: "badge badge-#{badge_type} rating-badge"
  end
end
