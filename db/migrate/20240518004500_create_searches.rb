class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.text :search
      t.string :ip

      t.timestamps
    end
  end
end
