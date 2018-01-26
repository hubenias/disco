class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      # NOTE: location does not seems very meaningful as well as full_name but
      # we need something to work with
      t.string :location

      t.timestamps
    end
  end
end
