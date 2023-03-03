class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at

  belongs_to :user
  has_many :tags, through: :taggings
end
