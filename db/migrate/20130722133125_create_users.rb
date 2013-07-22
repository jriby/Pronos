class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :passwd
      t.string :nom
      t.string :prenom
      t.string :mail
      t.boolean :valide
      t.integer :points

      t.timestamps
    end
  end
end
