class Bots < ActiveRecord::Migration
  def change
    create_table "bots", force: :cascade do |t|
      t.string "user_token", limit: 255
      t.string "user_id",    limit: 255
      t.string "team",       limit: 255
      t.string "team_id",    limit: 255
      t.string "bot_id",     limit: 255
      t.string "bot_token",  limit: 255
    end
  end
end
