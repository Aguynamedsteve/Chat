class AddTranslatedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :translated, :string
  end
end
