class CreateSchema < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.integer :creator_id

      t.timestamps
    end

    create_table :questions do |t|
      t.text :content
      t.references :survey

      t.timestamps
    end

    create_table :answers do |t|
      t.references :user
      t.references :possible_choice

      t.timestamps
    end

    create_table :possible_choices do |t|
      t.string :content
      t.references :question
      t.integer :times_chosen, default: 0

      t.timestamps
    end

    create_table :completed_surveys do |t|
      t.references :user
      t.references :survey

      t.timestamps
    end
  end
end
