require 'rails_helper'

RSpec.describe User, type: :model do

 describe '登録処理テスト' do
  context '異常系' do
    it '名前が必須であること' do
      user = User.new(email: "test@example.com", password: "password")
      user.save
      expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
      it '31文字以上はバリデーションの発生すること' do
        max = 30
        name = "a" * (max + 1)
        user = User.new(email: "test@example.com", password: "password", name: name)
        user.save

        expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long'))
        
      end
    end
  end
end
