module Backend::Concerns::Services::Protectable
  extend ActiveSupport::Concern

  def protected_status?(status)
    [
      protect_after_logged_in?(status),
      protect_before_collect_from?(status),
      protect_after_collect_to?(status),
      protect_reply_status?(status),
      protect_favorited_status?(status),
    ].any?
  end

  # ログイン後のツイートを保護する
  def protect_after_logged_in?(status)
    return false if protect_parameter.signedin_at.blank?
    Time.zone.parse(status[:created_at]) >= protect_parameter.signedin_at
  end

  # 対象期間より古いツイートを保護する
  def protect_before_collect_from?(status)
    return false if protect_parameter.collect_from.blank?
    Time.zone.parse(status[:created_at]) > protect_parameter.collect_from
  end

  # 対象期間より新しいツイートを保護する
  def protect_after_collect_to?(status)
    return false if protect_parameter.collect_to.blank?
    Time.zone.parse(status[:created_at]) <= protect_parameter.collect_to
  end

  # リプライを保護する
  def protect_reply_status?(status)
    return false if protect_parameter.protect_reply.blank?
    status[:in_reply_to_user_id].present?
  end

  # お気にいりを保護する
  def protect_favorited_status?(status)
    return false if protect_parameter.protect_favorite.blank?
    status[:favorite_count] > 0
  end
end
