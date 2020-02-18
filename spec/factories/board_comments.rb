FactoryBot.define do
  factory :boardcomment do
    board_id {'1'} 
    comment {'test_comment'}
    commentator {'user_a'}
  end
end
