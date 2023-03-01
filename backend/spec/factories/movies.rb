FactoryBot.define do
  factory :movie do
    title {'インターステラー'}
    image_path {'example_path'}
    director {'クリストファー・ノーラン'}
    evaluation {5}
    release_at {'2010-01-01'}
    viewing_at {'2018-01-01'}
    review {'最高だった！'}
    association :user
  end
end
