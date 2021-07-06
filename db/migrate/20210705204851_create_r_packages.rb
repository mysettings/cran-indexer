# frozen_string_literal: true

class CreateRPackages < ActiveRecord::Migration[6.1]
  def change
    create_table :r_packages, id: :uuid do |t|
      t.string :name
      t.string :version
      t.datetime :published_at
      t.string :title
      t.text :description
      t.jsonb :authors
      t.jsonb :maintainers

      t.timestamps
    end
  end
end
