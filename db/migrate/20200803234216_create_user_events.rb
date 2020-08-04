class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events do |t|
      t.numeric :user_id
      t.numeric :event_id

      t.timestamps
    end
  end
end
