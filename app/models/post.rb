class Post < ActiveRecord::Base
  belongs_to :user #foreign key user_id
  validates_presence_of :content #needs to have content
end
