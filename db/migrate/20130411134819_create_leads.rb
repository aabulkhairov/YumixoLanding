class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
    	t.string :email
      t.string :country
      t.boolean :android
      t.boolean :windows_phone
      t.boolean :web_version
      t.timestamps
    end
  end
end
