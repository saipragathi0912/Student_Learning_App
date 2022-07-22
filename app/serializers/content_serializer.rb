class ContentSerializer < ActiveModel::Serializer
  attributes :name,:content,:watched,:description,:upvote,:downvote,:notes,:content_type,:id
end
