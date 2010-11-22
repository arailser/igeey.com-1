class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    @commentable = comment.commentable
    @commentable.update_attribute(:has_new_comment ,true)
    @commentable.update_attributes(:last_replied_user_id => comment.user.id,:last_replied_at => Time.now) if comment.commentable_type == 'Topic'
  end
  
  def before_validation(comment)
    comment.content = comment.content.strip
  end
end
