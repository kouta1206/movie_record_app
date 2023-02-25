# frozen_string_literal: true

class AddRefreshJtiUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :refresh_jti, :string
  end
end
