class Api::V1::TagSerializer < ActiveModel::Serializer
  attributes :id, :tag_name
end
