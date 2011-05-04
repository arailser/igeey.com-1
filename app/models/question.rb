class Question < ActiveRecord::Base
  belongs_to :user
  has_many   :answers
  has_many   :notifications, :as => :notifiable, :dependent => :destroy
  
  acts_as_taggable
  acts_as_ownable
  
  default_scope :order => 'last_answered_at DESC'
  
  validates :title,:length => {:minimum => 1 ,:message => '问题要有起码的字数吧？'}
  validates :user_id,:title,:presence => true
  
  def venue_id
    nil
  end
  
end
