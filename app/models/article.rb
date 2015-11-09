class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def to_s
    name
  end

  def tag_list=(tags_string)
    logger.debug "tag string: #{tags_string.inspect}"
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

scope :tag, -> (tag) { where tag: tag }

end
