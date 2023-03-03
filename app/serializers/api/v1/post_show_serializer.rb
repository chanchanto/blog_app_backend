class Api::V1::PostShowSerializer < Api::V1::PostSerializer
  has_many :comments
end
