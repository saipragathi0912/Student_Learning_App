class ChapterSerializer < ActiveModel::Serializer
    attributes :name
    has_many :contents
end
