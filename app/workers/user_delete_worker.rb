class UserDeleteWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false, backtrace: true

  def perform(user_id, delete_option)
    user = User.find_by(user_id)
    if delete_option.downcase == "following"
      user.followed_users.each do |user|
        user.destroy
      end
    elsif delete_option.downcase == "followers"
      user.followers.each do |user|
        user.destroy
      end
    end
  end

end
