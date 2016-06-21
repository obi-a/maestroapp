class CreateEmailNotifiers < ActiveRecord::Migration
  def change
    create_table :email_notifiers do |t|
      t.belongs_to :user, index:true
      t.belongs_to :ragios_monitor, index:true
      t.string :email
      t.boolean :verified, null: false, default: false
      t.timestamps null: false
    end
  end
end
