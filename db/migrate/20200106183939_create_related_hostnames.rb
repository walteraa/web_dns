# frozen_string_literal: true

class CreateRelatedHostnames < ActiveRecord::Migration[5.2]
  def change
    create_table :related_hostnames do |t|
      t.string :hostname

      t.timestamps
    end
  end
end
