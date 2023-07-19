# frozen_string_literal: true

class ForumCommentNotification < Noticed::Base
  deliver_by :database, association: :noticed_notifications

  # @return [String] returns the message to be displayed
  def message
    # @type [User]
    user = params[:user]
    # post = params[:forum_post]
    thread = params[:forum_thread]
    t("users.notifications.comment_notif", user: user.name, thread: thread.title) # , mssg: post.body.truncate_words(4))
  end

  # @return [String] returns the fontawesome icon for the forum comment notification
  def icon
    "far fa-comment"
  end
end
