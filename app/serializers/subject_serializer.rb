class SubjectSerializer < ActiveModel::Serializer
    attributes :name, :progress
    has_many :chapters
end
