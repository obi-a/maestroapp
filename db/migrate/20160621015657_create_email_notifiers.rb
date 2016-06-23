class CreateEmailNotifiers < ActiveRecord::Migration
  def change
    create_table :email_notifiers do |t|
      t.belongs_to :user, index:true
      t.belongs_to :ragios_monitor, index:true
      t.string :email
      t.boolean :verified, null: false, default: false
      t.string :verification_token

      t.timestamps null: false
      t.index :verification_token, unique: true
    end
  end
end
