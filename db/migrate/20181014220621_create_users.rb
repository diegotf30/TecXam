class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "name"
      t.string "gender"
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      # Confirmable
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      # Lockable
      t.integer "failed_attempts", default: 0, null: false
      t.string "unlock_token"
      t.datetime "locked_at"
      # Rememberable
      t.datetime "remember_created_at"
      # Trackable
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip", limit: 255
      t.string "last_sign_in_ip", limit: 255
      t.integer "sign_in_count", default: 0, null: false
      # Recoverable
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"

      t.timestamps
      t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true
      t.index ["email"], name: "index_members_on_email", unique: true
      t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
      t.index ["unlock_token"], name: "index_members_on_unlock_token", unique: true
    end
  end
end
