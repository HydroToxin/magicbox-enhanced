FactoryBot.define do
  factory :todo do
    todo_status { 'todo' }
    renotify_every_minute { 5 }
    date { Time.now }
    notified_date { Time.now }
    notify_email { true }
    body { 'some body' }
    notify { true }
    uuid { SecureRandom.uuid }
    association :user
  end
end