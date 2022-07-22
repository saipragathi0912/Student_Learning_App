FactoryBot.define do
    factory :content do
      name {Faker::Lorem.words(3)}
      content "Video/video_1.mp4"
      watched false
      description {Faker::Lorem.paragraph}
      upvote false
      downvote false
      notes {Faker::Lorem.paragraph}
      content_type "mp4"
    end
  end
  