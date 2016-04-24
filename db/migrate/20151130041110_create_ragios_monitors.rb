class CreateRagiosMonitors < ActiveRecord::Migration
  def change
    create_table :ragios_monitors do |t|
      t.string :title
      t.text :description
      t.string :url
      t.integer :hours, default: 0
      t.integer :minutes, default: 0
      t.string :ragiosid
      t.text :code
      t.string :monitor_type
      t.text :monitor_json
      t.integer :status, default: 0
      t.text :comment
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
