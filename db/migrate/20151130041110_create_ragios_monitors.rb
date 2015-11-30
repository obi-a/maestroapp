class CreateRagiosMonitors < ActiveRecord::Migration
  def change
    create_table :ragios_monitors do |t|
      t.string :title
      t.text :description
      t.string :url
      t.decimal :duration
      t.string :contact
      t.string :ragiosid
      t.string :type
      t.text :code
      t.string :type
      t.text :monitor_json
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
