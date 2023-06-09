class Post < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments
  has_many :bookmarks

  def tag_list
    self.tags.collect do |tag|
      tag.tag_name
    end.join(",")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect{ |name| Tag.find_or_create_by(tag_name: name) }
    self.tags = new_or_found_tags
  end
end
