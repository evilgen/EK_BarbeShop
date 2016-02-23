class CreateContacts < ActiveRecord::Migration
  def change

	create_table :contacts do |t|
  		t.text :email
  		t.text :letter

  		t.timestamps
  	end


  end
end
